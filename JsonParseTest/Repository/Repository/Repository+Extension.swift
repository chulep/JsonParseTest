//
//  Repository + Extencions.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

extension Repository {
    
    //MARK: - Support Methods
    
    internal func createRequest(searchText: String, page: Int) -> URLRequest {
        let parameters = prepareParametrs(searchText: searchText, page: page)
        let url = createURL(parameters: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ConstantHelper.keyApi
        
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
    
    private func prepareParametrs(searchText: String, page: Int) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["query"] = searchText
        parametrs["page"] = String(page)
        parametrs["per_page"] = String(30)
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
