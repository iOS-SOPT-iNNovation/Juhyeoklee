//
//  LoginVC.swift
//  SignUp
//
//  Created by 이주혁 on 2020/02/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registDelegate()
        registTapGestureRecognizer()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Custom Method
    func registDelegate(){
        self.idTextField.delegate = self
        self.pwTextField.delegate = self
    }
    
    func registTapGestureRecognizer(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func keyboardWillHide(){
        self.view.endEditing(true)
    }
    
    
    // MARK:- IBAction
    @IBAction func touchSignUpButton(_ sender: UIButton){
        let storyboard = UIStoryboard.init(name: "SignUp",
                                           bundle: nil)
        
        if let dvc: UINavigationController = storyboard.instantiateViewController(identifier: "NavigationController") as? UINavigationController{
            
            self.present(dvc,
                         animated: true,
                         completion: nil)
            
        }
    }
}

// MARK:- UITextFieldDelegate Extension
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idTextField:
            textField.resignFirstResponder()
            return true
        case pwTextField:
            textField.resignFirstResponder()
            return true
        default:
            return true
        }
        
    }
}
