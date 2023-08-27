//
//  DetailViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/27/23.
//

import Foundation

final class DetailPageViewViewModel: NSObject {
    
    var product: DetailPage! {
        didSet {
            self.bindDetailPageViewModelToController()
        }
    }
    
    var bindDetailPageViewModelToController : (() -> ()) = {}
    var state: StateBinding = StateBinding(State.none)
    
    public func fetchDetailInfo(with id: String) {
        state.value = .loading
        APICaller.shared.getDetailInfo(with: id) { [weak self] result in
            switch result {
            case .success(let product):
                self?.state.value = .result
                DispatchQueue.main.async {
                    self?.product = product
                }
            case .failure(let error):
                self?.state.value = .error
                fatalError(error.localizedDescription)
            }
        }
    }
}
