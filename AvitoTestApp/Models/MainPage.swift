//
//  MainPage.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/24/23.
//

import Foundation

struct MainPage: Codable {
    let catalog: [MainInfo]
}

struct MainInfo: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
}
