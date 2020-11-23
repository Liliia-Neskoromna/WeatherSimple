//
//  DetailsInfo.swift
//  Weather
//
//  Created by Liliia Neskoromna on 23.11.2020.
//

import UIKit

final class DetailsInfo: UIViewController {
    
    let cityImage = UIImageView()
    let cityName = UILabel()
    let temperature = UILabel()
    let speedOfWind = UILabel()
    let humidity = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityName.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        speedOfWind.translatesAutoresizingMaskIntoConstraints = false
        humidity.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(cityImage)
        view.addSubview(cityName)
        view.addSubview(temperature)
        view.addSubview(speedOfWind)
        view.addSubview(humidity)
        
        let views = [
            "image" : cityImage,
            "name"  : cityName,
            "temp" : temperature,
            "speed": speedOfWind,
            "humidity":humidity,
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(150)]", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[speed]-[humidity]-600-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name(50)]-[temp(50)]-[humidity]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(150)]-[name(150)]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[temp]-[speed]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[temp]-[humidity]-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
