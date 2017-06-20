//
//  Main.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 16/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation
import UIKit

struct Main {
  
  var notFoundImage = "notFound"
  var cityNotFoundText = " Cidade não encontrada! "
  var locationNotFoundText1 = " Localização não encontrada "
  var locationNotFoundText2 = " Verifique suas configurações "
  static let sharedInstance = Main()
  
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
  
  func stringTreatment(str: String) -> String {
    var text = str
    text = text.replacingOccurrences(of: " ", with: "+")
    //let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
    /*
    if let escapedString = text.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
      text = escapedString
    }*/
    text = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    //let chars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ+".characters)
    //return String(text.characters.filter { chars.contains($0) })
    return text
  }
  
  
}
