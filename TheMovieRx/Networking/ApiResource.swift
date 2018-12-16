//
//  ApiResource.swift
//  DarkSkyWeather
//
//  Created by Suman Chatterjee on 14/02/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import Foundation

enum MovieQueryType:String {
    case popular
    case topRated = "top_rated"
    case upcoming
    case none
}


enum ApiError: Error {
    case keyNotFound
    case serverFailure
    
}

protocol ApiResource {
    func buildRequest(method: String, requestType: MovieQueryType, params: [(String, String)]) -> URLRequest?
    
}

extension ApiResource {
    
    func buildRequest(method: String = "GET", requestType: MovieQueryType, params: [(String, String)] = []) -> URLRequest? {
        guard let baseUrl = Constant.baseURL else { return nil }
        var request = URLRequest(url: baseUrl)
        let url = baseUrl.appendingPathComponent("movie").appendingPathComponent(requestType.rawValue)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constant.apiKey)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if method == "GET" {
            var queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
            queryItems.append(apiKeyQueryItem)
            queryItems.append(languageQueryItem)
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems = [apiKeyQueryItem,languageQueryItem]
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.url = urlComponents.url
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
        
    }
    
}
