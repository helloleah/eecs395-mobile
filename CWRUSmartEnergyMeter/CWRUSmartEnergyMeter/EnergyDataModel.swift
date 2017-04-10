//
//  EnergyDataModel.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 4/8/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import Foundation

protocol EnergyDataProtocol : class {
    func itemsDownloaded(items: NSArray)
}

class EnergyDataModel : NSObject {
    
    weak var delegate: EnergyDataProtocol!
    var data : NSMutableData = NSMutableData()
    let urlPath: String = "http://localhost:5000"
    
}
