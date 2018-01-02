//
//  DetailViewController.swift
//  Weather
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tempscrollview: UIScrollView!
    @IBOutlet weak var weatherscrollview: UIScrollView!
    @IBOutlet weak var otherchart: UIScrollView!
    
    var city:City?
    let givenheight = 300
    let givenwidth = 2000
    
    lazy var templinechart: LineChartView = {
        //let randomdata:[Double] = [0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
        let chart = LineChartView.init(frame: CGRect.init(x: 0, y: 0, width: givenwidth, height:Int(self.tempscrollview.frame.height) ),datasource:(city?.getweather)!)
        return chart
    }()
    
    lazy var otherinfochart:OtherInfoChartView = {
        let chart = OtherInfoChartView.init(frame: CGRect.init(x: 0, y: 0, width: givenwidth, height:Int(self.tempscrollview.frame.height) ),datasource:(city?.getweather)!)
        return chart
    }()
    
    lazy var weatherinfochart:WeatherCharView = {
        let chart = WeatherCharView.init(frame: CGRect.init(x: 0, y: 0, width: givenwidth, height:Int(self.tempscrollview.frame.height) ),datasource:(city?.getweather)!)
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitContainerView(scrview: tempscrollview)
        InitContainerView(scrview: otherchart)
        InitContainerView(scrview: weatherscrollview)
        //DrawLineChart()
        tempscrollview.addSubview(templinechart)
        otherchart.addSubview(otherinfochart)
        weatherscrollview.addSubview(weatherinfochart)
        // Do any additional setup after loading the view.
    }

    private func InitContainerView(scrview:UIScrollView)
    {
        scrview.isScrollEnabled = true
        scrview.contentSize.width = CGFloat(givenwidth)
        scrview.contentSize.height = 0
        //print(self.view.safeAreaInsets.top)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
