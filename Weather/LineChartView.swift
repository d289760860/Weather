//
//  LineChartView.swift
//  Weather
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class LineChartView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var aachartview:AAChartView?
    var aachartmodel:AAChartModel?
    
    var catearray = [String]()
    var datasource:WeatherInfo
    
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
            .chartType(AAChartType.Line)//Can be any of the chart types listed under `AAChartType`.
            .animationType(AAChartAnimationType.Bounce)
            .title(datasource.cityName)//The chart title
            .subtitle("Temperature Forecast")//The chart subtitle
            .dataLabelEnabled(false) //Enable or disable the data labels. Defaults to false
            .markerRadius(5) //The radius of the point marker. Defaults to 4
            .series([
                [
                    "name": "Temperature(\(FAHRENHEIT))",
                    "data": datasource.templist
                ],
                ])
            .categories(catearray)
        aachartview?.aa_drawChartWithChartModel(aachartmodel!)
    
        //let newdata = [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
        //aachartview?.aa_onlyRefreshTheChartDataWithChartModelSeries()
        //aachartview?.aa_refreshChartWholeContentWithChartModel(aachartmodel!)
        self.addSubview(aachartview!)
 
 
    }
    
    func refreshChart()
    {
        aachartview?.aa_onlyRefreshTheChartDataWithChartModelSeries(
            ([

                [
                    "name": "Temperature(\(FAHRENHEIT))",
                    "data": datasource.templist
                ],

                ])
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //unused gradientlayer
    lazy var gradientLayer: CAGradientLayer = {
        let graLayer = CAGradientLayer.init()
        graLayer.frame = self.bounds
        graLayer.colors = [
            UIColor.init(red: 0.09, green: 0.58, blue: 0.15, alpha: 1).cgColor,
            UIColor.init(red: 0.20, green: 0.63, blue: 0.25, alpha: 1).cgColor,
            UIColor.init(red: 0.60, green: 0.82, blue: 0.22, alpha: 1).cgColor,
            UIColor.init(red: 0.97, green: 0.65, blue: 0.22, alpha: 1).cgColor,
            UIColor.init(red: 0.96, green: 0.08, blue: 0.10, alpha: 1).cgColor
        ]
        graLayer.locations = [0,0.25,0.5,0.75,1]
        graLayer.startPoint = CGPoint.init(x: 0, y: 0)
        graLayer.endPoint = CGPoint.init(x: 1, y: 0)
        return graLayer
    }()

}
