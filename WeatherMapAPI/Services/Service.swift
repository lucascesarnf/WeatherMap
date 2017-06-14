//
//  Service.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 13/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation
import CoreLocation

struct Service {
  
  static let sharedInstance = Service()
  let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
  let apiKey = "&appid=9c268776f9e7795f2582e9480b349252"
  
  func getUserLocation(latitude:String,longitude:String , completion: @escaping (_ json : [String: AnyObject]) -> Void){
   
    let url = URL(string: baseURL + "lat=" + latitude + "&lon=" + longitude + apiKey)
    print ("\n\nURL:\(String(describing: url))\n\n")

    URLSession.shared.dataTask(with: url!, completionHandler: {
      (data, response, error) in
      if(error != nil){
        print("error:n\(String(describing: error))")
      }else{
        do{
        
          let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
          print("\n\n \(json)\n\n")
          completion(json)
          /*
          let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
          
          print("\n\nCidade:\(String(describing: json["name"]))-\(String(describing: json["sys"]?["country"]))\n Descrição:\(String(describing: (json["weather"]?[0] as AnyObject)["description"]))-\(String(describing: (json["weather"]?[0] as AnyObject)["main"]))||\(String(describing: (json["weather"]?[0] as AnyObject)["icon"]))\nTemperatura:\(String(describing: json["main"]?["temp"]))\n")
          */
        }catch let error as NSError{
          print(error)
        }
      }
    }).resume()
  
  }
  
}
