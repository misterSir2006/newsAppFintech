//
//  ApiService.swift
//  newsAppTinkoff
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit

class ApiService: NSObject {
    
    static func post<T: Codable>(for: T.Type = T.self,
                                 url: String,
                                 completionHandler: @escaping (Result<T, NewsModel.ApiError>) -> Void) {
        
        let requestUrl = URL(string: url)!
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                completionHandler(.failure(.httpError))
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(T.self, from: data!) {
                DispatchQueue.main.async {
                    print(decodedData)
                    completionHandler(.success(decodedData))
                }
            } else {
                let error = try? JSONDecoder().decode(NewsModel.ErrorObject.self, from: data!)
                guard let error = error else { return }
                completionHandler(.failure(.serviceError(error)))
            }
        }.resume()
    }
    
}
