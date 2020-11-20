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
    public func fetchCommits(completion: @escaping (Result<[Commits], Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/repos/ReactiveX/RxSwift/commits") else { return }
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
