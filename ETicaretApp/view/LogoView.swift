//
//  LogoView.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import UIKit

class LogoView: UIView {
    private let imageView: UIImageView = {
        let view = UIImageView(image: .login)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = label.font.withSize(30)
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            imageView,
            topLabel
        ])
        view.addShadow()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        addSubview(vStackView)
        backgroundColor = .white
        vStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        topLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(vStackView).offset(10)
            make.right.equalTo(vStackView)
        }
    }
    
}
