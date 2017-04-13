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

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passField: FancyField!
    
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
    
    @IBAction func signinTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let pwd = passField.text{
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Chuan: Email user authenticated with Firebase")
        }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Chuan: Unable to authenticate with Firebase user email")
                        }else{
                            print("Chuan: Sucessfully authenticated with Firebase")
                        }
                    })
                }
            })
            
        }
    }
    
    
    
    
}

