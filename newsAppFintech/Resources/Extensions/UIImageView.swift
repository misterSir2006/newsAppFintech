//
//  UIImageView.swift
//  newsAppFintech
//
//  Created by Илья Шахназаров on 05.02.2023.
//

import UIKit

extension UIImageView {
    func setImageFromURL(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
