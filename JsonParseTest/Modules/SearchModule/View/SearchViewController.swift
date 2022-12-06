//
//  ViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import UIKit

final class SearchViewController: UIViewController, SearchViewControllerType {
    
    private var viewModel: SearchViewModelType?
    
    //MARK: - UI elements
    
    private var searchBar = UISearchBar()
    
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
    
    private var alertLabel: UILabel = {
        $0.textColor = ColorHelper.lightGray
        $0.text = NameHelper.searchTaskLabel
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UILabel())
    
    //MARK: - Init
    
    convenience init(viewModel: SearchViewModelType) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        addSubviews()
        setupSearchBar()
        setupCollectionView()
        addConstraints()
    }
    
    //MARK: - Methods
    
    private func setupSelf() {
        view.backgroundColor = .white
        navigationController?.tabBarItem.title = NameHelper.seacrhTabBarName
        navigationController?.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(alertLabel)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifire)
    }
    
    private func downloadData(searchText: String) {
        viewModel?.getDownloadData(searchText: searchText, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    self?.collectionView.reloadData()
                    self?.alertLabel.isHidden = true
                case .failure(_):
                    break
                }
            }
        })
    }
    
    //MARK: - Support Methods
    
    private func hideKeyboard() {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
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
        viewModel?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewModel = viewModel?.createDetailViewModel(indexPath: indexPath)
        present(ModuleBuilder.createDetailModule(viewModel: detailViewModel), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    //data sourse
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifire, for: indexPath) as! PictureCell
        let cellViewModel = viewModel?.createPhotoCellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

//MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        downloadData(searchText: searchBar.text ?? "")
        hideKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }

}

