//
//  HomeViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 9/1/23.
//

import Foundation

final class HomeViewModel {
    private let service: AdvertisementServiceProtocol
    
    init(service: AdvertisementServiceProtocol) {
        self.service = service
    }
    
    var viewState: Observable<ViewState<[Advertisement]>> = Observable(ViewState.none)
    
    func fetchAdvertisements() {
        viewState.value = .loading
        service.fetchAdvertisements { result in
            switch result {
            case .success(let data):
                self.viewState.value = .loaded(data.advertisements)
            case .failure(let error):
                self.viewState.value = .error(error.localizedDescription)
            }
        }
    }
}
