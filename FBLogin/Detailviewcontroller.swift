//
//  Detailviewcontroller.swift
//  FBLogin
//
//  Created by Apple on 12/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin
import Foundation
class Detailviewcontroller: UIViewController {
    
    @IBOutlet weak var Name_Label: UILabel!
    var NameString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Name_Label.text = "Hello : \(NameString)"
        
}
    @IBAction func LogOutFB(_ sender: Any) {
        
                let loginManager: FBSDKLoginManager = FBSDKLoginManager()
                FBSDKAccessToken.setCurrent(nil)
                FBSDKProfile.setCurrent(nil)
                let accessToken = FBSDKAccessToken.current()
                print(accessToken ?? "Null")
                loginManager.logOut()

                self.dismiss(animated: true, completion: nil)


    }
}
