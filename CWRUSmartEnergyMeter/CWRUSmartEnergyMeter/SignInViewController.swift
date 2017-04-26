//
//  SignInViewController.swift
//  ChapterManager
//
//  Created by Leah Karasek on 4/26/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "15881272775-ev507np2pm4dqhknmghqo5gj90iegskl.apps.googleusercontent.com"
        print("view did load")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print(err)
        }
        else {
            self.performSegue(withIdentifier: "signIn", sender: self)
        }
    }
    
    @IBAction func signInSegue(_ segue : UIStoryboardSegue) {
    }
    
}
