//
//  GetGivenCityWeather.swift
//  Weather
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation
import Alamofire

class GetGivenCityWeather:WeatherInfo{
    //GIVEN_CITY_WEATHER_URL = "\(BASE_URL)\(CITY_NAME)beijing&units=metric\(APP_ID)\(API_KEY)"
    //http://api.openweathermap.org/data/2.5/weather?q=beijing&units=metric&appid=f13734ae39485b1ca5b953d0fdc04a34
    
    let API_KEY:String =  "f13734ae39485b1ca5b953d0fdc04a34"
    
    init?(name:String)
    {
        super.init()
        guard !name.isEmpty else
        {
            return nil
        }
        self._cityName = name
        self._countryName = citydictinoary[name]
    }
    
    func GetFormattedSunset()->String
    {
        if let fotmatted = self.getFormattedTime(initialTime: self._sunset)
        {
            return fotmatted
        }
        else
        {
            return ""
        }
    }
    func GetFormattedSunrise()->String
    {
        if let fotmatted = self.getFormattedTime(initialTime: self._sunrise)
        {
            return fotmatted
        }
        else
        {
            return ""
        }
    }
    
    func DownloadWeatherDetails(completed : @escaping downloadComplete){
        print("starting download weather of \(self.cityName)")
        let givencity = URL(string:"\(BASE_URL)\(CITY_NAME)\(self.cityName)&units=metric\(APP_ID)\(API_KEY)")!
        //let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.Longtitude!)&cnt=10\(APP_ID)\(API_KEY)"
        print(FORECAST_URL)
        //let currentWeatherURL = URL(string: givencity)!
        Alamofire.request(givencity).responseJSON{ response in
            if let dict = response.value as? Dictionary <String, AnyObject>{
                
                /*
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                 */
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]
                {
                    if let main = weather [0] ["main"]  as? String
                    {
                        self.weatherType = main.capitalized
                        print(self.weatherType)
                    }
                    if let describe = weather [0] ["description"]  as? String
                    {
                        self.description = describe
                        print(self.description)
                    }
                    if let icon = weather [0] ["icon"]  as? String
                    {
                        self._iconid = icon.capitalized.lowercased()
                        print(self.iconid)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject>
                {
                    if let temp = main["temp"] as? Double
                    {
                        self._currentTemp = temp//Double(round(10*(temp - 275.15)/10))
                        print("temp:\(self._currentTemp!)")
                    }
                    
                    if let humid = main["humidity"] as? Double
                    {
                        self._humidity = humid//Double(round(10*(temp - 275.15)/10))
                        print("humidity:\(self._humidity!)")
                    }
                    
                    if let press = main["pressure"] as? Double
                    {
                        self._pressure = press//Double(round(10*(temp - 275.15)/10))
                        print("pressure:\(self._pressure!)")
                    }
                    
                }
                
                if let sys = dict["sys"] as? Dictionary<String, AnyObject>
                {
                    if let sunrise = sys["sunrise"] as? Double
                    {
                        self._sunrise = sunrise//Double(round(10*(temp - 275.15)/10))
                        print("sunrise:\(self._sunrise!)")
                    }
                    if let sunset = sys["sunset"] as? Double
                    {
                        self._sunset = sunset
                        print("sunset:\(self._sunset!)")
                    }
                }
                if let visible = dict["visibility"] as? Double
                {
                    self._visibility = visible
                    //self._visibility = visible//Double(round(10*(temp - 275.15)/10))
                    print("visiblity:\(self._visibility!)")
                }
            }
            completed()
        }
    }
    //Infomation:
    //{"coord":{"lon":116.39,"lat":39.91},"weather":
    //[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],
    //"base":"stations","main":{"temp":-2,"pressure":1031,"humidity":58,"temp_min":-2,"temp_max":-2},
    //"visibility":10000,"wind":{"speed":1},"clouds":{"all":0},"dt":1514289600,"sys":{"type":1,"id":7405,"message":0.0071,"country":"CN","sunrise":1514244881,"sunset":1514278546},"id":1816670,"name":"Beijing","cod":200}

    func DownloadWeatherForecast(completed : @escaping downloadComplete){
        //http://api.openweathermap.org/data/2.5/forecast?q=London,us&appid=f13734ae39485b1ca5b953d0fdc04a34
        let urlstr = "\(FORECAST_URL)\(CITY_NAME)\(cityName),\(countryName)\(COUNT_LIMIT)\(APP_ID)\(API_KEY)"
        print(urlstr)
        let predict = URL(string:urlstr)!
        Alamofire.request(predict).responseJSON{ response in
            //var i = 0
            if let dict = response.value as? Dictionary <String, AnyObject>{
                //print(dict)
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]
                {
                    //print(list)
                    for listitem in list
                    {
                        //i = i+1
                        //print(listitem)
                        //print("\n\n\n\n")
                        //weather information in five days,every 3 hour
                        
                        if let clouds = listitem["clouds"] as? Dictionary<String, AnyObject>
                        {
                            if let all = clouds["all"]  as? Double
                            {
                                //print(all)
                                self.cloudslist.append(all)
                            }
                        }
                        if let wind = listitem["wind"] as? Dictionary<String, AnyObject>
                        {
                            //print(wind)
                            //print("\nWindCondition\n\n\n\n")
                            if let speed = wind["speed"]  as? Double
                            {
                                //print("windspeed:\(speed)")
                                self.windspeedlist.append(speed)
                            }
                        }
                        if let rain = listitem["rain"] as? Dictionary<String, AnyObject>
                        {
                            //print(rain)
                            //print("\n\n\n")
                            if let sn = rain["3h"]  as? Double
                            {
                                //print("rain:\(sn)")
                                self.rainlist.append(sn)
                            }
                        }
                        else
                        {
                            //print("\n\ni:\(i)\n\n")
                            self.rainlist.append(0)
                        }
                        if let main = listitem["main"]  as? Dictionary<String, AnyObject>
                        {
                            //print(main)
                            //print("\n\n\n\n")
                            //var tuple:(temp:Double,humid:Double,pressure:Double)
                            if let temp = main["temp"]  as? Double
                            {
                                //print(temp)
                                self.templist.append(temp)
                            }
                            if let press = main["pressure"]  as? Double
                            {
                                //print(press)
                                self.presslist.append(press)
                            }
                            if let humid = main["humidity"]  as? Double
                            {
                                //print(humid)
                                self.humidlist.append(humid)
                            }
                            if let level = main["sea_level"]  as? Double
                            {
                                //print(level)
                                self.sealevellist.append(level)
                            }
                            if let glevel = main["grnd_level"]  as? Double
                            {
                                print(glevel)
                                self.grndlevellist.append(glevel)
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
    /** example format */
    /*
     {
     "cod":"200",
     "message":0.0105,
     "cnt":40,
     "list":
        [
            {
                "dt":1514376000,
                "main":
                    {
                        "temp":267.92,
                        "temp_min":266.943,
                        "temp_max":267.92,
                        "pressure":1003.97,
                        "sea_level":1050.14,
                        "grnd_level":1003.97,
                        "humidity":79,
                        "temp_kf":0.98
                    },
                "weather":
                [{      "id":800,
                        "main":"Clear",
                        "description":"clear sky",
                        "icon":"01n"
                }],
                "clouds":
                {"all":80},
                "wind":{"speed":2.11,"deg":3.50031},
                "snow":{"3h":0.001},
                "sys":{"pod":"n"},
                "dt_txt":"2017-12-27 12:00:00"
            },
            {
            "dt":1514386800,"main":{"temp":267.3,"temp_min":266.561,"temp_max":267.3,"pressure":1006.21,"sea_level":1049.61,"grnd_level":1002.12,"humidity":83,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"clouds":{"all":20},"wind":{"speed":1.75,"deg":14.0014},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-01 09:00:00"
            }
        ],
     "city":{"id":4298960,"name":"London","coord":{"lat":37.129,"lon":-84.0833},"country":"US","population":7993}
     
     }
     */
}
