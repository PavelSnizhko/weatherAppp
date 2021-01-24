//
//  DetailViewController.swift
//  weatherAppp
//
//  Created by Павел Снижко on 24.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var currentWeather: CurrentWeather?
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
