//
//  NetworkManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import Foundation

final class NetworkManager {
    
    func getPhotos(search: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = prepareParametrs(search: search)
        let url = createURL(parameters: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "Client-ID 6tHmVwpe7J1hrFEV140Yl6lKnnt8T41eCLfThp3yKpc"]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpRespone = response as? HTTPURLResponse
            DispatchQueue.main.async {
                print("Код сети: \(httpRespone!.statusCode)")
                completion(data, error)
            }
        }.resume()
    }
    
    func getPic(url: String?, completion: @escaping (Data?) -> Void){
        guard let urlString = url,
        let urlEnd = URL(string: urlString) else { return }
        let request = URLRequest(url: urlEnd)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data)
        }.resume()

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
    
    private func prepareParametrs(search: String) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["query"] = search
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(10)
        return parametrs
    }
    
    func printJson(data: Data?) {
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
