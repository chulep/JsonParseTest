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
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Init
    
    convenience init(presenter: DetailViewModelType?) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = presenter
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionStackView.layer.cornerRadius = descriptionStackView.bounds.height / 10
        descriptionStackView.clipsToBounds = true
    }
    
    //MARK: - Add Subviews
    
    private func addSubviews() {
        descriptionStackView.addArrangedSubview(dateLabel)
        descriptionStackView.addArrangedSubview(nameLebel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(imageView)
        view.addSubview(descriptionStackView)
        view.addSubview(activityIndicator)
    }
    
    //MARK: - UI
    
    private func addConstraints() {
        imageView.frame = view.bounds
        activityIndicator.center = imageView.center
        
        NSLayoutConstraint.activate([
            descriptionStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionStackView.heightAnchor.constraint(equalTo: descriptionStackView.widthAnchor, multiplier: 1/3)
        ])
    }
    
    private func addNavigationItem() {
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelDetail))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: viewModel!.barButtonImageName()), style: .plain, target: self, action: #selector(saveToFavorites)),
            UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePhoto))]
    }
    
    //MARK: - Set Data Method
    
    private func setData() {
        activityIndicator.startAnimating()
        nameLebel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        dateLabel.text = viewModel?.date
        
        viewModel?.getImage(completion: { data in
            DispatchQueue.main.async {
                guard let data = data,
                let image = UIImage(data: data) else { return }
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
                self.descriptionAutoHide()
            }
        })
    }
    
    //MARK: - Description Hide Methods
    
    private func addHideTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(descriptionTapHide))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func descriptionTapHide() {
        UIView.animate(withDuration: 0.2) {
            self.descriptionStackView.alpha == 1 ? (self.descriptionStackView.alpha = 0) : (self.descriptionStackView.alpha = 1)
        }
    }
    
    private func descriptionAutoHide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            UIView.animate(withDuration: 0.2) {
                self.descriptionStackView.alpha = 0
            }
        }
    }
    
    //MARK: - Other Methods
    
    @objc private func cancelDetail() {
        dismiss(animated: true)
    }
    
    @objc private func saveToFavorites() {
        viewModel?.saveFavorite()
        addNavigationItem()
    }
    
    @objc private func sharePhoto() {
        guard let url = viewModel?.url else { return }
        let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(share, animated: true)
    }
}
