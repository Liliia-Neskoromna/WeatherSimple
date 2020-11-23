//
//  ViewController.swift
//  Weather
//
//  Created by Liliia Neskoromna on 23.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var tableViewVC = UITableView()
    
    var listOfWeather = [WeatherDetails]()
    {
        didSet {
            DispatchQueue.main.async {
                let sectionIndex = IndexSet(integer: 0)
                self.tableViewVC.reloadSections(sectionIndex, with: .none)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .tertiarySystemFill
        
        tableViewVC.delegate = self
        tableViewVC.dataSource = self
        
        getWeather()
        
        tableViewVC.tableFooterView = UIView()
    }
    
    func getWeather() {
        let request = UpdateWeatherRequest()
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = weather
            }
        }
    }
    
    func setupTableView() {
        navigationItem.title = "Weather in cities"
        view.addSubview(tableViewVC)
        tableViewVC.translatesAutoresizingMaskIntoConstraints = false
        tableViewVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableViewVC.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableViewVC.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableViewVC.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableViewVC.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell
        else {fatalError("Bad Cell")}
        
        let weather = listOfWeather[indexPath.row]
        
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.cityImage.imageFromServerURL(urlString: string)
        
        cell.cityName.text = weather.name
        
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let t: String = "\(roundTemp.shortValue)" + "°C"
        
        cell.temperature.text = t
        
        let wind: String = "\(weather.wind.speed)" + "m/s"
        cell.speedOfWind.text = wind
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = DetailsInfo()
        
        let weather = listOfWeather[indexPath.row]
        
        destinationVC.cityName.text = weather.name
        
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        destinationVC.cityImage.imageFromServerURL(urlString: string)
        
        let humidity = "\(weather.main.humidity)" + "%"
        destinationVC.humidity.text = humidity
        
        let wind: String = "\(weather.wind.speed)" + "m/s"
        destinationVC.speedOfWind.text = wind
        
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let t: String = "\(roundTemp.shortValue)" + "°C"
        destinationVC.temperature.text = t
        
        self.present(destinationVC, animated: true)
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}
