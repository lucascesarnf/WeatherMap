//
//  Weather.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 13/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

class Weather{
  
  var city : String = ""
  var country : String = ""
  var description : String = ""
  var main : String = ""
  var icon : String = ""
  var temp: String = ""
  
  init(json: [String: AnyObject]) {
    /*if let city1 = String(describing: json["name"]), let country1 = String(describing: json["sys"]?["country"]), let description1 = String(describing: (json["weather"]?[0] as AnyObject)["description"]), let main1 = String(describing: (json["weather"]?[0] as AnyObject)["main"]), let icon1 = String(describing: (json["weather"]?[0] as AnyObject)["icon"]), let tempK1 = Double(String(describing: json["main"]?["temp"])){
    }
    */
    if let city1 = json["name"] as? String{
     self.city = city1
    }
    
    if let country1 = json["sys"]?["country"] as? String{
      self.country = country1
    }
    
    if let temp1 = json["main"]?["temp"] as? Double {
      let tempC = temp1 - 273.15
      let tempString: String = String(format:"%.0f", tempC)
      self.temp = tempString
    }
    
    if let icon1 = (json["weather"]?[0] as AnyObject)["icon"] as? String{
      self.icon = icon1
    }
    
    if let description1 = (json["weather"]?[0] as AnyObject)["description"] as? String{
      self.description = description1
    }
    /*let country1 = json["sys"]?["country"] as? String, let description1 = (json["weather"]?[0] as AnyObject)["description"] as? String, let main1 = (json["weather"]?[0] as AnyObject)["main"] as? String, let icon1 =  (json["weather"]?[0] as AnyObject)["icon"] as? String, let temp1 = json["main"]?["temp"] as? String {
      self.city = city1
      self.country = country1
      self.description = description1
      self.main = main1
      self.icon = icon1
      self.temp = temp1
      if let tempK = Double(temp1){
      let tempC = tempK - 273.15
      let tempToString: String = String(format:"%f", tempC)
      self.temp = tempToString
      }
    }*/
    
  }
  
}
