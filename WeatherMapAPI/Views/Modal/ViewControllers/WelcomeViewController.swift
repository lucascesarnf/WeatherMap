//
//  WelcomeViewController.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 12/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class WelcomeViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  
    override func viewDidLoad() {
      nameLabel.text = ""
      //Get user info
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          let fbDetails = result as! NSDictionary
          self.nameLabel.text = fbDetails.value(forKey: "first_name") as? String
        }else{
          print(error?.localizedDescription ?? "Not found")
        }
      })
      super.viewDidLoad()
    }

  @IBAction func actionButton(_ sender: Any)
  {
     performSegue(withIdentifier: "segueForMenu", sender: self)
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
