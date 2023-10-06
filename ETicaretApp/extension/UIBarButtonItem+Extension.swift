//
//  UIBarButtonItem+Extension.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 5.10.2023.
//

import UIKit

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: UIImage) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        
        button.setImage(imageName, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true

        return menuBarItem
    }
}
