//
//  CollectionViewCell.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import UIKit

final class PictureCell: UICollectionViewCell, PictureCellType {
    
    static let identifire = "idCell"
    var viewModel: PictureCellViewModelType?
    
    //MARK: - UI Elements
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = ColorHelper.lightGray
        addSubviews()
        setupUI()
        setImage()
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ?  0.5 : 1
        }
    }
    
    //MARK: - Methods
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(activityIndicator)
    }
    
    private func setupUI() {
        imageView.frame = bounds
        activityIndicator.center = imageView.center
        layer.cornerRadius = ConstantHelper.radius
        clipsToBounds = true
    }
    
    private func setImage() {
        activityIndicator.startAnimating()
        viewModel?.getDownloadImage(completion: { [weak self] data in
            guard let data = data,
            let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.imageView.image = image
            }
        })
    }
}
