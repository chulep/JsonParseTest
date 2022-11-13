//
//  DetailViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 12.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var networkManager = NetworkManager()
    
    var result: Results! {
        didSet {
            nameLebel.text = "Name: " + (result.user?.username ?? "")
            dateLabel.text = "Date: " + result.created_at
            descriptionLabel.text = "Description: " + (result.description ?? "")
        }
    }
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    var nameLebel = UILabel()
    var dateLabel = UILabel()
    var descriptionLabel = UILabel()
    
    lazy var descriptionStackView: UIStackView = {
        for i in [dateLabel, nameLebel, descriptionLabel] {
            $0.addArrangedSubview(i)
        }
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.backgroundColor = #colorLiteral(red: 0.8627251983, green: 0.8735858798, blue: 0.8733949065, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        $0.style = .medium
        return $0
    }(UIActivityIndicatorView())
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in [imageView, descriptionStackView, activityIndicator] {
            view.addSubview(i)
        }
        setupNavBar()
        createLayout()
        addHideTapGestureRecognizer()
        setImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionStackView.layer.cornerRadius = descriptionStackView.bounds.height / 10
        descriptionStackView.clipsToBounds = true
    }
    
    //MARK: - Set Data
    private func setImage() {
        activityIndicator.startAnimating()
        networkManager.getPic(url: result.urls.full) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.descriptionAutoHide()
            }
        }
    }
    
    //MARK: - UI
    private func createLayout() {
        imageView.frame = view.bounds
        activityIndicator.center = imageView.center
        
        NSLayoutConstraint.activate([
            descriptionStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionStackView.heightAnchor.constraint(equalTo: descriptionStackView.widthAnchor, multiplier: 1/3)
        ])
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelDetail))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveToFavorites)),
            UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePhoto))]
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
    
    //MARK: - objc Method
    @objc func cancelDetail() {
        dismiss(animated: true)
    }
    
    @objc func saveToFavorites() {
        
    }
    
    @objc func sharePhoto() {
        let share = UIActivityViewController(activityItems: [result.urls.full], applicationActivities: nil)
        present(share, animated: true)
    }
}
