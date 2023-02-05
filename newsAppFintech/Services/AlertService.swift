//
//  AlertService.swift
//  newsAppTinkoff
//
//  Created by Илья Шахназаров on 03.02.2023.
//

import UIKit

class AlertService: NSObject {
    
    // MARK: UIAlertController
    static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let topVC = UIApplication.getTopMostViewController() {
            alert.popoverPresentationController?.sourceView = topVC.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: topVC.view.bounds.midX, y: topVC.view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
            topVC.present(alert, animated: true, completion: completion)
        }
    }
    
    static func noConnectionAlert() {
        self.showAlert(style: .alert,
                               title: "Что-то пошло не так.",
                               message: "Проверьте соединение с интернетом или попробуйте позже.")
    }
}

extension UIApplication {

    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
