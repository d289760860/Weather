//
//  File.swift
//  Weather
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation
import Alamofire

//Try to get city and country name
class GetCurrentLocation :WeatherInfo{

    let API_KEY:String =  "f13734ae39485b1ca5b953d0fdc04a34"
    
    func DownloadWeatherDetails(completed : @escaping downloadComplete){
        let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGTITUDE)\(Location.sharedInstance.Longtitude!)\(APP_ID)\(API_KEY)"
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        //let currentWeatherURL:URL = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=beijing&units=metric&appid=f13734ae39485b1ca5b953d0fdc04a34")!
        Alamofire.request(currentWeatherURL).responseJSON{ response in
            if let dict = response.value as? Dictionary <String, AnyObject>{
                
                if let name = dict["name"] as? String {
                    self.cityName = name.capitalized
                    print(self.cityName)
                }
                if let countname:String = citydictinoary[self.cityName]
                {
                    self.countryName = countname;
                    print(self.countryName)
                }
                else
                {
                    if let sysinfo = dict["sys"] as? Dictionary<String, AnyObject>
                    {
                        if let countryname = sysinfo["country"] as? String
                        {
                            self.countryName = countryname.lowercased()
                            print(self.countryName)
                        }
                    }
                }
            }
            completed()
        }
    }
    //Infomation:
    //{"coord":{"lon":116.39,"lat":39.91},
    //"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],
    //"base":"stations",
    //"main":{"temp":-2,"pressure":1031,"humidity":58,"temp_min":-2,"temp_max":-2},
    //"visibility":10000,
    //"wind":{"speed":1},
    //"clouds":{"all":0},"dt":1514289600,
    //"sys":{"type":1,"id":7405,"message":0.0071,"country":"CN","sunrise":1514244881,"sunset":1514278546},
    //"id":1816670,"name":"Beijing","cod":200}

}

