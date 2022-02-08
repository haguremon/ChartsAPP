//
//  PieViewController.swift
//  ChartsAPP
//
//  Created by IwasakIYuta on 2022/02/08.
//

import UIKit
import Charts

class PieViewController: UIViewController,ChartViewDelegate {

    var pieChartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.delegate = self
      
    }
    //barChatViewのフレーム等を設定するため
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width)
        pieChartView.center = view.center
        view.addSubview(pieChartView)
//        var entries = [BarChartDataEntry]()
//
//        for i in 0..<10 {
//            entries.append(BarChartDataEntry(x: Double(i), y: Double(i)))
//        }
//        let set = PieChartDataSet(entries: entries)
//        set.colors = ChartColorTemplates.material()
//        let data = PieChartData(dataSet: set)
//        pieChartView.data = data
        setupGraph()
    }

    func setupGraph() {
        pieChartView.usePercentValuesEnabled = true

        pieChartView.centerText = "2018/4/1"
       
            let values: [Double] = [2, 1, 1, 1, 1]
           // let date : [Double] = [1,2,3,4,5]
            let label: [String] = ["数学","英語","社会","理科","国語"]
            var entries: [PieChartDataEntry] = Array()
            for (i, value) in values.enumerated(){
                entries.append(PieChartDataEntry(value: value, label: label[i], icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
            }
            
        let dataSet = PieChartDataSet(entries: entries, label: ":科目")
            dataSet.colors = ChartColorTemplates.vordiplom()
            dataSet.entryLabelColor = .black
        dataSet.valueColors = [NSUIColor.black]
            let chartData = PieChartData(dataSet: dataSet)
            
            pieChartView.data = chartData

        let formatter = NumberFormatter()
         formatter.numberStyle = .percent
         formatter.maximumFractionDigits = 2
         formatter.multiplier = 1.0
         self.pieChartView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        

    }

}
