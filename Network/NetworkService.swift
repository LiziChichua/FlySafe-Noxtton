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
        
        //Initialise variable to hold query data
        var queryItems: [URLQueryItem] = []
         
         request.queryItems.forEach {
             let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
             //urlComponent.queryItems?.append(urlQueryItem)
             queryItems.append(urlQueryItem)
         }
         
         urlComponent.queryItems = queryItems
        
        //Initialise variable to hold Body data
        var bodyItems: Data?
        
        if !request.bodyItems.isEmpty {
            do {
                bodyItems = try JSONSerialization.data(withJSONObject: request.bodyItems, options: .prettyPrinted)
            } catch let error {
                return completion(.failure(error))
            }
        }
        
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
        //Add HTTP body to request
        if let serializedBody = bodyItems {
            urlRequest.httpBody = serializedBody
        }
        //Set body content type to JSON for HTTP Request
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //Start URLSession dataTask
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            } else if let data = data {
//                print ("Json raw data: \(data.prettyPrintedJSONString)")
                do {
                    try completion(.success(request.decode(data)))
                } catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
    }
}
