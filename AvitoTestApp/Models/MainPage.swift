//
//  MainPage.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/24/23.
//

import Foundation

import Foundation

struct AdvertisementResponse: Codable {
    let advertisements: [Advertisement]
}

struct Advertisement: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
