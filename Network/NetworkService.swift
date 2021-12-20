//
//  NetworkService.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}


final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        //Safely initializes urlComponnent with given url
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(
                domain: "Could not create URLComponents Struct with given url",
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }
        
        //Initialise variable to hold Query Items
        var queryItems: [URLQueryItem] = []
        
        //Append query items to urlComponnents
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        urlComponent.queryItems = queryItems
        
        //Safely retrive URL from urlComponent
        guard let url = urlComponent.url else {
            let error = NSError(
                domain: "Could not extract url from urlComponnent",
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }
        
        //Make new request from URL extracted above
        var urlRequest = URLRequest(url: url)
        //Add HTTP method to request
        urlRequest.httpMethod = request.method.rawValue
        //Add HTTP headers to request
        urlRequest.allHTTPHeaderFields = request.headers
        
        //Start URLSession dataTask
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NSError()))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
