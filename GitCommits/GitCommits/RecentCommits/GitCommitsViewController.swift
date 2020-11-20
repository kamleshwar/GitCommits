//
//  GitCommitsViewController.swift
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
    a) Connects to the GitHub API; - Done
    b) Uses that API to retrieve the most recent commits - Done
    c) Displays those commits in a list with the author, commit hash, and commit message. - Done
 
 Git Repo = ReactiveX/RxSwift/
 */

class GitCommitsViewController: UIViewController {
    private let viewModel = GitCommitsViewModel()
    private var commitModels = [Commits]()
    private var spinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet public var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubViews()
        fetchCommits()
    }
    
    private func setupSubViews() {
        //TableView
        self.tableView.dataSource = self
        self.tableView.rowHeight = 70
        
        // Spinner
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.color = .darkGray
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func fetchCommits() {
        viewModel.fetchCommits() { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.spinner.stopAnimating()
                switch result {
                case .success(let commits):
                    self.commitModels = commits
                    self.tableView.reloadData()
                case .failure(_):
                    self.displayAlert()
                }
            }
        }
    }
    
    private func displayAlert() {
        let alert = UIAlertController(title: "Error!", message: "Some went wrong, please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension GitCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "commits")
        let recent = commitModels[indexPath.row]
        cell.textLabel?.text = recent.commit.author.name.uppercased()
        cell.detailTextLabel?.text = "\(recent.commit.message), SHA: \(recent.sha)"
        return cell
    }
}
