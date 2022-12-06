//
//  Repository + Extencions.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

extension Repository {
    
    //MARK: - Support Methods
    
    internal func createRequest(searchText: String) -> URLRequest {
        let parameters = prepareParametrs(searchText: searchText)
        let url = createURL(parameters: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "Client-ID 6tHmVwpe7J1hrFEV140Yl6lKnnt8T41eCLfThp3yKpc"]
        
        return request
    }
    
    private func createURL(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
        return components.url!
    }
    
    private func prepareParametrs(searchText: String) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["query"] = searchText
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(10)
        return parametrs
    }
    
    private func printJsonString(data: Data?) {
        guard let data = data else { return }
        do {
            let data = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "Convert Error")
        } catch {
            print(error.localizedDescription)
        }
    }
}
