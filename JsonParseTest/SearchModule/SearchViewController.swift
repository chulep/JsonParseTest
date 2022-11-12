//
//  ViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import UIKit

class SearchViewController: UICollectionViewController, UISearchBarDelegate {
    
    let networkManager = NetworkManager()
    var photos: PicModel?
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifire)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos?.results.count ?? 0)
        return photos?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifire, for: indexPath) as! PhotoCollectionViewCell
        networkManager.getPic(url: photos?.results[indexPath.row].urls.small) { data in
            DispatchQueue.main.async {
                cell.setImage(imageData: data)
            }
        }
        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        networkManager.getPhotos(search: searchBar.text ?? "other") { data, error in
            guard let data = data else { return }
            do {
                self.photos = try JSONDecoder().decode(PicModel.self, from: data)
                self.collectionView.reloadData()
            } catch {
                print(error, error.localizedDescription)
            }
        }
    }
    
    @objc func hideKeyboard() {
        searchBar.endEditing(true)
    }
    
}

