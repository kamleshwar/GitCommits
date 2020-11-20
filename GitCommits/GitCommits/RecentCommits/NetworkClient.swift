//
//  NetworkClient.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import Foundation

public protocol Networkable {
    func fetchCommits(completion: @escaping (Result<[Commits], Error>) -> Void)
}

public class NetworkClient: Networkable {
    let baseURL = "https://api.github.com/repos/"
    
    public func fetchCommits(completion: @escaping (Result<[Commits], Error>) -> Void) {
        let path = "ReactiveX/RxSwift/commits"
        
        guard let url = URL(string: "\(baseURL)\(path)") else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let commits = try! JSONDecoder().decode([Commits].self, from: data)
                completion(.success(commits))
            }
        }
        task.resume()
    }
}
