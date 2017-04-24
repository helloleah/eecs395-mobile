//
//  FirstViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 3/22/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit
import Charts

class BarGraphViewController: UIViewController {
    
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
    @IBOutlet weak var barChartView: BarChartView!
    
    var barChartDataEntries: [BarChartDataEntry] = []
    var glennanData: [Double] = []
    var nordData: [Double] = []
    var olin480Data: [Double] = []
    var olin208Data: [Double] = []
    var rock480Data: [Double] = []
    var sears480Data: [Double] = []
    var sears208Data: [Double] = []
    var tomlinsonData: [Double] = []
    var whiteData: [Double] = []
    var wick208Data: [Double] = []
    var wick480Data: [Double] = []
    var yostData: [Double] = []
    var olinSumData: [Double] = []
    var searsSumData: [Double] = []
    var wickSumData: [Double] = []
    var dataArrays : [[Double]] = []
    
    enum Measurement {
        case total, peak, average
    }
    
    func setChart(values: [Double], xVal: Double, measurement: Measurement) {
        if measurement == .total {
            var total = 0.0
            for val in values {
                total += val
            }
            let entry = BarChartDataEntry(x: xVal, y: total)
            barChartDataEntries.append(entry)
        }
        if measurement == .peak {
            let entry = BarChartDataEntry(x: xVal, y: values.max()!)
            barChartDataEntries.append(entry)
        }
        if measurement == .average {
            var total = 0.0
            for val in values {
                total += val
            }
            let avg = total / Double(values.count)
            let entry = BarChartDataEntry(x: xVal, y: avg)
            barChartDataEntries.append(entry)
        }
    }
    
    func setAllChartValues(measurement: Measurement) {
        setChart(values: glennanData, xVal: 0.0, measurement: measurement)
        setChart(values: nordData, xVal: 1.0, measurement: measurement)
        setChart(values: olin480Data, xVal: 2.0, measurement: measurement)
        setChart(values: olin208Data, xVal: 3.0, measurement: measurement)
        setChart(values: rock480Data, xVal: 4.0, measurement: measurement)
        setChart(values: sears480Data, xVal: 5.0, measurement: measurement)
        setChart(values: sears208Data, xVal: 6.0, measurement: measurement)
        setChart(values: tomlinsonData, xVal: 7.0, measurement: measurement)
        setChart(values: whiteData, xVal: 8.0, measurement: measurement)
        setChart(values: wick480Data, xVal: 9.0, measurement: measurement)
        setChart(values: wick208Data, xVal: 10.0, measurement: measurement)
        setChart(values: yostData, xVal: 11.0, measurement: measurement)
        setChart(values: olinSumData, xVal: 12.0, measurement: measurement)
        setChart(values: wickSumData, xVal: 13.0, measurement: measurement)
        setChart(values: searsSumData, xVal: 14.0, measurement: measurement)
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
        barChartDataEntries = []
        setAllChartValues(measurement: .average)
        let barChartDataSet = BarChartDataSet(values: barChartDataEntries, label: "Electrical Energy Usage (kW)")
        barChartDataSet.colors = ChartColorTemplates.colorful()
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setDrawValues(false)
        barChartView.data = barChartData
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 200
        self.barChartView.notifyDataSetChanged()
    }
    
    @IBAction func measurementTotalClicked(_ sender: UIButton) {
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.blue
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
        barChartDataEntries = []
        setAllChartValues(measurement: .total)
        let barChartDataSet = BarChartDataSet(values: barChartDataEntries, label: "Electrical Energy Usage (kW)")
        barChartDataSet.colors = ChartColorTemplates.colorful()
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setDrawValues(false)
        barChartView.data = barChartData
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 12000
        self.barChartView.notifyDataSetChanged()
    }
    
