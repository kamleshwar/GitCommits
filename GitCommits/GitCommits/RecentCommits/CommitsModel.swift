//
//  CommitsModel.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import Foundation

public struct Commits: Decodable {
    let message: String
    let author: String
    let sha: String
}
