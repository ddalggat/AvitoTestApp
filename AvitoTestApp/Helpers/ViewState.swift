//
//  ViewState.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 9/1/23.
//

import Foundation

enum ViewState<T> {
    case none
    case error(String)
    case loading
    case loaded(T)

    var message: String {
        switch self {
        case .none:
            return "неизвестная ошибка"
        case .error:
            return "не удалось загрузить"
        case .loading:
            return "загружается"
        case .loaded:
            return "загрузилось"
        }
    }
    
    var data: T? {
        switch self {
        case .loaded(let data):
            return data
        default:
            return nil
        }
    }
}
