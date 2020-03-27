//
//  UIViewController+Extensions.swift
//  SignUp
//
//  Created by 이주혁 on 2020/02/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func isSpaceText(texts: [String]) -> Bool {
        for text in texts {
            if text == "" {
                return true
            }
        }
        return false
    }
    
    func changeButtonIsEnable(button: UIButton){
        button.isEnabled = !button.isEnabled
    }
}
