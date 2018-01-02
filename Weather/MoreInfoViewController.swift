//
//  MoreInfoViewController.swift
//  Weather
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var otherInfoScrollView: UIScrollView!
    
    @IBOutlet weak var Greetings: UIImageView!
    var city:City?
    let givenheight = 300
    let givenwidth = 3000
    
    lazy var detailchart: MoreInfoChartView = {
        //let randomdata:[Double] = [0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
        let chart = MoreInfoChartView.init(frame: CGRect.init(x: 0, y: 0, width: givenwidth, height:Int(self.otherInfoScrollView.frame.height) ),datasource:(city?.getweather)!)
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Greetings.image = UIImage(named:"happy")
        InitContainerView(scrview: otherInfoScrollView)
        //DrawLineChart()
        otherInfoScrollView.addSubview(detailchart)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func InitContainerView(scrview:UIScrollView)
    {
        scrview.isScrollEnabled = true
        scrview.contentSize.width = CGFloat(givenwidth)
        scrview.contentSize.height = 0
        //print(self.view.safeAreaInsets.top)
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
