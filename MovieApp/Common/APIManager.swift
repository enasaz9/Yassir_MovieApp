//
//  APIManager.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 23/12/2023.
//

import UIKit

enum API_Endpoints: String {
    case moviesList = "discover/movie"
    case movieDetails = "movie/%@"
}

enum BaseURLs: String {
    case APIs = "https://api.themoviedb.org/3/"
    case images = "https://image.tmdb.org/t/p/"
}

protocol APIManagerProtocol {
    func request<T: Codable>(endpoint: String, method: String, parameters: [URLQueryItem]?, mapTo: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerProtocol {

    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyOWQyY2ExZjhkNDY5ZmNkNzQyM2ViZjhiYjFlNTE5OCIsInN1YiI6IjY1ODZjZjA5YjBjZDIwNTI5YjU3YWJkNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayw7JcZoI2tNBPIoGJa2xeCVYnYtATUgZF8x5_YS9Jg"
        
    func request<T: Codable>(endpoint: String, method: String, parameters: [URLQueryItem]?, mapTo: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlComps = URLComponents(string: BaseURLs.APIs.rawValue + endpoint)!
        urlComps.queryItems = parameters
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        guard let url = urlComps.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        // Using URLSession to make the API request
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let decoder = JSONDecoder()
            
            // Decode the API response data
            if let data = data {
                do {
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
