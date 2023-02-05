//
//  DataManager.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 05.02.2023.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static let shared = DataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "newsAppFintech")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    AlertService.showAlert(style: .alert, title: "Error", message: "Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
        return container
    }()

    func articleEntity(views: Int, author: String, title: String, publishedAt: String,
                       url: String, urlToImage: String, source: String, description: String) -> ArticleEntity {
        let article = ArticleEntity(context: persistentContainer.viewContext)
        
        article.author = author
        article.title = title
        article.views = Int16(views)
        article.url = url
        article.urlToImage = urlToImage
        article.source = source
        article.articleDescription = description
        article.publishedAt = publishedAt
        
        return article
    }
    
    func articleEntities() -> [ArticleEntity] {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        var fetchedEntites: [ArticleEntity] = []
        
        do {
            fetchedEntites = try persistentContainer.viewContext.fetch(request)
            save()
        } catch let error {
            print(error)
        }
        
        return fetchedEntites
    }
    
    func save() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                DispatchQueue.main.async {
                    AlertService.showAlert(style: .alert, title: "Cannot save changes", message: "Something went wrong, try again later")
                }
            }
        }
    }
}
