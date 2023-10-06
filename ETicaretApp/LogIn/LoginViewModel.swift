//
//  LoginViewModel.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation

protocol LogInViewModelInterface {
    func authenticate(_ username: String, _ password: String)
}

class LogInViewModel: LogInViewModelInterface {
    func controlTf(_ username: String?, _ password: String?) -> Bool{
        guard let username, let password else { return false}
        if username.isEmpty {
            view?.showErrorMessage("Username cannot be empty!")
            return false
        }
        if password.isEmpty {
            view?.showErrorMessage("Password cannot be empty!")
            return false
        }
        return true
    }
    
    weak var view: LogInViewControllerInterface?
    func authenticate(_ username: String, _ password: String) {
        let param = AuthenticateRequest.init(username: username, password: password).toDictionary
        view?.showSpinner()
        ApiClient.shared.authenticate(param: param ?? [:]) { [weak self] response, error  in
            self?.view?.hideSpinner()
            if let data = response {
                self?.view?.authenticateResult(data: data)
            } else {
                self?.view?.showErrorMessage(error?.localizedDescription ?? "An error occurred during your operation!")
            }
        }
    }
    
    
}
