//
//  SingInViewController.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class SignInOrSignUpViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInOrSignUpButton: UIButton!
    
    var signInOrSignUpViewModel = SignInOrSignUPViewModel()
    
    enum ViewType {
        case signIn
        case signUp
    }
    
    var type:ViewType = .signIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInOrSignUpViewModel.delegate = self
        uiSetup()
        // Do any additional setup after loading the view.
    }
    
    class func get(with type: ViewType) -> UIViewController? {
        let vc = SignInOrSignUpViewController.get(with: AppConstants.ViewControllerStotyboardId.signInOrSignUpViewController, storyboard: AppConstants.Storyboard.main) as? SignInOrSignUpViewController
        vc?.type = type
        return vc
    }
    
    
    func uiSetup() {
        signInOrSignUpButton.applyGradient(colours: UIColor.gradientColors, locations: nil)
        signInOrSignUpButton.cornerRadius(with: 8)
        switch type {
        case .signIn:
            signInOrSignUpButton.setTitle("Sign In", for: .normal)
        case .signUp:
            signInOrSignUpButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func signInOrSignUpButtonTapped(_ sender: Any) {
        
        do {
            try signInOrSignUpViewModel.validate(userName: userNameTextField.text, and: passwordTextField.text) {  (status, model) in
                switch type {
                case .signIn:
                    signInOrSignUpViewModel.setUserInfo(with: model)
                    signInOrSignUpViewModel.signIn()
                case .signUp:
                    signInOrSignUpViewModel.setUserInfo(with: model)
                    signInOrSignUpViewModel.signUp()
                }
            }
        } catch let error {
            if error is SignInOrSignUPViewModel.SignInOrSignUpError {
                let someError =  error as! SignInOrSignUPViewModel.SignInOrSignUpError
                alert(title: someError.localizedDescription)
            }
        }
    }
}


extension SignInOrSignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension SignInOrSignUpViewController : SignInOrSignUPViewModelDelegate {
    func userSignInOrSignUp(with status: SignInOrSignUPViewModel.SignInOrSignUPStatus, message: String) {
        switch status {
        case .success:
            goToHome()
        case .fail:
            alert(title: message)
        }
    }
    
    private func goToHome() {
        userNameTextField.text = nil
        passwordTextField.text = nil
       let homeVC = HomeViewController.get(with: AppConstants.ViewControllerStotyboardId.homeViewController, storyboard: AppConstants.Storyboard.main)
        navigationController?.pushViewController(homeVC!, animated: true)
    }
    
}

