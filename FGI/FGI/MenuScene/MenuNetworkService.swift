//
//  MenuNetworkService.swift
//  FGI
//
//  Created by user on 30.12.2021.
//

import Foundation

protocol IMenuNetworkService {
    func loadCurriencies(from url: URL, completion: @escaping (Result<[String], Error>) -> Void)
}

final class MenuNetworkService: NSObject {
    private let session: URLSession

    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
}

extension MenuNetworkService: IMenuNetworkService {
    func loadCurriencies(from url: URL, completion: @escaping (Result<[String], Error>) -> Void) {
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([String].self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
