//
//  Location.swift
//  Weather
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation

class Location{
    static var sharedInstance = Location()
    private init (){}
    var latitude : Double!
    var Longtitude : Double!
}
