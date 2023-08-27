//
//  APICaller.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/27/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    func getProductsList(completion: @escaping (Result<[MainInfo], Error>) -> Void) {
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json") else {
            completion(.failure(URLError(.badURL)))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                    error == nil else {return}
            do {
                let result = try JSONDecoder().decode(MainPage.self, from: data)
                completion(.success(result.catalog))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDetailInfo(with id: String, completion: @escaping (Result<DetailPage, Error>) -> Void) {
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json") else {completion(.failure(URLError(.badURL)))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                    error == nil else {return}
            do {
                let result = try JSONDecoder().decode(DetailPage.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
