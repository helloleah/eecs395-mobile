//
//  AccountViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 4/3/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit

class AccountViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem?.title = "Back"
    }
    
}
