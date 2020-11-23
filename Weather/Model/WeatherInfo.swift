//
//  WeatherInfo.swift
//  Weather
//
//  Created by Liliia Neskoromna on 23.11.2020.
//

import Foundation

struct WeatherResponse: Codable, Hashable {
    var list: [WeatherDetails]
}
struct WeatherDetails: Codable, Hashable {
    var main: Main
    var wind: Wind
    var name: String?
    var weather: [Weather]
}

struct Wind: Codable, Hashable {
    var speed: Float
}

struct Main: Codable, Hashable {
    var temp: Float
    var humidity: Int
}

struct Weather: Codable, Hashable {
    var icon: String
}
