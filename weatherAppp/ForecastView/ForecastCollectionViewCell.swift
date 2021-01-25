//
//  ForecastCollectionViewCell.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var morningTempFeelingLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayTempFeelingLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var nightTempFeelLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    //    @IBOutlet weak var morningFeelsLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var snowLabel: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    //    @IBOutlet weak var morningLabel: UILabel!
    var forecast: DailyForecast? {
        didSet {
            if let weather = forecast {
                pressureLabel.text = String(weather.pressure)
                humidityLabel.text = String(weather.humidity)
                windSpeed.text = String(weather.windSpeed)
                cloudsLabel.text = String(weather.clouds)
                rainLabel.text = String(weather.rain ?? 0)
                snowLabel.text = String(weather.snow ?? 0)
                mainWeather.text = weather.additionalWeather.reduce(" ", { $0 + $1.main })
                morningLabel.text = String(weather.temperature.morning)
                morningTempFeelingLabel.text = String(weather.feelsLikeTemperature.morning)
                dayLabel.text = String(weather.temperature.day)
                dayTempFeelingLabel.text = String(weather.feelsLikeTemperature.day)
                nightTempLabel.text = String(weather.temperature.night)
                nightTempFeelLabel.text = String(weather.feelsLikeTemperature.night)
                maxTempLabel.text = String(weather.temperature.max)
                minTempLabel.text = String(weather.temperature.min)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        forecast = nil
        
    }

}
