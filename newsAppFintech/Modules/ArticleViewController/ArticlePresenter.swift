//
//  ArticlePresenter.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 04.02.2023.
//

import UIKit

class ArticlePresenter: NSObject {
    
    func setData(vcView: ArticleView, article: ArticleEntity) {
        vcView.authorAndSourceLabel.text = "\(article.author ?? "Author unknown") for \(article.source ?? "Source unknown")"
        vcView.titleLabel.text = article.title ?? "???"
        vcView.descriptionLabel.text = article.articleDescription
        vcView.dateLabel.text = "Published on: \(self.formatDate(string: article.publishedAt ?? ""))"
        vcView.articleImageView.setImageFromURL(url: article.urlToImage ?? "")
    }
    
    func formatDate(string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"

        if let date = dateFormatterGet.date(from: string) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "error"
        }
    }
}
