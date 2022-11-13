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
        
        networkManager.getPhotos(search: "other") { data, error in
            guard let data = data else { return }
            do {
                self.photos = try JSONDecoder().decode(PicModel.self, from: data)
                self.collectionView.reloadData()
            } catch {
                print(error, error.localizedDescription)
            }
        }
    }
    
    //MARK: - CollectionView DataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hideKeyboard()
        let detailViewController = DetailViewController()
        detailViewController.result = photos?.results[indexPath.row]
        let navController = UINavigationController(rootViewController: detailViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    //MARK: - ScrollView Delegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    //MARK: - SearchBar Delegate
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
        hideKeyboard()
    }
    
    private func hideKeyboard() {
        searchBar.endEditing(true)
    }
    
}

