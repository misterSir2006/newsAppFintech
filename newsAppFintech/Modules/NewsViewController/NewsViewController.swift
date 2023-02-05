//
//  NewsViewController.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit

fileprivate var reuseIdentifier = Constants.Content.ReuseIDs.newsTableCellReuseIdentifier

class NewsViewController: UITableViewController {

    private let presenter = NewsPresenter()
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
        
        presenter.getData(tableView: self.tableView, page: page)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    @objc func callPullToRefresh() {
        page += 1
        presenter.getData(tableView: self.tableView, page: page)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.entities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.prepareForReuse()
        cell.configure(indexPath: indexPath, news: presenter.entities)
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = presenter.entities.count - 1
        if indexPath.row == lastElement {
            page += 1
            presenter.getData(tableView: tableView, page: page)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.entities[indexPath.item]
        let vc = ArticleViewController(article: article)
        tableView.reloadData()
        
        article.views += 1
        DataManager.shared.save()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

