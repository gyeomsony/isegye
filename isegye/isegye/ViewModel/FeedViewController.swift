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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
    }
    
    private func loadData() {
        posts = [
            Post(nickname: "aaaadddd", time: "2h ago", content: "오늘 심심하네 다들 뭐하니", likes: 25, comments: 5),
            Post(nickname: "adad_aa", time: "4h ago", content: "공부하고 싶은거 각자 적어보고 가자", likes: 156, comments: 12),
            Post(nickname: "aden", time: "6h ago", content: " 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트 긴글 테스트", likes: 30, comments: 7)
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        
        let viewModel = FeedViewModel()
        cell.viewModel = viewModel
        
        return cell
    }
}
