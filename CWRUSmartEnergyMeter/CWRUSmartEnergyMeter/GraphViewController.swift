//
//  FirstViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 3/22/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var selectStartDateButton: UIButton!
    @IBOutlet weak var selectEndDateButton: UIButton!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var resolution10SecButton: UIButton!
    @IBOutlet weak var resolution1MinButton: UIButton!
    @IBOutlet weak var resolution1HrButton: UIButton!
    @IBOutlet weak var measurementAvgButton: UIButton!
    @IBOutlet weak var measurementTotalButton: UIButton!
    @IBOutlet weak var measurementPeakButton: UIButton!
    @IBOutlet weak var measurementLabel: UILabel!
    
    func startDatePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: startDatePicker.date)
        startDatePicker.isHidden = true
        selectStartDateButton.setTitle(strDate, for: UIControlState())
        print(strDate)
        endDateLabel.isHidden = false
        selectEndDateButton.isHidden = false
        resolutionLabel.isHidden = false
        measurementLabel.isHidden = false
        resolution1MinButton.isHidden = false
        resolution10SecButton.isHidden = false
        resolution1HrButton.isHidden = false
        measurementPeakButton.isHidden = false
        measurementTotalButton.isHidden = false
        measurementAvgButton.isHidden = false
    }
    
    func endDatePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: endDatePicker.date)
        endDatePicker.isHidden = true
        selectEndDateButton.setTitle(strDate, for: UIControlState())
        print(strDate)
        resolutionLabel.isHidden = false
        measurementLabel.isHidden = false
        resolution1MinButton.isHidden = false
        resolution10SecButton.isHidden = false
        resolution1HrButton.isHidden = false
        measurementPeakButton.isHidden = false
        measurementTotalButton.isHidden = false
        measurementAvgButton.isHidden = false
    }
    
    @IBAction func selectStartDateClicked(_ sender: UIButton) {
        startDatePicker.isHidden = false
        endDateLabel.isHidden = true
        selectEndDateButton.isHidden = true
        resolutionLabel.isHidden = true
        measurementLabel.isHidden = true
        resolution1MinButton.isHidden = true
        resolution10SecButton.isHidden = true
        resolution1HrButton.isHidden = true
        measurementPeakButton.isHidden = true
        measurementTotalButton.isHidden = true
        measurementAvgButton.isHidden = true
    }

    @IBAction func selectEndDateClicked(_ sender: UIButton) {
        endDatePicker.isHidden = false
        resolutionLabel.isHidden = true
        measurementLabel.isHidden = true
        resolution1MinButton.isHidden = true
        resolution10SecButton.isHidden = true
        resolution1HrButton.isHidden = true
        measurementPeakButton.isHidden = true
        measurementTotalButton.isHidden = true
        measurementAvgButton.isHidden = true
    }
    
    @IBAction func resolution10SecClicked(_ sender: UIButton) {
        resolution10SecButton.titleLabel?.textColor = UIColor.blue
        resolution1MinButton.titleLabel?.textColor = UIColor.lightGray
        resolution1HrButton.titleLabel?.textColor = UIColor.lightGray
        print("clicked")
    }
    
    @IBAction func resolution1MinClicked(_ sender: UIButton) {
        resolution10SecButton.titleLabel?.textColor = UIColor.lightGray
        resolution1MinButton.titleLabel?.textColor = UIColor.blue
        resolution1HrButton.titleLabel?.textColor = UIColor.lightGray
        print("clicked")
    }

    @IBAction func resolution1HrClicked(_ sender: UIButton) {
        resolution10SecButton.titleLabel?.textColor = UIColor.lightGray
        resolution1MinButton.titleLabel?.textColor = UIColor.lightGray
        resolution1HrButton.titleLabel?.textColor = UIColor.blue
        print("clicked")
    }
    
    @IBAction func measurementAvgClicked(_ sender: UIButton) {
        measurementAvgButton.titleLabel?.textColor = UIColor.blue
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
    }
    
    @IBAction func measurementTotalClicked(_ sender: UIButton) {
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.blue
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
    }
    
    @IBAction func measurementPeakButton(_ sender: UIButton) {
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.blue
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up date pickers
        startDatePicker.addTarget(self, action: #selector(GraphViewController.startDatePickerChanged(_:)), for: UIControlEvents.valueChanged)
        endDatePicker.addTarget(self, action: #selector(GraphViewController.endDatePickerChanged(_:)), for: UIControlEvents.valueChanged)
        
        // Download json data
        let requestURL: URL = URL(string: "http://localhost:5000/GetNumRecords")!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everything is fine, file downloaded successfully.")
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    print(json)
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        task.resume()
        
        let requestURLGlennan: URL = URL(string: "http://localhost:5000/GetBuildingData?building=GLENNAN")!
        let urlRequestGlennan: URLRequest = URLRequest(url: requestURLGlennan)
        let sessionGlennan = URLSession.shared
        let taskGlennan = sessionGlennan.dataTask(with: urlRequestGlennan) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everything is fine, file downloaded successfully.")
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    print(json)
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        taskGlennan.resume()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set up button colors
        resolution10SecButton.titleLabel?.textColor = UIColor.lightGray
        resolution1MinButton.titleLabel?.textColor = UIColor.lightGray
        resolution1HrButton.titleLabel?.textColor = UIColor.lightGray
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
    }
    

}

