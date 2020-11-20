//
//  NetworkClient.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import Foundation

protocol Networkable {
    func fetchCommits(completion: @escaping (Result<[String], Error>) -> Void)
}

class NetworkClient: Networkable {
    
    func fetchCommits(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "URLHere") else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle Resposne here
        }
        task.resume()
    }
}
