//
//  FirstViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 3/22/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit
import Charts

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
    @IBOutlet weak var lineChartView: LineChartView!
    
    var lineChartDataSets : [LineChartDataSet] = []
    
    func setChart(dataPoints: [String], values: [Double], chartLabel: String, color: UIColor) {
        lineChartView.noDataText = "Must provide data"
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: chartLabel)
        lineChartDataSet.circleRadius = 2
        lineChartDataSet.circleColors = [color]
        lineChartDataSet.colors = [color]
        lineChartDataSets.append(lineChartDataSet)
    }
    
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
        
        downloadBuildingData(urlName: "Glennan", displayName: "Glennan", displayColor: UIColor.cyan)
        downloadBuildingData(urlName: "Nord", displayName: "Nord", displayColor: UIColor.red)
        downloadBuildingData(urlName: "Olin_480", displayName: "Olin 480", displayColor: UIColor.purple)
        downloadBuildingData(urlName: "Olin_208", displayName: "Olin 208", displayColor: UIColor.green)
        downloadBuildingData(urlName: "Rock_480", displayName: "Rock 480", displayColor: UIColor.blue)
        downloadBuildingData(urlName: "Sears_480", displayName: "Sears 480", displayColor: UIColor.yellow)
        downloadBuildingData(urlName: "Sears_208", displayName: "Sears 208", displayColor: UIColor.lightGray)
        downloadBuildingData(urlName: "Tomlinson", displayName: "Tomlinson", displayColor: UIColor.darkGray)
        downloadBuildingData(urlName: "White", displayName: "White", displayColor: UIColor.blue)
        downloadBuildingData(urlName: "Wick_208", displayName: "Wick 208", displayColor: UIColor.magenta)
        downloadBuildingData(urlName: "Wick_480", displayName: "Wick 480", displayColor: UIColor.orange)
        downloadBuildingData(urlName: "Yost", displayName: "Yost", displayColor: UIColor.cyan)
        downloadBuildingData(urlName: "Olin_Sum", displayName: "Olin (Sum)", displayColor: UIColor.red)
        downloadBuildingData(urlName: "Wick_Sum", displayName: "Wick (Sum)", displayColor: UIColor.purple)
        downloadBuildingData(urlName: "Sears_Sum", displayName: "Sears (Sum)", displayColor: UIColor.green)
        
        let lineChartData = LineChartData(dataSets: lineChartDataSets)
        lineChartData.setDrawValues(false)
        lineChartView.data = lineChartData
        lineChartView.backgroundColor = UIColor.white
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.leftAxis.axisMaximum = 235
        lineChartView.chartDescription?.text = ""

    }
    
    private func downloadBuildingData(urlName: String, displayName: String, displayColor: UIColor) {
        let semaphore = DispatchSemaphore(value: 0);
        let requestURL: URL = URL(string: "http://localhost:5000/GetBuildingData?building=" + urlName)!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        let session = URLSession.shared
        print("hi")
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everything is fine, file downloaded successfully.")
                do{
                    
                    var json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : Any]
                    print(json)
                    let result = json["result"] as! String
                    let entryArray = result.components(separatedBy: " ")
                    var dataEntries : [Double] = []
                    var xVals : [String] = []
                    var i = 0
                    for entry in entryArray {
                        dataEntries.append(Double(entry)!)
                        xVals.append(String(i))
                        i += 1
                    }
                    self.setChart(dataPoints: xVals, values: dataEntries, chartLabel: displayName, color: displayColor)
                    semaphore.signal();
                    
                } catch {
                    print("Error with Json: \(error)")
                    semaphore.signal();
                }
            }
        }
        
        task.resume()
        semaphore.wait(timeout: .distantFuture);
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

