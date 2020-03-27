//
//  SignUpVC.swift
//  SignUp
//
//  Created by 이주혁 on 2020/02/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var checkPWTextField: UITextField!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var introductionTextView: UITextView!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    // MARK:- Self Property
    lazy var imagePicker: UIImagePickerController = {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        return picker
    }()
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registGesture()
        registDelegate()
        registNotificationCenter()
    }
    
    // MARK:- Custom Method
    func registDelegate(){
        idTextField.delegate = self
        pwTextField.delegate = self
        checkPWTextField.delegate = self
        
        introductionTextView.delegate = self
    }
    func registGesture(){
        registViewTapGestureRecognizer()
        registImageViewTapGestureRecognizer()
    }
    func registNotificationCenter(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(activeNextButton),
                                               name: Notification.Name(rawValue: "endEditing"),
                                               object: nil)
    }
    
    func registViewTapGestureRecognizer(){
        self.profileImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                  action: #selector(keyboardWillHide))
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func registImageViewTapGestureRecognizer(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                        action: #selector(presentPhotoLibarary))
        self.profileImageView.addGestureRecognizer(tapGesture)
        
    }
    
   
    
    func isWriteAllInfomationCorrectly() -> Bool {
        guard let id = self.idTextField.text else {
            return false
        }
        guard let pw = self.pwTextField.text else {
            return false
        }
        guard let pwCheck = self.checkPWTextField.text else {
            return false
        }
        guard let introduction = self.introductionTextView.text else {
            return false
        }
        guard let image = self.profileImageView.image else {
            return false
        }
        
        if isSpaceText(texts: [id, pw, pwCheck, introduction]){
            return false
        }
        
        if pw != pwCheck {
            return false
        }
        
        UserInfo.shared.setUserInfo(id: id,
                                    pw: pw,
                                    profileImage: image,
                                    userIntroduction: introduction)
        
        return true
    }
    
    @objc func activeNextButton(){
        
        if isWriteAllInfomationCorrectly(){
            self.nextButton.isEnabled = true
        }
        else {
            self.nextButton.isEnabled = false
        }
    }
    
    @objc func presentPhotoLibarary(){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
       

       
   @objc func keyboardWillHide(){
       self.view.endEditing(true)
   }

    // MARK:- IBAction
    @IBAction func touchUpCancelButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton){
        
        if let dvc = self.storyboard?.instantiateViewController(identifier: "SetUserInfoVC") as? SetUserInfoVC {
            self.navigationController?.pushViewController(dvc,
                                                          animated: true)
        }
    }
}

// MARK:- Extension
// MARK: UITextFieldDelegate Extension
extension SignUpVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "endEditing"), object: nil)
    }
    
}
// MARK: UIImagePickerDelegate Extension
extension SignUpVC: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.profileImageView.image = image
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "endEditing"),
                                        object: nil)
        self.dismiss(animated: true,
                     completion: nil)
    }
}

// MARK: UITextViewDelegate Extension
extension SignUpVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "endEditing"),
                                        object: nil)
    }
}


// MARK: UINavigationControllerDelegate Extension
extension SignUpVC: UINavigationControllerDelegate {
    
}
