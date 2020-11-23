//
//  CustomCell.swift
//  Weather
//
//  Created by Liliia Neskoromna on 23.11.2020.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let cityImage = UIImageView()
    let cityName = UILabel()
    let temperature = UILabel()
    let speedOfWind = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityName.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        speedOfWind.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cityImage)
        contentView.addSubview(cityName)
        contentView.addSubview(temperature)
        contentView.addSubview(speedOfWind)
        
        let views = [
            "image" : cityImage,
            "name"  : cityName,
            "temp" : temperature,
            "speed": speedOfWind,
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(50)]", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[speed(50)]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name(50)]-[temp]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-[name]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[temp]-[speed]-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
