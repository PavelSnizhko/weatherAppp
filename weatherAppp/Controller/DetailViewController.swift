//
//  DetailViewController.swift
//  weatherAppp
//
//  Created by Павел Снижко on 24.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var currentWeather: CurrentWeather?
    private let networkManager: NetworkManager = NetworkManager()
    
    
    @IBOutlet weak var viewUnderCityName: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        self.cityNameLabel.text = currentWeather?.cityName
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabelConstraints()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ForecastViewController {
            if let weatherModel = self.currentWeather {
                destination.coord = weatherModel.coord
            }
           
        }
    }

}

extension DetailViewController {
    // MARK: - LabelConstraints
    func setLabelConstraints() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.centerXAnchor.constraint(equalTo: viewUnderCityName.centerXAnchor).isActive = true
        cityNameLabel.centerYAnchor.constraint(equalTo: viewUnderCityName.centerYAnchor).isActive = true
        cityNameLabel.textAlignment = .center
    }
}

// MARK: - DetaSource&Delegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let weatherDetail = currentWeather else { return }
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Location"
            cell.detailTextLabel?.text = "lon: \(weatherDetail.coord.lon)   lat: \(weatherDetail.coord.lat)"
        case 1:
            cell.textLabel?.text = "Short Weather conditions"
            cell.detailTextLabel?.text = "\(weatherDetail.additionalWeather.reduce(" ", { $0 + $1.main } ))"
        case 2:
            cell.textLabel?.text = "Description for weather conditions"
            cell.detailTextLabel?.text = "\(weatherDetail.additionalWeather.reduce(" ", { $0 + $1.description } )) "
        case 3:
            cell.textLabel?.text = "Tepmerature"
            cell.detailTextLabel?.text = "\(weatherDetail.mainWeather.temp) feels like \(weatherDetail.mainWeather.feelsLikeTemp)"
        case 4:
            cell.textLabel?.text = "Min/Max temperature"
            cell.detailTextLabel?.text = "min/max(\(weatherDetail.mainWeather.tempMin)/ \(weatherDetail.mainWeather.tempMax))"
        case 5:
            cell.textLabel?.text = "Pressure"
            cell.detailTextLabel?.text = "\(weatherDetail.mainWeather.pressure) hPa"
        case 6:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = "\(weatherDetail.mainWeather.humidity) %"
        case 7:
            cell.textLabel?.text = "Cloudiness/Visibility"
            cell.detailTextLabel?.text = "\(weatherDetail.clouds.all) % / \(weatherDetail.visibility)"
        case 8:
            cell.textLabel?.text = "Wind(speed/deg)"
            cell.detailTextLabel?.text = "\(weatherDetail.wind.speed)/\(weatherDetail.wind.deg)"
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.detailTableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
    }
    
    
}
