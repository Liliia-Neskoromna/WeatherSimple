//
//  NetworkServices.swift
//  Weather
//
//  Created by Liliia Neskoromna on 23.11.2020.
//

import Foundation

enum UpdateWeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct UpdateWeatherRequest {
    
    var resourceURL: URL
    let API_KEY = "35b80fc7e92ced8b98ba88190b7b274b"
    
    init () {
        let joinedId = CitiesId().getCityId()
        
        let resourceString = "https://api.openweathermap.org/data/2.5/group?id=\(joinedId)&units=metric&APPID=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getWeather(completion: @escaping(Result<[WeatherDetails], UpdateWeatherError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                let weatherDetails: Array<WeatherDetails> = weatherResponse.list
                completion(.success(weatherDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

struct CitiesId {
    func getCityId() -> String {
        let array = [524901, 703448, 2643743, 2172797]
        let stringArray = array.map { String($0) }
        let string = "\(stringArray.joined(separator: ","))"
        return string
    }
}
