//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit
import Alamofire
//import AAChartView.swift


class WeatherInfoViewController: UIViewController {

    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    var city:City?

    @IBOutlet weak var WeatherImg: UIImageView!
    
    var pressurelabel:UILabel!
    var visiblelabel:UILabel!
    var humiditylabel:UILabel!
    var sunriselabel:UILabel!
    var sunsetlabel:UILabel!
    var refreshButton:UIButton!


    var mystackView:UIStackView!

    private func LoadInformations()
    {
        //if(!((city?.getweather?.weatherType.isEmpty)!))
        if (city?.getweather?._weatherType) != nil
        {
            WeatherImg.image  = city?.weatherimg
            cityName.text = city?.name
            let str:String = (city?.getweather?.description)! + "  " + String(format: "%.2f", (city?.getweather?.currentTemp)!) + FAHRENHEIT
            descriptionlabel.text = str
        }
        else
        {
            WeatherImg.image = UIImage(named:"NoImg")
            cityName.text = city?.name
            descriptionlabel.text = "Sorry,no network connection available"
        }
    }
    
    private func AddStackView()
    {
        //Had some problems with the constraint of the stack view when rotating the screen,so do it mannually.
        mystackView = UIStackView()
        mystackView.spacing = 10
        mystackView.axis = .vertical
        
        mystackView.distribution = .fillEqually
        
        pressurelabel = UILabel()
        pressurelabel.text = "\tpressure:\t\(self.city?.getweather?.pressure ?? 0)hPa"
        pressurelabel.contentMode = .scaleAspectFill
        pressurelabel.clipsToBounds = true
        //pressurelabel.lineBreakMode = .byWordWrapping
        //pressurelabel.numberOfLines = 0
        mystackView.addArrangedSubview(pressurelabel)
        
        visiblelabel = UILabel()
        visiblelabel.text = "\tvisibility:\t\(self.city?.getweather?.visibility ?? 0)m"
        visiblelabel.contentMode = .scaleAspectFill
        visiblelabel.clipsToBounds = true
        mystackView.addArrangedSubview(visiblelabel)
        
        humiditylabel = UILabel()
        humiditylabel.text = "\thumidity:\t\(self.city?.getweather?.humidity ?? 0)%"
        humiditylabel.contentMode = .scaleAspectFill
        humiditylabel.clipsToBounds = true
        mystackView.addArrangedSubview(humiditylabel)
        
        sunriselabel = UILabel()
        sunriselabel.text = "\tsunrise time:\t\(self.city?.getweather?.GetFormattedSunrise() ?? "")"
        sunriselabel.contentMode = .scaleAspectFill
        sunriselabel.clipsToBounds = true
        mystackView.addArrangedSubview(sunriselabel)
        
        sunsetlabel = UILabel()
        sunsetlabel.text = "\tsunset time:\t\(self.city?.getweather?.GetFormattedSunset() ?? "")"
        sunsetlabel.contentMode = .scaleAspectFill
        sunsetlabel.clipsToBounds = true
        mystackView.addArrangedSubview(sunsetlabel)
        
        
        refreshButton = UIButton()
        refreshButton.setTitle("Click here to refresh.", for:.normal)
        refreshButton.setTitle("Going to refresh...", for:.highlighted)
        refreshButton.setTitle("Refreshing...", for:.disabled)
        refreshButton.setTitleColor(UIColor.black, for: .normal)
        refreshButton.setTitleColor(UIColor.green, for: .highlighted)
        refreshButton.setTitleColor(UIColor.gray, for: .disabled)
        refreshButton.addTarget(self, action:#selector(self.pressed(sender:)), for: .touchUpInside)
        
        mystackView.addArrangedSubview(refreshButton)
        
        // label4 = UILabel()
        //label4.text = "\thumidity:\t\(self.city?.getweather?. ?? "No data")"
        
        self.view.addSubview(mystackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionlabel.textAlignment = .left
        // Do any additional setup after loading the view.
        LoadInformations()
        AddStackView()
        //self.navigationItem.title = "Information"
        //InitContainerView()
        //DrawLineChart()
        //ScrollView.addSubview(linechart)
    }

    @objc func pressed(sender: UIButton!) {
        print("refresh button clicked...")
        refreshButton.isEnabled = false
        self.city?.getweather?.DownloadWeatherDetails {
            if let weathericon = self.city?.getweather?._iconid
            {
                let iconurl = URL(string:ICON_BASE_URL+(weathericon)+ICON_SUFFIX)!
                //print(iconurl)
                Alamofire.request(iconurl).responseData { response in
                    if let data = response.result.value {
                        let image = UIImage(data: data)
                        self.city?.weatherimg = image
                        self.WeatherImg.image = image
                    }
                }
            }
            self.LoadInformations()
            self.pressurelabel.text = "\tpressure:\t\(self.city?.getweather?.pressure ?? 0)hPa"
            self.visiblelabel.text = "\tvisibility:\t\(self.city?.getweather?.visibility ?? 0)m"
            self.humiditylabel.text = "\thumidity:\t\(self.city?.getweather?.humidity ?? 0)%"
            self.sunsetlabel.text = "\tsunset time:\t\(self.city?.getweather?.GetFormattedSunset() ?? "")"
            self.sunriselabel.text = "\tsunrise time:\t\(self.city?.getweather?.GetFormattedSunrise() ?? "")"
            self.refreshButton.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let padding:CGFloat = 10
        let orientation = UIApplication.shared.statusBarOrientation
        
        //vertical
        if UIInterfaceOrientationIsPortrait(orientation)
        {
            mystackView.frame = CGRect(x:padding, y:140 + padding,
                                     width:view.frame.width - padding * 2,
                                     height:view.frame.height - 150 - padding * 2)
            
        }
        else
        {
            mystackView.frame = CGRect(x:view.frame.width/2, y:50 + padding,
                                     width:view.frame.width/2 - padding,
                                     height:view.frame.height - 70 - padding * 3)
            //mystackView.axis = .horizontal
            //WeatherImg.frame = CGRect(x:view.frame.width - WeatherImg.frame.width/2, y:64 + padding,
            //                          width:WeatherImg.frame.width,
            //                          height:WeatherImg.frame.height)
            //to avoid picture disappear
        }
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
