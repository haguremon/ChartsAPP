//
//  LineViewController.swift
//  ChartsAPP
//
//  Created by IwasakIYuta on 2022/02/08.
//

import UIKit
import Charts
class LineViewController: UIViewController, ChartViewDelegate {
    
    let lineChartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
    
    }
    
    //barChatViewのフレーム等を設定するため
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //lineChartViewの場所などを決める
        lineChartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width)
        lineChartView.center = view.center
        view.addSubview(lineChartView)
        //グラフのに表すもの
        var entries = [BarChartDataEntry]()
        
        for i in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(i)))
        }
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
