//
//  NetworkService.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import Foundation

protocol INetworkService {
    func loadFGIes(from url: URL, completion: @escaping (Result<[FGIDto], Error>) -> Void)
}

final class DiagramNetworkService: NSObject {
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

extension DiagramNetworkService: INetworkService {    
    func loadFGIes(from url: URL, completion: @escaping (Result<[FGIDto], Error>) -> Void) {
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([FGIDto].self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
