//
//  TodayWeatherTableViewController.swift
//  HavaDurumu
//
//  Created by Flyco Developer on 22.05.2018.
//  Copyright © 2018 Flyco Global. All rights reserved.
//

import UIKit

class TodayWeatherTableViewController: UITableViewController {

    //MARK: Variables
    var cityName = "";
    var currentWeather = "";
    
    var refreshAction = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        getTodayResult()
        refreshAction.addTarget(self, action: #selector(refreshNow), for: .valueChanged)
        refreshAction.tintColor = UIColor.red
        self.tableView.addSubview(refreshAction)
        
    }

    @objc func refreshNow() {
        cityName = "istanbul"
        self.refreshAction.endRefreshing()
        getTodayResult()
    }
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayweatherTableViewCell
        cell.selectedText.text = "Seçtiğiniz şehit \(cityName)"
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherResultCell", for: indexPath) as! TodayWeatherResultTableViewCell
            cell.resultText.text = currentWeather
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func getTodayResult() {
        let url = URL(string : "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=4e4ab59459ce090c42e5903556615271")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let incommingData = data {
                    do {
                    let jsonResult = try JSONSerialization.jsonObject(with: incommingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //print(jsonResult)
                        print(jsonResult["weather"])
                        let weather = jsonResult["weather"] as! NSArray
                        let weather1 = weather.firstObject as! [String:AnyObject]
                        if let description = weather1["description"] as? String {
                            print("Seçtiğin şehrin hava durumu \(description)")
                            DispatchQueue.main.sync(execute: {
                                self.currentWeather = description
                                self.tableView.reloadData()
                            })
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }
        }
        task.resume()
    }

   
}
