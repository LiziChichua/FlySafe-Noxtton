//
//  WeatherManager.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation


protocol WeatherManagerProtocol: AnyObject {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping ((Result<Weather, Error>) -> Void))
}

// MARK: - WeatherManager
class WeatherManager: WeatherManagerProtocol {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping ((Result<Weather, Error>) -> Void)){
        let url = "https://api.weatherapi.com/v1/current.json?key=ca3b29ef1f454c40ad7150622221601&q=\(lat),\(lon)&aqi=no"
        NetworkManager.shared.get(url: url) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}


// MARK: - Network Manager
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
