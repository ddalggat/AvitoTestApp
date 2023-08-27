//
//  ProductCellViewModel.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/27/23.
//

import UIKit

final class ProductCellViewModel {
    public let imageUrl: String?
    public let productName: String
    public let price: String
    public let location: String
    public let created_date: String
    
    init(imageUrl: String?, productName: String, price: String, location: String, created_date: String) {
        self.imageUrl = imageUrl
        self.productName = productName
        self.price = price
        self.location = location
        self.created_date = created_date
    }
}
