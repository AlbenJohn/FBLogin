//
//  ViewController.swift
//  FBLogin
//
//  Created by Apple on 12/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    @IBOutlet weak var FBButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loginview:FBSDKLoginButton = FBSDKLoginButton()
//        loginview.delegate = self
//        loginview.center = self.view.center
//        self.view.addSubview(loginview)
//        
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        activityIndicator.color = UIColor.lightGray
        view.addSubview(activityIndicator)
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        if let accessToken = FBSDKAccessToken.current(){
            print(accessToken)
            activityIndicator.startAnimating()
            FBButton.isHidden = true
            self.getFBUserData()
            
            
        }else{
            print("Not logged In.")
            activityIndicator.stopAnimating()

            FBButton.isHidden = false
            
        }

    }
    @IBAction func FaceLogin(_ sender: Any) {
        
       // getFacebookUserInfo();
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
            else if (result?.isCancelled)!{
                print("User cancled Login")
            }
        }
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            self.activityIndicator.startAnimating()
            FBButton.isHidden = true

            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){

                    //everything works print the user data
                    print(result ?? "null")
                    let info = result as! [String : AnyObject]
                    if(result != nil){

                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! Detailviewcontroller
                    myVC.NameString = info["name"] as! String
                    self.navigationController?.present(myVC, animated: true)
                    }
                }else
                {
                    self.FBButton.isHidden = false
                    print(error?.localizedDescription ?? "null")


                }
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            print(error.localizedDescription)
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)

        loginManager.logOut()
    }
    



}

