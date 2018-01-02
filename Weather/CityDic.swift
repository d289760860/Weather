//
//  CityDic.swift
//  Weather
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation

 let citydictinoary:[String:String] = [
    "London":"gb",
    "Birmingham":"gb",
    "Leeds":"gb",
    "Beijing":"cn",
    "Shanghai":"cn",
    "Nanjing":"cn",
    "Wuxi":"cn",
    "Xian":"cn",
    "Dongying":"cn",
    "Chicago":"us",
    "Houston":"us",
    "Detroit":"us"
]

class GetSomeDic
{
    
    func GetExpectedDic(ch:Character)->Array<String>
    {
        var temparray = [String]()
        for (city,country) in citydictinoary
        {
            if city.hasPrefix("\(ch)")
            {
                temparray.append(city + " " + country)
            }
        }
        return temparray
        
    }
}
