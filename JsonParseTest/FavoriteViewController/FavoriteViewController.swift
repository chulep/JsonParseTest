//
//  FavoriteViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Save"
        setupCollectionView()
    }
    
    //MARK: - CollectionView Configure
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifire)
    }
    
    private func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 - 15)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }
    
}
    //MARK: - CollectionView Delegate & DataSourse
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifire, for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
    
}
