//
//  Catalog.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/26/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}


class CatalogView: UIView {
    
    private let viewModel = ProductsListViewViewModel()
    public weak var delegate: ProductsListViewDelegate?
    
    private let loadedIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        return loader
    }()
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isHidden = true
        view.alpha = 0
//        view.register(<#T##nib: UINib?##UINib?#>, forCellWithReuseIdentifier: <#T##String#>)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, loadedIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        viewModel.state.bind { state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.loadedIndicator.startAnimating()
                case .result:
                    self.loadedIndicator.stopAnimating()
                case .error:
                    self.loadedIndicator.stopAnimating()
                default: break
                }
            }
        }
    }
    
    func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            loadedIndicator.widthAnchor.constraint(equalToConstant: 100),
            loadedIndicator.heightAnchor.constraint(equalToConstant: 100),
            loadedIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadedIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension СatalogView: ProductsListViewViewModelDelegate {
    func didSelectPoduct(_ idProduct: String) {
        delegate?.productsView(self, didSelect: idProduct)
    }
    
    func didLoadInitialProducts() {
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
