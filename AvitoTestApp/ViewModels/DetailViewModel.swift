//
//  DetailViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 9/1/23.
//

import Foundation

final class DetailViewModel {
    var service: AdvertisementServiceProtocol = AdvertisementService.advertisementService
    var viewState: Observable<ViewState<Detail>> = Observable(ViewState.none)
    
    func fetchDetailInfo(id: String) {
        viewState.value = .loading
        service.fetchDetailAdvertisement(id: id) { result in
            switch result {
            case .success(let data):
                self.viewState.value = .loaded(data)
            case .failure(let error):
                self.viewState.value = .error(error.localizedDescription)
            }
        }
    }
}
