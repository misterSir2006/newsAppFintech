//
//  ArticleViewController.swift
//  newsAppTinkoff
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    private let vcView = ArticleView()
    private let presenter = ArticlePresenter()
    
    let article: ArticleEntity
    
    init(article: ArticleEntity) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = vcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Article"
        presenter.setData(vcView: vcView, article: article)
        
        vcView.fullTextButton.addTarget(self, action: #selector(fullTextTapped), for: .touchUpInside)
    }
    
    @objc func fullTextTapped() {
        navigationController?.pushViewController(FullTextViewController(urlStr: article.url ?? ""), animated: true)
    }
}
