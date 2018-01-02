//
//  MoreInfoChartView.swift
//  Weather
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit
import Foundation

class MoreInfoChartView: UIView {
    
    var datasource:WeatherInfo
    var aachartview:AAChartView?
    var aachartmodel:AAChartModel?
    var catearray = [String]()
    
    init(frame : CGRect,datasource:WeatherInfo){
        self.datasource = datasource
        super.init(frame: frame)
        
        //layer.addSublayer(gradientLayer)
        
        let chartViewWidth:CGFloat  = frame.size.width
        let chartViewHeight:CGFloat = frame.size.height
        
        aachartview = AAChartView()
        aachartview?.frame = CGRect(x:0,y:0,width:chartViewWidth,height:chartViewHeight)
        // set the content height of aachartView
        // aaChartView?.contentHeight = self.view.frame.size.height
        if catearray.isEmpty==true && datasource.templist.count>0
        {
            for i in 1...datasource.templist.count
            {
                catearray.append("\(i*3-3)-\(i*3)h")
            }
        }
        
        aachartmodel = AAChartModel.init()
            .chartType(AAChartType.Column)//Can be any of the chart types listed under `AAChartType`.
            .animationType(AAChartAnimationType.Bounce)
            .title("More Information")//The chart title
            .subtitle("future 60 hours")//The chart subtitle
            .dataLabelEnabled(false) //Enable or disable the data labels. Defaults to false
            .markerRadius(5) //The radius of the point marker. Defaults to 4
            .series([
                [
                    "name": "pressure(hPa)",
                    "data": datasource.presslist
                ],
                [
                    "name": "sealevel(hPa)",
                    "data": datasource.sealevellist
                ],
                [
                    "name": "grndlevel(hPa)",
                    "data": datasource.grndlevellist
                ],
                ])
            .categories(catearray)
        aachartview?.aa_drawChartWithChartModel(aachartmodel!)
        //let newdata = [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
        
        //aachartview?.aa_refreshChartWholeContentWithChartModel(aachartmodel!)
        self.addSubview(aachartview!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshChart()
    {
        aachartview?.aa_onlyRefreshTheChartDataWithChartModelSeries(
            ([
                [
                    "name": "pressure(hPa)",
                    "data": datasource.presslist
                ],
                [
                    "name": "sealevel(hPa)",
                    "data": datasource.sealevellist
                ],
                [
                    "name": "grndlevel(hPa)",
                    "data": datasource.grndlevellist
                ],
                ])
        )
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
