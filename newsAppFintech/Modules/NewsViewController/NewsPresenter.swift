//
//  NewsPresenter.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 04.02.2023.
//

import UIKit

class NewsPresenter: NSObject {
    
    var entities: [ArticleEntity] = DataManager.shared.articleEntities()
    var newsData: [NewsModel.Article] = []
    
    func getData(tableView: UITableView, page: Int) {
        let baseUrl = Constants.Content.API.baseUrl
        let apiKey = Constants.Content.API.apiKey
        let query = ["swift", "tinkoff", "ios", "apple"].randomElement()!
        let pageSize = 20
        
        ApiService.post(for: NewsModel.News.self,
                        url: "\(baseUrl)apiKey=\(apiKey)&q=\(query)&pageSize=\(pageSize)&page=\(page)") { result in
            switch result {
            case .success(let data):
                for i in data.articles {
                    let entity = DataManager.shared.articleEntity(views: 0,
                                                                  author: i.author ?? "Author unknown",
                                                                  title: i.title ?? "No title",
                                                                  publishedAt: i.publishedAt ?? "Date unknown",
                                                                  url: i.url,
                                                                  urlToImage: i.urlToImage ?? "No URL",
                                                                  source: i.source.name ?? "?",
                                                                  description: i.description ?? "No description")
                    print(entity)
                    self.entities.append(entity)
                    DataManager.shared.save()
                }

                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                print(data)
            case .failure(let errorData):
                switch errorData {
                case .httpError:
                    DispatchQueue.main.async {
                        AlertService.noConnectionAlert()
                    }
                case .serviceError(let error):
                    DispatchQueue.main.async {
                        AlertService.showAlert(style: .alert, title: error.status.capitalized, message: error.message)
                    }
                }
            }
        }
    }
    
}
