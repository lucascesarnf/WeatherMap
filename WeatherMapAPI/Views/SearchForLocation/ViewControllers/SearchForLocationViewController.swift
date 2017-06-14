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

class SearchForLocationViewController: UIViewController ,FBSDKLoginButtonDelegate,CLLocationManagerDelegate{
  
  
  @IBOutlet weak var loginButton: FBSDKLoginButton!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  var locationManager: CLLocationManager!
  var weather : Weather?
  
    override func viewDidLoad() {
  
      super.viewDidLoad()
      
      if (CLLocationManager.locationServicesEnabled())
      {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
      }
      loginButton.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  // MARK: - Facebook Logout
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    performSegue(withIdentifier: "segueForLogin", sender: self)
  }
  
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
  }
  
  // MARK: Get user Location
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
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
            self.tempLabel.text = "Temperatura :" + temp + " ˚C"
          
           self.iconImage.image = UIImage(named: icon)
          
          if icon.contains("d"){
            //self.view.backgroundColor = UIColor(colorLiteralRed: 102, green: 204, blue: 255, alpha: 1)
          }else{
            //self.view.backgroundColor = UIColor(colorLiteralRed: 86, green: 158, blue: 189, alpha: 1)
          }
        }
      }
    })
 }
}
