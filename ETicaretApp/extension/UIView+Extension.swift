//
//  UIView+Extension.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import UIKit

extension UIView {
    func addShadow(){
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        clipsToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent (0.15).cgColor
        layer.shadowOffset = CGSize (width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
    }
    
    func setViewBorder(color: CGColor, borderWith: Int, borderRadius: Int){
        layer.borderColor = color
        layer.borderWidth = CGFloat(borderWith)
        layer.cornerRadius = CGFloat(borderRadius)
    }
    
    func setCircleView(color: UIColor, borderWith: Int, borderRadius: Int){
        layer.cornerRadius = CGFloat(borderRadius/2)
        clipsToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(borderWith)
    }
    

}
