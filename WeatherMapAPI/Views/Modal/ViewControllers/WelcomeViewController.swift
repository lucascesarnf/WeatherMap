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
  
  var loading:UIActivityIndicatorView = UIActivityIndicatorView()
  let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  override func viewDidLoad() {
    //Loading
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
    //************
    nameLabel.text = ""
    //Get user info
    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name"]).start(completionHandler: { (connection, result, error) -> Void in
      if (error == nil){
        let fbDetails = result as! NSDictionary
        self.nameLabel.text = fbDetails.value(forKey: "first_name") as? String
        self.startView()
      }else{
        print(error?.localizedDescription ?? "Not found")
        self.startView()
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
