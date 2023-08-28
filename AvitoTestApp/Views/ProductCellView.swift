//
//  ProductCellView.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/28/23.
//

import Foundation
import SDWebImage

class ProductCellView: UICollectionViewCell {
    
    static let reuseId = "product"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        createdDateLabel.text = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(with viewModel: ProductCellViewModel) {
        titleLabel.text = viewModel.productName
        priceLabel.text = viewModel.price
        locationLabel.text = viewModel.location
        createdDateLabel.text = viewModel.created_date
        
        if let imageURL = URL(string: viewModel.imageUrl ?? "") {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageURL)
        }
    }
    
    private func setupView() {
        contentView.addSubviews(imageView,
                                titleLabel,
                                favoriteButton,
                                priceLabel,
                                locationLabel,
                                createdDateLabel)
    }
    
    private func setImageSize() ->  [NSLayoutConstraint]{
        let imageSize = UIScreen.main.bounds.width / 2 - 20
        let priorityLayout = UILayoutPriority(rawValue: 999)
        
        let imageWidth = imageView.widthAnchor.constraint(equalToConstant: imageSize)
        let imageHeight = imageView.heightAnchor.constraint(equalToConstant: imageSize)
        
        imageWidth.priority = priorityLayout
        imageHeight.priority = priorityLayout
        
        return[imageWidth, imageHeight]
    }
    
    private func setConstraints() {
        let imageWidth = setImageSize()[0]
        let imageHeight = setImageSize()[1]
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageWidth, imageHeight,
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            createdDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

