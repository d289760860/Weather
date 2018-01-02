//
//  WeatherInfo.swift
//  Weather
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation

class WeatherInfo
{
    var _cityName :String?
    var _countryName:String?
    var _date : String?
    var _iconid:String?
    var _weatherType:String?
    var _currentTemp : Double?
    var _humidity:Double?
    var _pressure:Double?
    var _visibility:Double?
    var _description:String?
    var _sunrise:Double?
    var _sunset:Double?
    
    //var condition = [(temp:Double,humid:Double,pressure:Double)]()
    var templist = [Double]()
    
    var humidlist = [Double]()
    var presslist = [Double]()
    var sealevellist = [Double]()
    var grndlevellist = [Double]()
    
    var cloudslist = [Double]()
    var windspeedlist = [Double]()
    var rainlist = [Double]()
    //var 
    
    var cityName :String{
        get
            {
                if _cityName == nil {
                    return ""
                }
                return _cityName!
        }
        set(newVal)
        {
            _cityName = newVal
        }
    }
    var countryName :String{
        get
        {
                if _countryName == nil {
                    return ""
                }
                return _countryName!
        }
        set(newVal)
        {
            _countryName = newVal
        }
    }
    
    var date :String{
        get
        {
            if(_date == nil)
            {
                return ""
            }
            let dateFormatter =  DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: Date())
            return "Today, \(currentDate)"
        }
        set(newVal)
        {
            _date = newVal
        }
        
        
    }
    var weatherType :String{
        get
        {
            if(_weatherType == nil)
            {
                return ""
            }
            return _weatherType!
        }
        set(newVal)
        {
            _weatherType = newVal
        }
        
    }
    var currentTemp :Double{
        get
        {
            if(_currentTemp == nil)
            {
                return 0.0
            }
            return _currentTemp!
        }
        set(newVal)
        {
            _currentTemp = newVal
        }
    }
    
    var visibility :Double{
        get
        {
            if(_visibility == nil)
            {
                return 0.0
            }
            return _visibility!
        }
        set(newVal)
        {
            _visibility = newVal
        }
    }
    
    var humidity :Double{
        get
        {
            if(_humidity == nil)
            {
                return 0.0
            }
            return _humidity!
        }
        set(newVal)
        {
            _humidity = newVal
        }
    }
    var iconid:String
    {
        get
        {
            if(_iconid == nil)
            {
                return ""
            }
            return _iconid!
        }
        set(newVal)
        {
            _iconid = newVal
        }
    }
    
    var description:String
    {
        get
        {
            if(_description == nil)
            {
                return ""
            }
            return _description!
        }
        set(newVal)
        {
            _description = newVal
        }
    }
    
    var pressure:Double
    {
        get
        {
            if(_pressure == nil)
            {
                return 0.0
            }
            return _pressure!
        }
        set(newVal)
        {
            _pressure = newVal
        }
    }
    
    var sunrise :Double{
        get
        {
            if(_sunrise == nil)
            {
                return 0.0
            }
            return _sunrise!
        }
        set(newVal)
        {
            _sunrise = newVal
        }
    }
    var sunset :Double{
        get
        {
            if(_sunset == nil)
            {
                return 0.0
            }
            return _sunset!
        }
        set(newVal)
        {
            _sunset = newVal
        }
    }
    
    func getFormattedTime(initialTime:Double?)->String?
    {
        if  let timeResult = (initialTime)
        {
            let date = NSDate(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date as Date)
            return localDate
        }
        else
        {
            return nil
        }
    }
}

//http://api.openweathermap.org/data/2.5/forecast?q=London,us&appid=f13734ae39485b1ca5b953d0fdc04a34
