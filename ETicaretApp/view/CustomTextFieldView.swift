//
//  PasswordView.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import UIKit
import SnapKit

enum TextFieldType {
    case normal
    case password
}

class CustomTextFieldView: UIView {
    
    var type: TextFieldType = .normal
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.font = tf.font?.withSize(16)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private let buttonPasswordVisiblity: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(.openPassword, for: .normal)
        view.setBackgroundImage(.closedPassword, for: .selected)
        view.imageView?.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            hStackView
        ])
        view.addShadow()
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            textField,
            buttonPasswordVisiblity
            
        ])
        view.axis = .horizontal
        view.distribution = .fill
        return view
    }()
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layout(_ type: TextFieldType){
        self.type = type
        buttonPasswordVisiblity.isHidden = type == .normal
        textField.isSecureTextEntry = type == .password
        titleLabel.text = type == .normal ? "Username" : "Password"
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.bottom.equalToSuperview().inset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
        hStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
        }
        textField.snp.makeConstraints { make in
            make.left.equalTo(vStackView).inset(10)
            make.height.equalTo(30)
        }
        buttonPasswordVisiblity.snp.makeConstraints { make in
            make.width.equalTo(buttonPasswordVisiblity.snp.height)
            make.right.equalTo(vStackView).inset(10)
        }
        buttonPasswordVisiblity.addTarget(self, action: #selector(iconAction), for: .touchUpInside)
        
    }
    
    @IBAction func iconAction(sender: AnyObject) {
        buttonPasswordVisiblity.isSelected.toggle()
        textField.isSecureTextEntry = !buttonPasswordVisiblity.isSelected
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    func setText(text: String){
        textField.text = text
    }
    
}
