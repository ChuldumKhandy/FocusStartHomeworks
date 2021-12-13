//
//  NetworkService.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import Foundation

protocol INetworkService {
    func loadImage(from urlImage: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService {
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

extension NetworkService: INetworkService {
    func loadImage(from urlImage: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: urlImage)
        self.session.downloadTask(with: request) { url, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let url = url {
                if let result = try? Data(contentsOf: url) {
                    completion(.success(result))
                }
            }
        }.resume()
    }
}

