//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate,weatherManagerDelegate{
    var weathermanager=WeatherManager()
    @IBOutlet var SearchField: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchField.delegate=self
        weathermanager.delegate=self
    }


    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        print(SearchField.text!)
        SearchField.endEditing(true)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(SearchField.text!)
        SearchField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name=SearchField.text!
        weathermanager.fetchCityName(cityName: name)

        SearchField.text=""
    }

    func didUpdateWeather(weather:WeatherModel)
    {
        DispatchQueue.main.sync {
            temperatureLabel.text=weather.temperatureString
            cityLabel.text=weather.name
            conditionImageView.image=UIImage(systemName: weather.conditionName)
        }
    }
  
}

