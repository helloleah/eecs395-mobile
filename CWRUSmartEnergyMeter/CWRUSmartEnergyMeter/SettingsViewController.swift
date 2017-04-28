//
//  SecondViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 3/22/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sscButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://usg.case.edu/org/ssc/About")! as URL)
    }
    
    @IBAction func oosButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://case.edu/sustainability/")! as URL)
    }
    
    @IBAction func signOutButtonClicked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "settingsToSignIn", sender: self)
    }
    
}
