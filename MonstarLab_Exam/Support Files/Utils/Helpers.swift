//
//  Helpers.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Error {
    func toResponse() -> ErrorResponse {
        let error  = self as NSError
        
        return ErrorResponse(code: error.code, message: error.userInfo["message"] as? String ?? localizedDescription, userInfo: error.userInfo)
    }
}

extension UIView {
    func getKeyWindow() -> UIWindow {
            if #available(iOS 13.0, *) {
    //            let sceneDelegate = window?.windowScene?.delegate
                return UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive })
                    .map({ $0 as? UIWindowScene })
                    .compactMap({ $0 }).first?.windows.filter({ $0.isKeyWindow }).first ?? UIWindow()
            }
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return appDelegate?.window ?? UIWindow()
        }
    
    func basicAnimate(_ duration: TimeInterval? = nil, method: @escaping () -> Void, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? 0.3, animations: {
            method()
            self.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
    
    func basicAnimateWithSpring(_ duration: TimeInterval = 0.4, delay: Double = 0.0, springDamping: CGFloat = 0.6, initialSpringVelocity: CGFloat = 0.5, method: @escaping (() -> Void), completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            method()
        }, completion: { _ in
            completion?()
        })
    }
    
    func scaleUpAnimate() {
        transform = .identity
        basicAnimate(0.1, method: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.layoutIfNeeded()
        })
    }
    
    func scaleDownAnimate() {
        basicAnimateWithSpring(0.1, method: {
            self.transform = .init(scaleX: 0.9, y: 0.9)
        })
    }
    
    func resetUi() {
        basicAnimateWithSpring(0.1, method: {
            self.transform = .identity
        })
    }
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String, completion: (() -> Void)? = nil) {
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
        }
        
        alertVc.addAction(okAction)
        
        
        present(alertVc, animated: true, completion: completion)
    }
    
    func showConfirmAlert(_ title: String? = nil, message: String, style: UIAlertAction.Style = .default, completion: @escaping (Bool) -> Void) {
        
        let alertVc = UIAlertController(title: title ?? message, message: title != nil ? message : "", preferredStyle: .alert)
        
        let alertAction: UIAlertAction
        
        switch style {
        case .default:
            alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
                completion(true)
            }
        case .destructive:
            alertAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                completion(true)
            }
        default:
            alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
                completion(true)
            }
        }
        
        
        let  cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        
        alertVc.addAction(alertAction)
        alertVc.addAction(cancelAction)
        
        present(alertVc, animated: true, completion: nil)
    }
}
