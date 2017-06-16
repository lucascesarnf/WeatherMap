//
//  LoginViewController.swift
//  WeatherMapAPI
//
//  Created by Lucas César  Nogueira Fonseca on 09/06/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
  let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  var loading:UIActivityIndicatorView = UIActivityIndicatorView()
   @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad() {
      visualEffectView.frame = view.bounds
      view.addSubview(visualEffectView)
      loading.center = self.view.center
      loading.hidesWhenStopped = false
      loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
      loading.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
      loading.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
      loading.color = Main.sharedInstance.hexStringToUIColor(hex: "FB8E31")
      view.addSubview(loading)
      loading.startAnimating()
      UIApplication.shared.beginIgnoringInteractionEvents()
        super.viewDidLoad()
      loginButton.delegate = self
      loginButton.readPermissions = ["public_profile","email","user_friends"];
    }

  override func viewDidAppear(_ animated: Bool) {
    if (FBSDKAccessToken.current()) != nil{
      loading.stopAnimating()
      loading.isHidden = true
      UIApplication.shared.endIgnoringInteractionEvents()
      self.visualEffectView.removeFromSuperview()
      performSegue(withIdentifier: "segueForMenu", sender: self)
    }
    loading.stopAnimating()
    loading.isHidden = true
    UIApplication.shared.endIgnoringInteractionEvents()
    self.visualEffectView.removeFromSuperview()
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  }
  
  open override var shouldAutorotate: Bool {
    get {
      return false
    }
  }
  /**
   Sent to the delegate when the button was used to logout.
   - Parameter loginButton: The button that was clicked.
   */
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {

  }
  
  /**
   Sent to the delegate when the button was used to login.
   - Parameter loginButton: the sender
   - Parameter result: The results of the login
   - Parameter error: The error (if any) from the login
   */
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let accessToken = FBSDKAccessToken.current(){
      print(accessToken.userID)
      UIApplication.shared.endIgnoringInteractionEvents()
     performSegue(withIdentifier: "segueForWelcome", sender: self)
    }
  }
  
  

}

 // MARK: -Orientation
