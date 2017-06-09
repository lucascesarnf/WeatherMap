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

   @IBOutlet weak var loginButton: FBSDKLoginButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      loginButton.delegate = self
      loginButton.readPermissions = ["public_profile","email","user_friends"];
      
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
    
    if let accessToken = FBSDKAccessToken.current(){
      print(accessToken.userID)
    }
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
    }
    //Get user info
    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
      if (error == nil){
        let fbDetails = result as! NSDictionary
        print(fbDetails)
      }else{
        print(error?.localizedDescription ?? "Not found")
      }
    })
  }
  
  

}

 // MARK: -Orientation
