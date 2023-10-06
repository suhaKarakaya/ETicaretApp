//
//  ViewController.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 30.09.2023.
//

import UIKit
import SnapKit

protocol LogInViewControllerInterface: AnyObject, SpinnerProtocol, AlertProtocol, KeyboardProtocol {
    func authenticateResult(data: AuthenticateResponse)
    func showErrorMessage(_ msg: String)
}


final class LogInViewController: UIViewController {
    
    private let viewLogin = LogoView()
    private let tfUsername: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.layout(.normal)
        return view
    }()
    private let tfPassword: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.layout(.password)
        return view
    }()
    private let buttonLogin: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .purple
        
        return view
    }()
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[
            viewLogin,
            tfUsername,
            tfPassword
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var viewModel = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        generateUI()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func buttonLoginClicked() {
        guard viewModel.controlTf(tfUsername.getText(), tfPassword.getText()) else {return}
        viewModel.authenticate(tfUsername.getText(), tfPassword.getText())
    }
}

extension LogInViewController: LogInViewControllerInterface {
    func showErrorMessage(_ msg: String) {
        showDefaultAlert(title: "Warning", msg: msg, buttonTitle: "Ok")
    }
    
    func authenticateResult(data: AuthenticateResponse) {
//        servisten gelen token değeri bağlantısız diğer apide sonuç alamadığından akış için içeriden custom uid değeri set edilmiştir.
        Constants.token = UUID().uuidString
        let nextViewController = ProductListViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
}

extension LogInViewController {
    
    func generateUI(){
        view.backgroundColor = .white
        view.addSubview(vStackView)
        view.addSubview(buttonLogin)
        vStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)

        }
        buttonLogin.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        buttonLogin.addTarget(self, action: #selector(buttonLoginClicked), for: .touchUpInside)
    }
}




