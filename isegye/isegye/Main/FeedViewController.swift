//
//  FeedViewController.swift
//  isegye
//
//  Created by 손겸 on 2/25/25.
//

import UIKit

struct Post {
    let nickname: String
    let time: String
    let content: String
    let likes: Int
    let comments: Int
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: FeedViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
    }
    
    private func loadData() {
        posts = [
            Post(nickname: "john_doe", time: "2h ago", content: "Just wrapped up an amazing coding session! 🟢", likes: 25, comments: 5),
            Post(nickname: "jane_smith", time: "4h ago", content: "Beautiful sunset at the beach today! 🟢", likes: 156, comments: 12),
            Post(nickname: "mike_wilson", time: "6h ago", content: "Just published my first blog post on modern web development!", likes: 30, comments: 7)
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedViewCell.reuseIdentifier, for: indexPath) as? FeedViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
