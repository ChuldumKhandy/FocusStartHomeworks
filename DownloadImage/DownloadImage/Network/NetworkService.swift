//
//  NetworkService.swift
//  DownloadImage
//
//  Created by user on 13.12.2021.
//

import Foundation
import UIKit

protocol INetworkService {
    func loadImage(from urlImage: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NSObject {
    private let session: URLSession
    private let config = URLSessionConfiguration.background(withIdentifier: "background")
    private let backgroundSession: URLSession

    init(configuration: URLSessionConfiguration? = nil, backgroundConfiguration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
        self.config.isDiscretionary = true
        self.config.sessionSendsLaunchEvents = true
        if let backgroundConfiguration = backgroundConfiguration {
            self.backgroundSession = URLSession(configuration: backgroundConfiguration)
        }
        else {
            self.backgroundSession = URLSession(configuration: URLSessionConfiguration.default)
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
        
        self.backgroundSession.downloadTask(with: urlImage) { url, response, error in
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

extension NetworkService: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let backgroundCompletionHandler = appDelegate.backgroundCompletionHandler
            else {
                return
            }
            backgroundCompletionHandler()
        }
    }
}
