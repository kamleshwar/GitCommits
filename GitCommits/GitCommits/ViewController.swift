//
//  ViewController.swift
//  GitCommits
//
//  Created by Kamleshwar on 11/19/20.
//  Copyright © 2020 Kamleshwar. All rights reserved.
//

import UIKit

/*      Requirements
 1. Create a free GitHub account - Done
 2. Create a new GitHub repository - Done
 3. Create a mobile app using Swift that accomplishes the following
    a) Connects to the GitHub API;
    b) Uses that API to retrieve the most recent commits
    c) Displays those commits in a list with the author, commit hash, and commit message.
 
 Git Repo = ReactiveX/RxSwift/
 */

class ViewController: UIViewController {
    let viewModel = GitCommitsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchCommits(completion: { _ in })
    }
}
