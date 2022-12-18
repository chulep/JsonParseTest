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
        $0.text = NameHelper.searchAlertLabel
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UILabel())
    
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var loadingFooterView: LoadingReusableView?
    
    //MARK: - Init
    
    required convenience init(viewModel: SearchViewModelType) {
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
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(alertLabel)
        view.addSubview(activityIndicator)
    }
    
    private func addConstraints() {
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupSearchBar() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorHelper.purple] , for: .normal)
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifire)
        collectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.identifire)
    }
    
    private func downloadData(searchText: String) {
        activityIndicator.startAnimating()
        alertLabel.isHidden = true
        collectionView.alpha = 0
        collectionView.reloadData()
        viewModel?.getDownloadData(searchText: searchText, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    self?.collectionView.reloadData()
                    self?.collectionView.appearAnimation(withDuration: 0.2, deadline: 0, toAlpha: 1)
                case .failure(let error):
                    self?.errorHandler(error: error)
                }
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    //MARK: - Support Methods
    
    private func errorHandler(error: NetworkError) {
        switch error {
        case .nothingFound:
            alertLabel.text = error.rawValue
            alertLabel.isHidden = false
        default:
            present(UIAlertController(errorMessage: error.rawValue), animated: true)
        }
    }
    
    private func hideKeyboard() {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 - 15)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        return flowLayout
    }
}

//MARK: - Collection View Delegate & Data Sourse

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.result?.count ?? 0
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
        cell.viewModel = viewModel?.createPhotoCellViewModel(indexPath: indexPath)
        cell.setImage()
        return cell
    }
}

//MARK: - CollectionView Pagination

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let endCell = viewModel?.result?.count else { return }
        if indexPath.row == endCell - 2 {
            viewModel?.getDownloadDataNetxPage(completion: { result in
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            })
        }
    }
    
    // download view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel?.isLoading == false {
            return CGSize(width: collectionView.bounds.width, height: 0)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingReusableView.identifire, for: indexPath) as! LoadingReusableView
        loadingFooterView = footer
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        loadingFooterView?.animating(viewModel?.isLoading)
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

