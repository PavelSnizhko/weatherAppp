//
//  ForecastViewController.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import UIKit

class ForecastViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var listOfDailyForecast: [DailyForecast]?
    private var fourDays: [String] = Date.getDayDate()
    private let cellId = String(describing: ForecastCollectionViewCell.self)
    
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    var coord: Coordinates?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cityCoord = coord else { return }
        networkManager.getDailyForecast(by: (cityCoord.lon, cityCoord.lat), unit: .standard, excludes: [.minutely, .hourly, .current, .alerts ]) { [weak self]  result in
            switch result {
            case .success(let weathers):
                self?.listOfDailyForecast = Array(weathers.daily[0..<4])
                self?.forecastCollectionView.reloadData()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}



extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fourDays.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as? ForecastCollectionViewCell else { return  UICollectionViewCell()}
        print(indexPath.row)
        cell.forecast = listOfDailyForecast?[indexPath.section]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderlabel.text = "\(String(describing: fourDays[indexPath.section]))"
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
}


// MARK: - Date Extension

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
  
    static func getDayDate() -> [String]{
        var listOfDate: [String] = []
        var dayComponent = DateComponents()
        for day in  1..<5 {
            dayComponent.day = day // For removing one day (yesterday): -1
            let nextDate = Calendar.current.date(byAdding: dayComponent, to: Date())
            guard let dayName = nextDate?.dayOfWeek() else { return [] }
            listOfDate.append("\(dayName)")
        }
        return listOfDate
    }
    
    
}
