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
  var loading:UIActivityIndicatorView = UIActivityIndicatorView()
   @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad() {
      loading.center = self.view.center
      loading.hidesWhenStopped = false
      loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
      loading.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5)
      loading.transform = CGAffineTransform(scaleX: 2,y: 2)
      loading.color = UIColor(colorLiteralRed: 0, green: 255, blue: 255, alpha: 1)
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
      performSegue(withIdentifier: "segueForMenu", sender: self)
    }
    loading.stopAnimating()
    loading.isHidden = true
    UIApplication.shared.endIgnoringInteractionEvents()
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
     performSegue(withIdentifier: "segueForWelcome", sender: self)
    }
  }
  
  

}

 // MARK: -Orientation
