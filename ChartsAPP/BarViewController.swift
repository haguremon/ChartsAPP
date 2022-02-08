//
//  BarViewController.swift
//  ChartsAPP
//
//  Created by IwasakIYuta on 2022/02/08.
//

import UIKit
import Charts

struct BarChartModel {
    let value: Double
    let name: String
}


class BarViewController: UIViewController,ChartViewDelegate {
    
    var barItems = [(Double, String)]()
    
    var barChartView = BarChartView()
    
    let valueTextFiel: UITextField = {
        let tf = UITextField()
        tf.placeholder = "時間を入力してください"
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameTextFiel: UITextField = {
        let tf = UITextField()
        tf.placeholder = "科目を入力してください"
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var button: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .blue
        bt.tintColor = .white
        bt.setTitle("ボタン", for: .normal)
        bt.addTarget(self, action: #selector(tappedBarItemsappend), for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    @objc func tappedBarItemsappend() {
        guard let value = valueTextFiel.text,
              let name = nameTextFiel.text,
        let valueDouble = Double(value) else { return }

        barItems.append((valueDouble,name))
        
    barChartView.data = self.createBarChartData(of: barItems.map({ BarChartModel(value: $0.0, name: $0.1) }))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        barChartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width)
        barChartView.center = view.center
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        view.addSubview(barChartView)
        barChartView.data = self.createBarChartData(of: barItems.map({ BarChartModel(value: $0.0, name: $0.1) }))
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.labelCount = barItems.count
        barChartView.xAxis.labelPosition = .bottom
        barChartView.rightAxis.granularityEnabled = true
        barChartView.rightAxis.granularity = 1.0
        barChartView.leftAxis.granularityEnabled = true
        barChartView.leftAxis.granularity = 1.0
        barChartView.leftAxis.axisMinimum = 0 //y左軸最小値
        //barChartView.leftAxis.axisMaximum = 24 //y
        
        let stackView = UIStackView(arrangedSubviews: [valueTextFiel,nameTextFiel,button])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: barChartView.bottomAnchor, constant: 5).isActive = true
        stackView.bounds.size.width = view.bounds.width / 1.5

    }
    //barChatViewのフレーム等を設定するため
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
////        var entries = [BarChartDataEntry]()
////
////        for i in 0..<barItems.count {
////            entries.append(BarChartDataEntry(x: Double(i), y: Double(i)))
////        }
////        let set = BarChartDataSet(entries: entries)
////        set.colors = ChartColorTemplates.joyful()
////        let data = BarChartData(dataSet: set)
//        barChartView.data = self.createBarChartData(of: barItems.map({ BarChartModel(value: $0.0, name: $0.1) }))
//        //ズームできないようにする
////        barChartView.pinchZoomEnabled = false
////        barChartView.doubleTapToZoomEnabled = false
//
//
//        barChartView.rightAxis.enabled = false
//        barChartView.xAxis.labelCount = barItems.count
//        barChartView.xAxis.labelPosition = .bottom
//        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: barItems.map({$0.1}))
//
//    }
    
    private func createBarChartData(of items: [BarChartModel]) -> BarChartData {
        let entries: [BarChartDataEntry] = items.enumerated().map {
            let (i, item) = $0
            return BarChartDataEntry(x: Double(i), y: Double(item.value))
        }
        let barChartDataSet = BarChartDataSet(entries: entries, label: "時間")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: barItems.map({$0.1}))
        return barChartData
    }


}
