//
//  UserData.swift
//  pocketFactory
//
//  Created by NingFangming on 4/23/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation

open class User {
    var registrationCode: String
    var email: String
    var password: String
    var fullName: String
    var workID: String
    var birthday: String
    var phone: String
    var rememberMe: Bool
    var accessToken: String
    var isconfirmed: Bool
    var isactivated: Bool
    var roleName: String
    var profileImage: Int
    var userID: Int
    var joinDay: String
    
    
    init() {
        self.registrationCode = ""
        self.email = ""
        self.password = ""
        self.fullName = ""
        self.workID = ""
        self.birthday = ""
        self.phone = ""
        self.rememberMe = true
        self.accessToken = ""
        self.roleName = ""
        self.profileImage = 0
        self.isconfirmed = false
        self.isactivated = false
        self.userID = 0
        self.joinDay = ""
    }
    
}
