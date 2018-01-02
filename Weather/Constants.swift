//
//  File.swift
//  Weather
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation

let ICON_BASE_URL = "http://openweathermap.org/img/w/"
let ICON_SUFFIX = ".png"
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?"
//http://api.openweathermap.org/data/2.5/forecast?q=London,us&appid=f13734ae39485b1ca5b953d0fdc04a34
let CITY_NAME = "q="
let LATITUDE = "lat="
let LONGTITUDE = "&lon="
let APP_ID = "&appid="
let COUNT_LIMIT = "&cnt=20"
let FAHRENHEIT = "℉"

typealias downloadComplete = () -> ()





