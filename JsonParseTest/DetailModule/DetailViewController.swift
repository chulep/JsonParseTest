//
//  DetailViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 12.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var networkManager = NetworkManager()
    var result: Results!
    var imageView = UIImageView()
    var nameLebel = UILabel()
    var dateLabel = UILabel()
    var descriptionLabel = UILabel()
    var descriptionStackView = UIStackView()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        addHideTapGestureRecognizer()
        setInfo()
        setImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionStackView.layer.cornerRadius = descriptionStackView.bounds.height / 10
        descriptionLabel.clipsToBounds = true
    }
    
    //MARK: - Set Data
    func setInfo() {
        nameLebel.text = "Name: " + (result.user?.username ?? "")
        dateLabel.text = "Date: " + result.created_at
        descriptionLabel.text = "Description: " + (result.description ?? "")
    }
    
    func setImage() {
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
    func createUI() {
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveToFavorites))
        navigationController?.navigationBar.tintColor = .systemGray
        
        descriptionStackView = UIStackView(arrangedSubviews: [dateLabel, nameLebel, descriptionLabel])
        descriptionStackView.alignment = .fill
        descriptionStackView.distribution = .fillEqually
        descriptionStackView.axis = .vertical
        descriptionStackView.backgroundColor = #colorLiteral(red: 0.8627251983, green: 0.8735858798, blue: 0.8733949065, alpha: 1)
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.layoutMargins = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        descriptionStackView.isLayoutMarginsRelativeArrangement = true
        
        for i in [imageView, descriptionStackView, activityIndicator] {
            view.addSubview(i)
        }
        
        imageView.frame = view.bounds
        activityIndicator.center = imageView.center
        NSLayoutConstraint.activate([
            descriptionStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            descriptionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            descriptionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionStackView.heightAnchor.constraint(equalTo: descriptionStackView.widthAnchor, multiplier: 1/3)
        ])
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
    
    //MARK: - Cancel Method
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func saveToFavorites() {
        
    }
}
