//
//  City.swift
//  Weather
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit
import Alamofire
import os.log




struct PropertyKey
{
    static let name = "name"
    //static let country = "country"
}

class City:NSObject, NSCoding
{
        //Properties
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cities")
    
    var name:String
    var country:String
    var countryimg:UIImage?
    var weatherimg:UIImage?
    //var tempList: [Int]
    var getweather:GetGivenCityWeather?
    
    init?(name:String)
    {
        //To add
        guard !name.isEmpty else
        {
            return nil
        }
        self.name = name
        self.country = citydictinoary[self.name]!
        self.countryimg = UIImage(named:country)
        self.weatherimg = UIImage(named:"NoImg")
        //tempList = []
        getweather = GetGivenCityWeather(name:self.name)
    }
    
    func LoadForecastInfo()
    {
        getweather?.DownloadWeatherForecast {
            print("Downloaded data for \(self.name)")
        }
    }
    
    func Reloadweatherimg(weathericon:String)
    {
        let iconurl = URL(string:ICON_BASE_URL+(weathericon)+ICON_SUFFIX)!
        //print(iconurl)
        Alamofire.request(iconurl).responseData { response in
            if let data = response.result.value {
                let image = UIImage(data: data)
                self.weatherimg = image
            }
        }
    }
    
    func LoadDetailInfo()
    {
        getweather?.DownloadWeatherDetails {
            if let weathericon = self.getweather?.iconid
            {
                //http://openweathermap.org/img/w/10d.png
                //self.weatherimg = UIImage(named:weathertp)
                self.Reloadweatherimg(weathericon: weathericon)
                
            }
            else
            {
                print("fail to get weather type!\n")
            }
        }
 
        /*for  i in 1...24{
            tempList.append((i+3)%5)
        }*/
        //let weatherph1 = UIImage(named:"Cloudy")
        //let weatherph2 = UIImage(named:"Stormy")
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey: PropertyKey.name)
        //aCoder.encode(country, forKey: PropertyKey.country)
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a City object.", log: OSLog.default, type: .debug)
            return nil
        }
        //let country = aDecoder.decodeInteger(forKey: PropertyKey.country)
        self.init(name: name)
    }
    
}
