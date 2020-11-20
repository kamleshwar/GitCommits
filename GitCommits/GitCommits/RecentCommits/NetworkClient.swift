//
//  NetworkClient.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import Foundation

public protocol Networkable {
    func fetchCommits(completion: @escaping (Result<[Commits], CustomError>) -> Void)
}

public enum CustomError: Error {
    case invalidData
    case error
}

public class NetworkClient: Networkable {
    let baseURL = "https://api.github.com/repos/"
    
    public func fetchCommits(completion: @escaping (Result<[Commits], CustomError>) -> Void) {
        let path = "ReactiveX/RxSwift/commits"
        
        guard let url = URL(string: "\(baseURL)\(path)") else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.error))
            }
            
            if let data = data {
                if let commits = try? JSONDecoder().decode([Commits].self, from: data) {
                    completion(.success(commits))
                } else {
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
}
