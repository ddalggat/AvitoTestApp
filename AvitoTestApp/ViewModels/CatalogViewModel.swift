//
//  CatalogViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/26/23.
//

import UIKit

protocol CatalogViewModelDelegate: AnyObject {
    func didSelectPoduct(_ product: String)
    func didLoadInitialProducts()
}

final class CatalogViewModel: NSObject {
    
    private var cellViewModel: [ProductCellViewModel] = []
    var state: StateBinding = StateBinding(State.none)
    
    private var products: [MainInfo] = [] {
        didSet {
            for product in products {
                let viewModel = ProductCellViewModel(
                    imageUrl: product.image_url,
                    productName: product.title,
                    price: product.price,
                    location: product.location,
                    created_date: product.created_date)
                cellViewModel.append(viewModel)
            }
        }
    }
    
    public weak var delegate: CatalogViewModelDelegate?
    
//    public func fetchProductsList() {
//        state.value = .loading
//        APICaller.shared.getProductsList() { [weak self] result in
//            switch result {
//            case .success(let product):
//                self?.state.value = .result
//                self?.products = product
//                DispatchQueue.main.async {
//                    self?.delegate?.didLoadInitialProducts()
//                }
//            case .failure(let error):
//                self?.state.value = .error
//                fatalError(error.localizedDescription)
//            }
//        }
//    }
    
    func fetchProductsList() {
    func fetchProductsList() {
        state.value = .loading
        APICaller.shared.getProductsList() { result in
            switch result {
            case .success(let data):
                self.state.value = .result
            case .failure(let error):
                self.state.value = .error
            }
        }
    }
}
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    
    extension CatalogViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let bounds = UIScreen.main.bounds.width
            let width = (bounds - 30) / 2
            let height = width * 1.6
            return CGSize(width: width, height: height)
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    extension CatalogViewModel: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            cellViewModel.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.reuseId, for: indexPath) as? ProductCellView else {
                fatalError()
            }
            cell.config(with: cellViewModel[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let product = products[indexPath.row]
            delegate?.didSelectPoduct(product.id)
        }
}
