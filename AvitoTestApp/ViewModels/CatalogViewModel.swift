//
//  CatalogViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/26/23.
//

import UIKit

protocol ProductsListViewViewModelDelegate: AnyObject {
    func didSelectPoduct(_ product: String)
    func didLoadInitialProducts()
}

final class CatalogViewModel: NSObject {
    
    private var cellViewModel: [ProductCellViewModel] = []
    var state: StateBinding = StateBinding(State.none)
}
