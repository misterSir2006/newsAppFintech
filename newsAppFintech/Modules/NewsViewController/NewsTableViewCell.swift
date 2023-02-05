//
//  NewsTableViewCell.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(indexPath: IndexPath, news: [ArticleEntity]) {
        
        titleLabel.text = news[indexPath.item].title ?? "Unknown title"
        articleImageView.setImageFromURL(url: news[indexPath.item].urlToImage ?? "")
        viewCountLabel.text = "views: \(news[indexPath.item].views)"
    }
    
    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .darkGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Article title"
        label.textColor = .black
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        
        return label
    }()
    
    lazy var viewCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    //MARK: Fill
    private func fill() {
        backgroundColor = .clear
        
        addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            articleImageView.widthAnchor.constraint(equalToConstant: 60),
            articleImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        addSubview(viewCountLabel)
        NSLayoutConstraint.activate([
            viewCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            viewCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: viewCountLabel.leadingAnchor, constant: -10)
        ])
    }
}

