//
//  SearchForCityViewController.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 19/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class SearchForCityViewController: UIViewController, UISearchBarDelegate {
  //Adicionar as views normalmente, depois tentar dar um ishidden nelas!!!!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  
  var loading:UIActivityIndicatorView = UIActivityIndicatorView()
  let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  var weather : Weather?
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var searchBar: UISearchBar!
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchForCityViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    //Loaging
    visualEffectView.frame = view.bounds
    view.addSubview(visualEffectView)
    visualEffectView.isHidden = true
    loading.center = self.view.center
    loading.hidesWhenStopped = false
    loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    loading.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
    loading.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
    loading.color = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
    view.addSubview(loading)
    loading.isHidden = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    view.endEditing(true)
    stopView()
    if let str = searchBar.text {
      let text = Main.sharedInstance.stringTreatment(str: str)
      
      Service.sharedInstance.getCityLocation(city: text, completion: { (json) -> Void in
        DispatchQueue.main.async(){
          self.imageView.isHidden = true
          self.weather = Weather(json: json)
          if let cod = self.weather?.cod{
            if cod == 0{
              
              self.iconImage.image = UIImage(named: Main.sharedInstance.notFoundImage)
              self.cityLabel.text = Main.sharedInstance.cityNotFoundText
              self.tempLabel.text = ""
              self.view.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
              
            }else{
              
              if let temp = self.weather?.temp, let city = self.weather?.city, let country = self.weather?.country , let icon = self.weather?.icon{
                
                self.cityLabel.text = " " + city + " - " + country + " "
                self.tempLabel.text = "Temperatura :" + temp + "˚C"
                
                self.iconImage.image = UIImage(named: icon)
                
                if icon.contains("d"){
                  self.view.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
                }else{
                  self.view.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "2E596C")
                }
              }
              
            }
          }
          self.startView()
        }
      })
      UIApplication.shared.endIgnoringInteractionEvents()
    }
    
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
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
