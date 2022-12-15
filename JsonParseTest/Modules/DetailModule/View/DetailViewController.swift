//
//  DetailViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 12.11.2022.
//

import UIKit

final class DetailViewController: UIViewController, DetailViewControllerType {
    
    private var viewModel: DetailViewModelType?

    //MARK: - UI Elements
    
    private var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        return $0
    }(UIImageView())
    
    private var nameLebel = UILabel()
    private var dateLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    private var descriptionStackView: UIStackView = {
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.backgroundColor = ColorHelper.lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layer.cornerRadius = ConstantHelper.radius
        return $0
    }(UIStackView())
    
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Init
    
    convenience init(viewModel: DetailViewModelType?) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addNavigationItem()
        addConstraints()
        addHideTapGestureRecognizer()
        setData()
    }
    
    //MARK: - Add Subviews
    
    private func addSubviews() {
        descriptionStackView.addArrangedSubview(nameLebel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(dateLabel)
        
        view.addSubview(imageView)
        view.addSubview(descriptionStackView)
        view.addSubview(activityIndicator)
    }
    
    //MARK: - UI
    
    private func addNavigationItem() {
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelDetail))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(isFavorite: viewModel?.isFavorite), style: .plain, target: self, action: #selector(saveToFavorites)),
            UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePhoto))]
        UINavigationBar.appearance().backgroundColor = ColorHelper.white
    }
    
    private func addConstraints() {
        imageView.frame = view.bounds
        activityIndicator.center = imageView.center
        
        NSLayoutConstraint.activate([
            descriptionStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            descriptionStackView.heightAnchor.constraint(equalTo: descriptionStackView.widthAnchor, multiplier: 1/3)
        ])
    }
    
    //MARK: - Set Data Method
    
    private func setData() {
        activityIndicator.startAnimating()
        nameLebel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        dateLabel.text = viewModel?.date
        
        viewModel?.getImage(completion: { [weak self] data in
            DispatchQueue.main.async {
                guard let data = data,
                let image = UIImage(data: data) else { return }
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
                self?.descriptionAppear()
            }
        })
    }
    
    //MARK: - Description Hide Methods
    
    private func addHideTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(descriptionTapHide))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func descriptionTapHide() {
        navigationController?.navigationBar.appearAnimation(currentAlpha: Double(navigationController!.navigationBar.alpha), withDuration: 0.2)
        descriptionStackView.appearAnimation(currentAlpha: descriptionStackView.alpha, withDuration: 0.2)
    }
    
    private func descriptionAppear() {
        descriptionStackView.appearAnimation(withDuration: 0.2, deadline: 1.2, toAlpha: 0)
        navigationController?.navigationBar.appearAnimation(withDuration: 0.2, deadline: 1.2, toAlpha: 0)
    }
    
    //MARK: - Other Methods
    
    @objc private func cancelDetail() {
        dismiss(animated: true)
    }
    
    @objc private func saveToFavorites() {
        viewModel?.saveFavorite(completion: { [weak self] error in
            if let error = error { self?.present(UIAlertController(errorMessage: error.rawValue), animated: true) }
        })
        addNavigationItem()
    }
    
    @objc private func sharePhoto() {
        guard let url = viewModel?.url else { return }
        let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(share, animated: true)
    }
}
