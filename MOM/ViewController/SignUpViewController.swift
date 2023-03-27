//
//  SignUpViewController.swift
//  MOM
//
//  Created by SowmiyaRagul on 26/03/23.
//

import UIKit
import Firebase

class SignUpViewController : BaseViewController {
    //MARK: Outlet
    @IBOutlet weak var confirmPassWordTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var newPassWordTextField: UITextField?
    @IBOutlet weak var continueButton: UIButton?
    
    //MARK: Local variable
    var viewModel = MOMViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set CornerRadius
        continueButton?.layer.cornerRadius = 5.0
    }
    
    @IBAction func signUptapped(_ sender: UIButton) {
        if isValidated() {
            viewModel.signUp(userName: emailTextField?.text ?? "", password: confirmPassWordTextField?.text ?? "") { [weak self] isSuccess, error in
                if isSuccess == true {
                    self?.navigateToLogin()
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
}

//MARK: Navigation
extension SignUpViewController {
    private func navigateToLogin() {
        let detailViewController = LoginViewController(nibName: Identifier.loginVc, bundle: nil)
            self.present(detailViewController, animated: true)
    }
}

//MARK: Validation
extension SignUpViewController {
    private func isValidated() -> Bool {
        switch true {
        case emailTextField?.isValidEmail(emailTextField?.text ?? "") == false:
            showAlert(message: Constants.validEmailID)
            return false
        case newPassWordTextField?.isValidPassword(newPassWordTextField?.text ?? "") == false || confirmPassWordTextField?.isValidPassword(confirmPassWordTextField?.text ?? "") == false:
            showAlert(message: Constants.validPassword)
            return false
        case newPassWordTextField?.text != confirmPassWordTextField?.text:
            showAlert(message: Constants.oldNewMismatched)
            return false
        default:
            return true
        }
    }
}

