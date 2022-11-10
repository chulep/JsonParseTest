//
//  ViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getPhotos(search: "test") { data, error in
            guard let data = data else { return }
            do {
                let parseData = try JSONDecoder().decode(NetworkModel.self, from: data)
                print(parseData)
            } catch {
                print(error, error.localizedDescription)
            }
            
        }
    }
    
}

