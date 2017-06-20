//
//  SearchForLocationViewController.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 12/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreLocation

class SearchForLocationViewController: UIViewController , CLLocationManagerDelegate{
  
  
  var timeout: Timer = Timer()
  var loading:UIActivityIndicatorView = UIActivityIndicatorView()
  let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  @IBOutlet weak var logoutButton: UIButton!
  
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  var locationManager: CLLocationManager = CLLocationManager()
  
  var weather : Weather?
  
  override func viewDidLoad() {
    //Loading :
    visualEffectView.frame = view.bounds
    view.addSubview(visualEffectView)
    loading.center = self.view.center
    loading.hidesWhenStopped = false
    loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    loading.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
    loading.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
    loading.color = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
    view.addSubview(loading)
    stopView()
    super.viewDidLoad()
    locationAuthorizationStatus()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    determineCurrentLocation()
  }
  
  func determineCurrentLocation()
  {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationAuthorizationStatus()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func logoutButtonClicked(_ sender: Any) {
    
    let alert = UIAlertController(title: "Sair do app", message: "Tem Certeza que  deseja sair?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
      print("Cancel")}))
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      switch action.style{
      case .default:
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.segueForLogin()
      case .cancel:
        print("cancel")
        
      case .destructive:
        print("destructive")
      }
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: Get user Location
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    stopView()
    
    let userLocation:CLLocation = locations[0] as CLLocation
    
    manager.stopUpdatingLocation()
    let latitude = String(userLocation.coordinate.latitude)
    let longitude = String(userLocation.coordinate.longitude)
    print("\n\nlocations = " + latitude + longitude + "\n\n")
    Service.sharedInstance.getUserLocation(latitude:latitude, longitude:longitude, completion: { (json) -> Void in
      DispatchQueue.main.async(){
        self.weather = Weather(json: json)
        
        if let temp = self.weather?.temp, let city = self.weather?.city, let country = self.weather?.country , let icon = self.weather?.icon{
          self.cityLabel.text = city + " - " + country
          self.tempLabel.text = "Temperatura :" + temp + "˚C"
          
          self.iconImage.image = UIImage(named: icon)
          
          if icon.contains("d"){
            
            self.view.backgroundColor = self.hexStringToUIColor(hex: "66CCFF")
            self.logoutButton.backgroundColor = self.hexStringToUIColor(hex: "EDE219")
            
          }else{
            
            self.view.backgroundColor = self.hexStringToUIColor(hex: "2E596C")
            self.logoutButton.backgroundColor = self.hexStringToUIColor(hex: "F29F26")
            
          }
        }
        self.startView()
      }
    })
    UIApplication.shared.endIgnoringInteractionEvents()
  }
  func segueForLogin(){
    performSegue(withIdentifier: "segueForLogin", sender: self)
  }
  //Verify Location permission
  
  func locationAuthorizationStatus(){
    stopView()
    //check if location services are enabled at all
    if CLLocationManager.locationServicesEnabled() {
      
      locationManager.startUpdatingHeading()
      locationManager.startUpdatingLocation()
      
      switch(CLLocationManager.authorizationStatus()) {
      //check if services disallowed for this app particularly
      case .restricted, .denied:
        print("No access")
        
        notAuthorization()
        
      //check if services are allowed for this app
      case .authorizedAlways, .authorizedWhenInUse:
        print("Access! We're good to go!")
      case .notDetermined:
        print("asking for access...")
         notAuthorization()
      }
      //location services are disabled on the device entirely!
    } else {
      print("Location services are not enabled")
      notAuthorization()
    }
    startView()
  }
  
  func notAuthorization(){
    self.iconImage.image = UIImage(named: Main.sharedInstance.notFoundImage)
    self.cityLabel.text = Main.sharedInstance.locationNotFoundText1
    self.tempLabel.text = Main.sharedInstance.locationNotFoundText2
    self.view.backgroundColor = self.hexStringToUIColor(hex: "66CCFF")
    self.logoutButton.backgroundColor = self.hexStringToUIColor(hex: "EDE219")
    startView()
  }
  //Convert String Hex in color
  func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  func stopView(){
    loading.startAnimating()
    loading.isHidden = false
    self.visualEffectView.isHidden = false
    UIApplication.shared.beginIgnoringInteractionEvents()
  }
  
  func startView(){
    loading.stopAnimating()
    loading.isHidden = true
    self.visualEffectView.isHidden = true
    UIApplication.shared.endIgnoringInteractionEvents()
  }
}
