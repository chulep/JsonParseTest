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
    var stackViewLabels = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setInfo()
        setImage()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(descriptionAnimation))
        view.addGestureRecognizer(tap)
    }
    
    func setInfo() {
        nameLebel.text = "Name: " + (result.user?.username ?? "")
        dateLabel.text = "Date: " + result.created_at
        descriptionLabel.text = "Description: " + (result.description ?? "")
    }
    
    func setImage() {
        networkManager.getPic(url: result.urls.full) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func createUI() {
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancel))
        
        stackViewLabels = UIStackView(arrangedSubviews: [dateLabel, nameLebel, descriptionLabel])
        stackViewLabels.alignment = .fill
        stackViewLabels.distribution = .fillEqually
        stackViewLabels.axis = .vertical
        stackViewLabels.backgroundColor = .lightGray
        stackViewLabels.translatesAutoresizingMaskIntoConstraints = false
        
        for i in [imageView, stackViewLabels] {
            view.addSubview(i)
        }
        
        imageView.frame = view.bounds
        NSLayoutConstraint.activate([
            stackViewLabels.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            stackViewLabels.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            stackViewLabels.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackViewLabels.heightAnchor.constraint(equalTo: stackViewLabels.widthAnchor, multiplier: 1/3)
        ])
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func descriptionAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.stackViewLabels.alpha == 1 ? (self.stackViewLabels.alpha = 0) : (self.stackViewLabels.alpha = 1)
        }
    }

}
