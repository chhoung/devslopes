//
//  ViewController.swift
//  devslopes
//
//  Created by 11ien on 3/29/17.
//  Copyright © 2017 11ien. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase


class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func facebookbtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
                print("Chuan: unable to authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true {
                print("Chuan: user cancelled Facebook authentication")
            }else{
                print("Chuan: sucessfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }

    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Chuan: Unable to authenticate with Firebase - \(error)")
                return
            }
            print("Chuan: Successfully authenticated with Firebase")
            
        })
    }
    
    
}

