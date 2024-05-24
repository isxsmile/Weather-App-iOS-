//
//  WeatherManager.swift
//  Clima
//
//  Created by Shaik Ismail on 23/05/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
protocol weatherManagerDelegate
{
    func didUpdateWeather(weather:WeatherModel)
}
struct WeatherManager
{
    var delegate:weatherManagerDelegate?
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?&appid=f5e8705b52ab4946f7299671bd48a79f&units=metric"
    
    func fetchCityName(cityName:String)
    {
        let completeURL="\(weatherURL)&q=\(cityName)"
        performURL(urlString: completeURL)
    }
    
    func performURL(urlString:String)
    {
        //1.create a url
        if let url=URL(string: urlString)
            
        {
            
            //2.create a url session
            
            let session=URLSession(configuration: .default)
            
            //3.create a url session task
            
            let task=session.dataTask(with: url, completionHandler: handler(data:urlresponse:error:))
            
            //4.start the task
            
            task.resume()
        }
    }
        func handler(data:Data?,urlresponse:URLResponse?,error:Error?)
        {
            if error != nil{
                print(error!)
                return
            }
            
            if let safeData=data
            {
                if let weather=parseJSON(weatherData: safeData)
                {
                    delegate?.didUpdateWeather(weather: weather)
                }
            }
        }
    
    func parseJSON(weatherData:Data)->WeatherModel?
    {
        let decoder=JSONDecoder()
        do{
            let decodeData=try decoder.decode(WeatherData.self, from: weatherData)
            let weatherID=decodeData.weather[0].id
            let temperature=decodeData.main.temp
            let name=decodeData.name
            let weathermodel=WeatherModel(temperature: temperature, name: name, weatherID: weatherID)
            print(weathermodel.conditionName)
            print(weathermodel.temperatureString)
            return weathermodel
        }catch
        {
            print(error)
            return nil
        }
    }
}
    
