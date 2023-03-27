//
//  LoginViewController.swift
//  MOM
//
//  Created by SowmiyaRagul on 25/03/23.
//

import UIKit
import Firebase
class LoginViewController : BaseViewController {
    @IBOutlet weak var passWordTextField: UITextField?
    @IBOutlet weak var userNameTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    
    //MARK: Local Variable
    var viewModel = MOMViewModel()
    
    @IBAction func loginTapped(sender: UIButton) {
        if isValid() {
            viewModel.signIn(userName: userNameTextField?.text ?? "", password: passWordTextField?.text ?? "") { [weak self] isSuccess, error in
                if isSuccess ?? false {
                    self?.navigateToMOMList()
                } else {
                    let errorMessage = error as? NSError
                    switch errorMessage?.code {
                    case AuthErrorCode.operationNotAllowed.rawValue:
                        self?.showAlert(message: "\(AuthErrorCode.invalidEmail.rawValue)")
                        break
                    case AuthErrorCode.invalidEmail.rawValue:
                        self?.showAlert(message: "\(AuthErrorCode.invalidEmail.rawValue)")
                        break
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        self?.showAlert(message: "\(AuthErrorCode.emailAlreadyInUse.rawValue)")
                        break
                    case AuthErrorCode.weakPassword.rawValue:
                        self?.showAlert(message: "\(AuthErrorCode.weakPassword.rawValue)")
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func signUptapped(_ sender: UIButton) {
        clearData()
        navigateToSignUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set CornerRadius
        loginButton?.layer.cornerRadius = 5.0
    }
}

//MARK: Navigation
extension LoginViewController {
    private func navigateToMOMList() {
        let detailViewController = MOMListViewController(nibName: Identifier.MOMListVc, bundle: nil)
        present(detailViewController, animated: true) 
    }
    
    private func navigateToSignUp() {
        let detailViewController = SignUpViewController(nibName: Identifier.signUpVc, bundle: nil)
        present(detailViewController, animated: true)
    }
}

//MARK: Validation
extension LoginViewController {
    private func isValid() -> Bool {
        switch true {
        case userNameTextField?.text?.isEmpty ?? false:
            showAlert(message: Constants.emailId)
            return false
        case passWordTextField?.text?.isEmpty ?? false:
            showAlert(message: Constants.password)
            return false
        case userNameTextField?.isValidEmail(userNameTextField?.text ?? "") == false:
            showAlert(message: Constants.validEmailID)
            return false
        case passWordTextField?.isValidPassword(passWordTextField?.text ?? "") == false:
            showAlert(message: Constants.validPassword)
            return false
        default:
            return true
        }
    }
}

//MARK: Refresh Data
extension LoginViewController {
    private func clearData() {
        userNameTextField?.text = ""
        passWordTextField?.text = ""
    }
}
