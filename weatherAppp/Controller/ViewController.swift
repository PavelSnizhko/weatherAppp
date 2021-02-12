//
//  ViewController.swift
//  weatherAppp
//
//  Created by Павел Снижко on 23.01.2021.
//

import UIKit

class ViewController: UIViewController {

    private var citiesStorage = CitiesStorage()
    var currentWeathers: [CurrentWeather]?
    
    @IBOutlet weak var temperatureTableView: UITableView!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getCurrentWeathers(by: citiesStorage.getCitiesId(), unit: .metric) { [weak self]  result in
            switch result {
            case .success(let weathers):
                self?.currentWeathers = weathers.currentWeathers
                self?.temperatureTableView.reloadData()
            case .failure(let error):
                self?.makeErrorAllert(error: error.rawValue)
            }
        }
    }
    @IBAction func addNewCity(_ sender: Any) {
        alertWithTextField()
    }
    
}


extension ViewController {
    // MARK: ErrorAlert
    func makeErrorAllert(error: String) {
        let alert = UIAlertController(title: "Error", message: "Oops " + error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: AlertAddingNewCity
    func alertWithTextField() {
        //TODO: Refactor if not fall asleep
        let alert = UIAlertController(title: "Add a new city", message: "The city must be written gramaticaly correct", preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            guard let textField = alert.textFields?[0] else { return }
            guard textField.text != "", let cityName = textField.text else { return }
            self.networkManager.getCurrentWeather(by: cityName, unit: .standard) {[weak self] result in
                switch result {
                case .success(let weather):
                    guard (try? self?.citiesStorage.addCity(city: City(from: weather))) != nil else { self?.makeErrorAllert(error: StorageError.cityAlreadyAdded.rawValue); return }
                    self?.currentWeathers?.append(weather)
                    self?.temperatureTableView.reloadData()
                case .failure(let error):
                    self?.makeErrorAllert(error: error.rawValue)
                }
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your city"
            textField.textColor = .blue
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)

    }
    
}





extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return .init() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.currentWeathers?.count else { return 0 }
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = self.currentWeathers?[indexPath.row].cityName
        if let temperature =  self.currentWeathers?[indexPath.row].mainWeather.temp{
            cell.detailTextLabel?.text = "\(temperature) ℃"
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if let index = self.temperatureTableView.indexPathForSelectedRow?.row, let currentWeather = currentWeathers?[index] {
                destination.currentWeather = currentWeather
            }
           
        }
    }
    
}


