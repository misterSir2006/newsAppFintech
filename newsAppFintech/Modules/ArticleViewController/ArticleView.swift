//
//  ArticleView.swift
//  newsAppTinkoff
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit

class ArticleView: UIView {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var contentView = UIView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.sizeToFit()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var authorAndSourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    lazy var fullTextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Full text", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        
        return button
    }()
    
    //MARK: Fill
    private func fill() {
        backgroundColor = .white
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        let constraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        constraint.priority = UILayoutPriority(rawValue: 250)
        constraint.isActive = true
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        contentView.addSubview(authorAndSourceLabel)
        NSLayoutConstraint.activate([
            authorAndSourceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            authorAndSourceLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor)
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorAndSourceLabel.bottomAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: authorAndSourceLabel.leadingAnchor)
        ])
        
        contentView.addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            articleImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        contentView.addSubview(fullTextButton)
        NSLayoutConstraint.activate([
            fullTextButton.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 30),
            fullTextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fullTextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            fullTextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
