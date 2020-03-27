//
//  SetUserInfoVC.swift
//  SignUp
//
//  Created by 이주혁 on 2020/02/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SetUserInfoVC: UIViewController {
    
    // MARK:- IBOutlet
    // MARK: TextField
    @IBOutlet var phoneNumberTextField: UITextField!
    
    // MARK: Label
    @IBOutlet var birthdayLabel: UILabel!
    
    // MARK: Button
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: DatePicker
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    // MARK:- Property
    var selectedBirthday: String?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLayout()
        initDelegate()
        initGesture()
    }
    
    // MARK:- Custom Method
    func setLayout() {
        initBirthdayLabel()
    }
    
    func initBirthdayLabel(){
        let today: Date = Date()
        self.birthdayLabel.text = setDateFormat(date: today)
    }
    
    func initGesture(){
        registViewTappedGesture()
    }
    func initDelegate(){
        phoneNumberTextField.delegate = self
    }
    func registViewTappedGesture(){
        let tappedGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                           action: #selector(keyboardWillHide))
        
        self.view.addGestureRecognizer(tappedGesture)
    }
    
    
    func setDateFormat(date: Date) -> String{
        let dateFormat: DateFormatter = {
            let format: DateFormatter = DateFormatter()
            format.dateStyle = .medium
            return format
        }()
        
        let dateString: String = dateFormat.string(from: date)
        
        return dateString
    }
    
    func isWriteAllInfomationCorrectly() -> Bool {
        guard let phoneNumber = self.phoneNumberTextField.text else {
            return false
        }
        if isSpaceText(texts: [phoneNumber]){
            return false
        }
        
        guard let birthday = self.selectedBirthday else {
            return false
        }
        
        UserInfo.shared.setUserInfo(phoneNumber: phoneNumber,
                                    birthday: birthday)
        return true
    }
    
    func signUpButtonActive(){
        if isWriteAllInfomationCorrectly(){
            self.signUpButton.isEnabled = true
        }
        else {
            self.signUpButton.isEnabled = false
        }
    }
    
    // MARK:- objc
    @objc func keyboardWillHide(){
        self.view.endEditing(true)
    }
    
    
    // MARK:- IBAction
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func touchUpPrevButton(_ sender: Any) {
        
        self.navigationController?
            .popViewController(animated: true)
    }
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate: Date = sender.date
        self.selectedBirthday = setDateFormat(date: selectedDate)
        
        self.birthdayLabel.text = selectedBirthday
        signUpButtonActive()
        
    }
}

// MARK:- Extension
// MARK: TextField Delegate Extension
extension SetUserInfoVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        signUpButtonActive()
    }
}



