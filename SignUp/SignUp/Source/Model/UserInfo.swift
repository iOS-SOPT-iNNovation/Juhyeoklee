//
//  UserInfo.swift
//  SignUp
//
//  Created by 이주혁 on 2020/02/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import UIKit

class UserInfo{
    var id: String?
    var pw: String?
    var profileImage: UIImage?
    var userIntroduction: String?
    
    var phoneNumber: String?
    var birthday: String?

    static let shared: UserInfo = UserInfo()
    
    func setUserInfo(id: String?, pw: String?, profileImage: UIImage?, userIntroduction: String?){
        self.id = id
        self.pw = pw
        self.profileImage = profileImage
        self.userIntroduction = userIntroduction

    }
    
    func setUserInfo(phoneNumber: String?, birthday: String?){
        self.phoneNumber = phoneNumber
        self.birthday = birthday
    }
}
