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
    private let viewModel = GitCommitsViewModel()
    private var commitModels = [Commits]()
    
    @IBOutlet public var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubViews()
        fetchCommits()
    }
    
    private func setupSubViews() {
        self.tableView.dataSource = self
        self.tableView.rowHeight = 70
    }
    
    private func fetchCommits() {
        viewModel.fetchCommits() { result in
            switch result {
            case .success(let commits):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.commitModels = commits
                    self.tableView.reloadData()
                }
            case .failure(_): break
                // Handle Error
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "commits")
        let commit = commitModels[indexPath.row]
        cell.textLabel?.text = commit.commit.author.name
        return cell
    }
}