    @IBAction func measurementPeakButton(_ sender: UIButton) {
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.blue
        barChartDataEntries = []
        setAllChartValues(measurement: .peak)
        let barChartDataSet = BarChartDataSet(values: barChartDataEntries, label: "Electrical Energy Usage (kW)")
        barChartDataSet.colors = ChartColorTemplates.colorful()
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setDrawValues(false)
        barChartView.data = barChartData
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 300
        self.barChartView.notifyDataSetChanged()
        print("peak clicked")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up date pickers
        startDatePicker.addTarget(self, action: #selector(GraphViewController.startDatePickerChanged(_:)), for: UIControlEvents.valueChanged)
        endDatePicker.addTarget(self, action: #selector(GraphViewController.endDatePickerChanged(_:)), for: UIControlEvents.valueChanged)
        
        downloadBuildingData(urlName: "Glennan", dataArray: glennanData)
        downloadBuildingData(urlName: "Nord", dataArray: nordData)
        downloadBuildingData(urlName: "Olin_480", dataArray: olin480Data)
        downloadBuildingData(urlName: "Olin_208", dataArray: olin208Data)
        downloadBuildingData(urlName: "Rock_480", dataArray: rock480Data)
        downloadBuildingData(urlName: "Sears_480", dataArray: sears480Data)
        downloadBuildingData(urlName: "Sears_208", dataArray: sears208Data)
        downloadBuildingData(urlName: "Tomlinson", dataArray: tomlinsonData)
        downloadBuildingData(urlName: "White", dataArray: whiteData)
        downloadBuildingData(urlName: "Wick_208", dataArray: wick208Data)
        downloadBuildingData(urlName: "Wick_480", dataArray: wick480Data)
        downloadBuildingData(urlName: "Yost", dataArray: yostData)
        downloadBuildingData(urlName: "Olin_Sum", dataArray: olinSumData)
        downloadBuildingData(urlName: "Wick_Sum", dataArray: wickSumData)
        downloadBuildingData(urlName: "Sears_Sum", dataArray: searsSumData)
        
        // default is total
        setAllChartValues(measurement: .total)
    
        barChartView.noDataText = "Must provide data"
        let barChartDataSet = BarChartDataSet(values: barChartDataEntries, label: "Electrical Energy Usage (kW)")
        barChartDataSet.colors = ChartColorTemplates.colorful()
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setDrawValues(false)
        barChartView.data = barChartData
        barChartView.xAxis.labelPosition = .bottom
        let buildingNames = ["Glennan", "Nord", "Olin 480", "Olin 208", "Rock 480", "Sears 480", "Sears 208", "Tomlinson", "White", "Wick 208", "Wick 480", "Yost", "Olin Sum", "Wick Sum", "Sears Sum"]
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: buildingNames)
        barChartView.xAxis.granularity = 1
        barChartView.backgroundColor = UIColor.white
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 12000
        barChartView.chartDescription?.text = ""
        
    }
    
    private func downloadBuildingData(urlName: String, dataArray: [Double]) {
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
                    var dataEntries: [Double] = []
                    for entry in entryArray {
                        dataEntries.append(Double(entry)!)
                    }
                    switch urlName {
                        case "Glennan": self.glennanData.append(contentsOf: dataEntries)
                        case "Nord": self.nordData.append(contentsOf: dataEntries)
                        case "Olin_480": self.olin480Data.append(contentsOf: dataEntries)
                        case "Olin_208": self.olin208Data.append(contentsOf: dataEntries)
                        case "Rock_480": self.rock480Data.append(contentsOf: dataEntries)
                        case "Sears_480": self.sears480Data.append(contentsOf: dataEntries)
                        case "Sears_208": self.sears208Data.append(contentsOf: dataEntries)
                        case "Tomlinson": self.tomlinsonData.append(contentsOf: dataEntries)
                        case "White": self.whiteData.append(contentsOf: dataEntries)
                        case "Wick_208": self.wick208Data.append(contentsOf: dataEntries)
                        case "Wick_480": self.wick480Data.append(contentsOf: dataEntries)
                        case "Yost": self.yostData.append(contentsOf: dataEntries)
                        case "Olin_Sum": self.olinSumData.append(contentsOf: dataEntries)
                        case "Wick_Sum": self.wickSumData.append(contentsOf: dataEntries)
                        case "Sears_Sum": self.searsSumData.append(contentsOf: dataEntries)
                        default: print("No data array matches this building")
                    }
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

