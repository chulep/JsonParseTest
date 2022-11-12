//
//  CollectionViewCell.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "idCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func setImage(imageData: Data?) {
        guard let imageData = imageData else { return }
        imageView.image = UIImage(data: imageData)!
    }
}
