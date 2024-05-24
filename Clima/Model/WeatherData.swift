//
//  WeatherData.swift
//  Clima
//
//  Created by Shaik Ismail on 23/05/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData:Decodable
{
    let name:String
    let weather:[Weather]
    let main:Main
}
struct Weather:Decodable
{
    let id:Int
    let description:String
}
struct Main:Decodable
{
    let temp:Double
}
