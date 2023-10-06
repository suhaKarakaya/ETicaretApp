//
//  AlertUtils.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import UIKit

protocol AlertProtocol {
    func showDefaultAlert(title: String, msg: String, buttonTitle: String)
    func showDefaultCompletionAlert(title: String, msg: String, buttonTitle: String, completion: @escaping () -> Void)
    func showCompletionAlert(title: String, msg: String, buttonTitle1: String, buttonTitle2: String, completion: @escaping (Bool) -> Void)
}

extension AlertProtocol where Self: UIViewController {
    func showDefaultAlert(title: String, msg: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showDefaultCompletionAlert(title: String, msg: String, buttonTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message:msg , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { action in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showCompletionAlert(title: String, msg: String, buttonTitle1: String, buttonTitle2: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message:msg , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle1, style: UIAlertAction.Style.default, handler: { action in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: buttonTitle2, style: UIAlertAction.Style.default, handler: { action in
            completion(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

