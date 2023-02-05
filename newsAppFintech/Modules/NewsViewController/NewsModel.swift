//
//  NewsModel.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 04.02.2023.
//

import Foundation

class NewsModel: NSObject {
    
    struct News: Codable {
        var status: String
        var totalResults: Int
        var articles: [Article]
    }
    
    struct Article: Codable {
        var source: ArticleSource
        
        struct ArticleSource: Codable {
            var id: String?
            var name: String?
        }
        
        var author: String?
        var title: String?
        var description: String?
        var url: String
        var urlToImage: String?
        var publishedAt: String?
    }

    struct ErrorObject: Codable {
        var status: String
        var code: String
        var message: String
    }

    enum ApiError: Error {
        case serviceError(ErrorObject)
        case httpError
    }
}
