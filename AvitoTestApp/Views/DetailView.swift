//
//  DetailView.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/28/23.
//

import Foundation
import SDWebImage

class DetailView: UIScrollView{
    
    private let contentForScrollView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.isExclusiveTouch = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yourPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Предложить свою цену >", for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .left
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Написать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
                
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = "Описание"
        label.textColor = .black
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(with model: DetailPage) {
        titleLabel.text = model.title
        priceLabel.text = model.price
        descriptionLabel.text = model.description
        addressLabel.text = "\(model.location), \(model.address)"

        if let imageURL = URL(string: model.image_url) {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageURL)
        }
    }
    
    private func setupView() {
        addSubview(contentForScrollView)
        contentForScrollView.addSubviews(imageView,
                                         priceLabel,
                                         titleLabel,
                                         yourPriceButton,
                                         buttonStack,
                                         addressLabel,
                                         headerLabel,
                                         descriptionLabel)
        buttonStack.addArrangedSubview(callButton)
        buttonStack.addArrangedSubview(sendMessageButton)
        
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        let buttonSize = UIScreen.main.bounds.width / 2 - 20
        NSLayoutConstraint.activate([
            
            contentForScrollView.topAnchor.constraint(equalTo: topAnchor),
            contentForScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentForScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentForScrollView.widthAnchor.constraint(equalTo: widthAnchor),
            contentForScrollView.heightAnchor.constraint(equalTo: heightAnchor),
            contentForScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentForScrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            yourPriceButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            yourPriceButton.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            yourPriceButton.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            buttonStack.topAnchor.constraint(equalTo: yourPriceButton.bottomAnchor, constant: padding),
            buttonStack.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor,constant: padding),
            buttonStack.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            sendMessageButton.widthAnchor.constraint(equalToConstant: buttonSize),
            
            addressLabel.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: padding),
            addressLabel.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            headerLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding),
            headerLabel.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            headerLabel.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentForScrollView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentForScrollView.trailingAnchor, constant: -padding)

        ])
    }
}
