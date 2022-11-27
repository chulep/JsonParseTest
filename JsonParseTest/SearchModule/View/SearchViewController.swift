//
//  ViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterType?
    
    //MARK: - UI elements
    
    var searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
    
    //MARK: - Init
    
    convenience init(presenter: SearchPresenterType) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupSearchBar()
        setupCollectionView()
        downloadData(searchText: "text")
    }
    
    //MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifire)
    }
    
    private func downloadData(searchText: String) {
        presenter?.getDownloadData(searchText: searchText, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    self?.collectionView.reloadData()
                case .failure(_):
                    break
                }
            }
        })
    }
    
    //MARK: - Support Methods
    private func hideKeyboard() {
        searchBar.endEditing(true)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 - 15)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }
}

//MARK: - Collection View Delegate & Data Sourse

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.result?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    //data sourse
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifire, for: indexPath) as! PhotoCollectionViewCell
        cell.presenter = presenter?.createPhotoCellPresenter(indexPath: indexPath)
        return cell
    }
}

//MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        downloadData(searchText: searchBar.text ?? "")
        hideKeyboard()
    }
}

