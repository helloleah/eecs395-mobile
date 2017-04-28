//
//  PieChartViewController.swift
//  CWRUSmartEnergyMeter
//
//  Created by Leah Karasek on 4/28/17.
//  Copyright © 2017 Leah Karasek. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var selectStartDateButton: UIButton!
    @IBOutlet weak var selectEndDateButton: UIButton!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var measurementAvgButton: UIButton!
    @IBOutlet weak var measurementTotalButton: UIButton!
    @IBOutlet weak var measurementPeakButton: UIButton!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var glennanButton: UIButton!
    @IBOutlet weak var nordButton: UIButton!
    @IBOutlet weak var olin480Button: UIButton!
    @IBOutlet weak var olin208Button: UIButton!
    @IBOutlet weak var rock480Button: UIButton!
    @IBOutlet weak var sears480Button: UIButton!
    @IBOutlet weak var sears208Button: UIButton!
    @IBOutlet weak var tomlinsonButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var wick208Button: UIButton!
    @IBOutlet weak var wick480Button: UIButton!
    @IBOutlet weak var yostButton: UIButton!
    @IBOutlet weak var olinSumButton: UIButton!
    @IBOutlet weak var searsSumButton: UIButton!
    @IBOutlet weak var wickSumButton: UIButton!
    
    var pieChartDataEntries: [PieChartDataEntry] = []
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
    var currentMeasurement : Measurement = .total
    var glennanOn : Bool = true
    var nordOn : Bool = true
    var olin480On : Bool = true
    var olin208On : Bool = true
    var rock480On : Bool = true
    var sears480On : Bool = true
    var sears208On : Bool = true
    var tomlinsonOn : Bool = true
    var whiteOn : Bool = true
    var wick208On : Bool = true
    var wick480On : Bool = true
    var yostOn : Bool = true
    var olinSumOn : Bool = true
    var searsSumOn : Bool = true
    var wickSumOn : Bool = true
    
    enum Measurement {
        case total, peak, average
    }
    
    func setChart(values: [Double], xVal: Double, measurement: Measurement, label: String) {
        if measurement == .total {
            var total = 0.0
            for val in values {
                total += val
            }
            let entry = PieChartDataEntry(value: total, label: label)
            pieChartDataEntries.append(entry)
        }
        if measurement == .peak {
            let entry = PieChartDataEntry(value: values.max()!, label: label)
            pieChartDataEntries.append(entry)
        }
        if measurement == .average {
            var total = 0.0
            for val in values {
                total += val
            }
            let avg = total / Double(values.count)
            let entry = PieChartDataEntry(value: avg, label: label)
            pieChartDataEntries.append(entry)
        }
    }
    
    func setAllChartValues(measurement: Measurement) {
        setChart(values: glennanData, xVal: 0.0, measurement: measurement, label: "Glennan")
        setChart(values: nordData, xVal: 1.0, measurement: measurement, label: "Nord")
        setChart(values: olin480Data, xVal: 2.0, measurement: measurement, label: "Olin 480")
        setChart(values: olin208Data, xVal: 3.0, measurement: measurement, label: "Olin 208")
        setChart(values: rock480Data, xVal: 4.0, measurement: measurement, label: "Rock 480")
        setChart(values: sears480Data, xVal: 5.0, measurement: measurement, label: "Sears 480")
        setChart(values: sears208Data, xVal: 6.0, measurement: measurement, label: "Sears 208")
        setChart(values: tomlinsonData, xVal: 7.0, measurement: measurement, label: "Tomlinson")
        setChart(values: whiteData, xVal: 8.0, measurement: measurement, label: "White")
        setChart(values: wick480Data, xVal: 9.0, measurement: measurement, label: "Wick 480")
        setChart(values: wick208Data, xVal: 10.0, measurement: measurement, label: "Wick 208")
        setChart(values: yostData, xVal: 11.0, measurement: measurement, label: "Yost")
        setChart(values: olinSumData, xVal: 12.0, measurement: measurement, label: "Olin (Sum)")
        setChart(values: wickSumData, xVal: 13.0, measurement: measurement, label: "Wick (Sum)")
        setChart(values: searsSumData, xVal: 14.0, measurement: measurement, label: "Sears (Sum)")
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
        measurementLabel.isHidden = false
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
        measurementLabel.isHidden = false
        measurementPeakButton.isHidden = false
        measurementTotalButton.isHidden = false
        measurementAvgButton.isHidden = false
    }
    
    @IBAction func selectStartDateClicked(_ sender: UIButton) {
        startDatePicker.isHidden = false
        endDateLabel.isHidden = true
        selectEndDateButton.isHidden = true
        measurementLabel.isHidden = true
        measurementPeakButton.isHidden = true
        measurementTotalButton.isHidden = true
        measurementAvgButton.isHidden = true
    }
    
    @IBAction func selectEndDateClicked(_ sender: UIButton) {
        endDatePicker.isHidden = false
        measurementLabel.isHidden = true
        measurementPeakButton.isHidden = true
        measurementTotalButton.isHidden = true
        measurementAvgButton.isHidden = true
    }
    
    @IBAction func measurementAvgClicked(_ sender: UIButton) {
        currentMeasurement = .average
        measurementAvgButton.titleLabel?.textColor = UIColor.blue
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
        pieChartDataEntries = []
        resetChart()
        let pieChartDataSet = PieChartDataSet(values: pieChartDataEntries, label: "Electrical Energy Usage (kW)")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartView.data = pieChartData
        self.pieChartView.notifyDataSetChanged()
    }
    
    @IBAction func measurementTotalClicked(_ sender: UIButton) {
        currentMeasurement = .total
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.blue
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
        pieChartDataEntries = []
        resetChart()
        let pieChartDataSet = PieChartDataSet(values: pieChartDataEntries, label: "Electrical Energy Usage (kW)")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartView.data = pieChartData
        self.pieChartView.notifyDataSetChanged()
    }
    
    @IBAction func measurementPeakButton(_ sender: UIButton) {
        currentMeasurement = .peak
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.blue
        pieChartDataEntries = []
        resetChart()
        let pieChartDataSet = PieChartDataSet(values: pieChartDataEntries, label: "Electrical Energy Usage (kW)")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartView.data = pieChartData
        self.pieChartView.notifyDataSetChanged()
    }
    
    @IBAction func glennanButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !glennanOn {
            // selecting
            glennanButton.titleLabel?.textColor = UIColor.blue
            glennanOn = true
        }
        else {
            // deselecting
            glennanButton.titleLabel?.textColor = UIColor.lightGray
            glennanOn = false
        }
        resetChart()
    }
    
    @IBAction func nordButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !nordOn {
            // selecting
            nordButton.titleLabel?.textColor = UIColor.blue
            nordOn = true
        }
        else {
            // deselecting
            nordButton.titleLabel?.textColor = UIColor.lightGray
            nordOn = false
        }
        resetChart()
    }
    
    @IBAction func olin480ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !olin480On {
            // selecting
            olin480Button.titleLabel?.textColor = UIColor.blue
            olin480On = true
        }
        else {
            // deselecting
            olin480Button.titleLabel?.textColor = UIColor.lightGray
            olin480On = false
        }
        resetChart()
    }
    
    @IBAction func olin208ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !olin208On {
            // selecting
            olin208Button.titleLabel?.textColor = UIColor.blue
            olin208On = true
        }
        else {
            // deselecting
            olin208Button.titleLabel?.textColor = UIColor.lightGray
            olin208On = false
        }
        resetChart()
    }
    
    @IBAction func rock480ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !rock480On {
            // selecting
            rock480Button.titleLabel?.textColor = UIColor.blue
            rock480On = true
        }
        else {
            // deselecting
            rock480Button.titleLabel?.textColor = UIColor.lightGray
            rock480On = false
        }
        resetChart()
    }
    
    @IBAction func sears480ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !sears480On {
            // selecting
            sears480Button.titleLabel?.textColor = UIColor.blue
            sears480On = true
        }
        else {
            // deselecting
            sears480Button.titleLabel?.textColor = UIColor.lightGray
            sears480On = false
        }
        resetChart()
    }
    
    @IBAction func sears208ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !sears208On {
            // selecting
            sears208Button.titleLabel?.textColor = UIColor.blue
            sears208On = true
        }
        else {
            // deselecting
            sears208Button.titleLabel?.textColor = UIColor.lightGray
            sears208On = false
        }
        resetChart()
    }
    
    @IBAction func tomlinsonButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !tomlinsonOn {
            // selecting
            tomlinsonButton.titleLabel?.textColor = UIColor.blue
            tomlinsonOn = true
        }
        else {
            // deselecting
            tomlinsonButton.titleLabel?.textColor = UIColor.lightGray
            tomlinsonOn = false
        }
        resetChart()
    }
    
    @IBAction func whiteButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !whiteOn {
            // selecting
            whiteButton.titleLabel?.textColor = UIColor.blue
            whiteOn = true
        }
        else {
            // deselecting
            whiteButton.titleLabel?.textColor = UIColor.lightGray
            whiteOn = false
        }
        resetChart()
    }
    
    @IBAction func wick208ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !wick208On {
            // selecting
            wick208Button.titleLabel?.textColor = UIColor.blue
            wick208On = true
        }
        else {
            // deselecting
            wick208Button.titleLabel?.textColor = UIColor.lightGray
            wick208On = false
        }
        resetChart()
    }
    
    @IBAction func wick480ButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !wick480On {
            // selecting
            wick480Button.titleLabel?.textColor = UIColor.blue
            wick480On = true
        }
        else {
            // deselecting
            wick480Button.titleLabel?.textColor = UIColor.lightGray
            wick480On = false
        }
        resetChart()
    }
    
    @IBAction func yostButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !yostOn {
            // selecting
            yostButton.titleLabel?.textColor = UIColor.blue
            yostOn = true
        }
        else {
            // deselecting
            yostButton.titleLabel?.textColor = UIColor.lightGray
            yostOn = false
        }
        resetChart()
    }
    
    @IBAction func olinSumButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !olinSumOn {
            // selecting
            olinSumButton.titleLabel?.textColor = UIColor.blue
            olinSumOn = true
        }
        else {
            // deselecting
            olinSumButton.titleLabel?.textColor = UIColor.lightGray
            olinSumOn = false
        }
        resetChart()
    }
    
    @IBAction func searsSumButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !searsSumOn {
            // selecting
            searsSumButton.titleLabel?.textColor = UIColor.blue
            searsSumOn = true
        }
        else {
            // deselecting
            searsSumButton.titleLabel?.textColor = UIColor.lightGray
            searsSumOn = false
        }
        resetChart()
    }
    
    @IBAction func wickSumButtonClicked(_ sender: UIButton) {
        // color changing not working
        if !wickSumOn {
            // selecting
            wickSumButton.titleLabel?.textColor = UIColor.blue
            wickSumOn = true
        }
        else {
            // deselecting
            wickSumButton.titleLabel?.textColor = UIColor.lightGray
            wickSumOn = false
        }
        resetChart()
    }
    
    private func resetChart() {
        // reset the data entry array and x axis labels
        pieChartDataEntries = []
        var buildingNames : [String] = []
        var x = 0.0
        if glennanOn {
            setChart(values: glennanData, xVal: x, measurement: currentMeasurement, label: "Glennan")
            x += 1
            buildingNames.append("Glennan")
        }
        if nordOn {
            setChart(values: nordData, xVal: x, measurement: currentMeasurement, label: "Nord")
            x += 1
            buildingNames.append("Nord")
        }
        if olin480On {
            setChart(values: olin480Data, xVal: x, measurement: currentMeasurement, label: "Olin 480")
            x += 1
            buildingNames.append("Olin 480")
        }
        if olin208On {
            setChart(values: olin208Data, xVal: x, measurement: currentMeasurement, label: "Olin 208")
            x += 1
            buildingNames.append("Olin 208")
        }
        if rock480On {
            setChart(values: rock480Data, xVal: x, measurement: currentMeasurement, label: "Rock 480")
            x += 1
            buildingNames.append("Rock 480")
        }
        if sears480On {
            setChart(values: sears480Data, xVal: x, measurement: currentMeasurement, label: "Sears 480")
            x += 1
            buildingNames.append("Sears 480")
        }
        if sears208On {
            setChart(values: sears208Data, xVal: x, measurement: currentMeasurement, label: "Sears 208")
            x += 1
            buildingNames.append("Sears 208")
        }
        if tomlinsonOn {
            setChart(values: tomlinsonData, xVal: x, measurement: currentMeasurement, label: "Tomlinson")
            x += 1
            buildingNames.append("Tomlinson")
        }
        if whiteOn {
            setChart(values: whiteData, xVal: x, measurement: currentMeasurement, label: "White")
            x += 1
            buildingNames.append("White")
        }
        if wick208On {
            setChart(values: wick208Data, xVal: x, measurement: currentMeasurement, label: "Wick 208")
            x += 1
            buildingNames.append("Wick 208")
        }
        if wick480On {
            setChart(values: wick480Data, xVal: x, measurement: currentMeasurement, label: "Wick 480")
            x += 1
            buildingNames.append("Wick 480")
        }
        if yostOn {
            setChart(values: yostData, xVal: x, measurement: currentMeasurement, label: "Yost")
            x += 1
            buildingNames.append("Yost")
        }
        if olinSumOn {
            setChart(values: olinSumData, xVal: x, measurement: currentMeasurement, label: "Olin (Sum)")
            x += 1
            buildingNames.append("Olin (Sum)")
        }
        if searsSumOn {
            setChart(values: searsSumData, xVal: x, measurement: currentMeasurement, label: "Sears (Sum)")
            x += 1
            buildingNames.append("Sears (Sum)")
        }
        if wickSumOn {
            setChart(values: wickSumData, xVal: x, measurement: currentMeasurement, label: "Wick (Sum)")
            x += 1
            buildingNames.append("Wick (Sum)")
        }
        pieChartView.noDataText = "Must provide data"
        let pieChartDataSet = PieChartDataSet(values: pieChartDataEntries, label: "Electrical Energy Usage (kW)")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartView.data = pieChartData
        pieChartView.backgroundColor = UIColor.white
        pieChartView.chartDescription?.text = ""
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
        currentMeasurement = .total
        
        pieChartView.noDataText = "Must provide data"
        let pieChartDataSet = PieChartDataSet(values: pieChartDataEntries, label: "Electrical Energy Usage (kW)")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartView.data = pieChartData
        pieChartView.backgroundColor = UIColor.white
        pieChartView.chartDescription?.text = ""
        
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
        measurementAvgButton.titleLabel?.textColor = UIColor.lightGray
        //   measurementTotalButton.titleLabel?.textColor = UIColor.lightGray
        measurementPeakButton.titleLabel?.textColor = UIColor.lightGray
    }
    
    
}

