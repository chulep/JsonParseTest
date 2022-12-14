//
//  FavoriteViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

final class FavoriteViewController: UIViewController, FavoriteViewControllerType {
    
    private var viewModel: FavoriteViewModelType?
    
    //MARK: - UI Elements
    
    private lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCollectionViewFlowLayout())
    
    private var alertLabel: UILabel = {
        $0.textColor = ColorHelper.lightGray
        $0.text = NameHelper.noFavoriteLabel
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UILabel())
    
    //MARK: - Init
    
    convenience init(viewModel: FavoriteViewModelType) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupSelf()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        addSubviews()
        addConstraints()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    //MARK: - Methods
    
    private func setupSelf() {
        view.backgroundColor = ColorHelper.white
        tabBarItem.title = NameHelper.favoriteTabBarName
        tabBarItem.image = UIImage(systemName: "heart")
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(alertLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifire)
    }
    
    private func setData() {
        viewModel?.getData(completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    self?.collectionView.reloadData()
                    self?.hideAllertLabel()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    //MARK: - Suppert Methods
    
    private func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 - 15)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }
    
    private func hideAllertLabel() {
        if viewModel?.pictureArray?.count != 0 {
            alertLabel.isHidden = true
        } else {
            alertLabel.isHidden = false
        }
    }
}
    
    //MARK: - CollectionView Delegate & DataSourse

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.pictureArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewModel = viewModel?.createDetailViewModel(indexPath: indexPath)
        present(ModuleBuilder.createDetailModule(viewModel: detailViewModel), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifire, for: indexPath) as! PictureCell
        cell.viewModel = viewModel?.createCellViewModel(indexPath: indexPath)
        cell.setImage()
        return cell
    }
    
}
