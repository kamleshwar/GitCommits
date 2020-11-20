//
//  GitCommitsViewModel.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import Foundation

public class GitCommitsViewModel {
    private let service: Networkable
    
    init(service: Networkable = NetworkClient()) {
        self.service = service
    }
    
    public func fetchCommits(completion: @escaping (Result<[Commits], CustomError>) -> Void) {
        self.service.fetchCommits(completion: completion)
    }
}
