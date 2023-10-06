//
//  UIViewControllerExtension.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import UIKit

protocol SpinnerProtocol {
    func showSpinner()
    func hideSpinner()
}

protocol KeyboardProtocol {
    func hideKeyboardWhenTappedAround()
}

var vSpinner : UIView?

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SpinnerProtocol where Self: UIViewController{
    
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}

extension KeyboardProtocol where Self: UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

