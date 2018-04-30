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
    var savedEmail: String
    var savedPW: String
    var savedName: String
    var savedWorkID: String
    var savedBD: String
    var savedPhone: String
    var rememberMe: Bool
    var accessToken: String
    
    var department: String
    var position: String
    var profileImage: Int
    
    init(registrationCode : String,
         savedEmail: String,
         savedPW: String,
         savedName: String,
         savedWorkID: String,
         savedBD: String,
         savedPhone: String,
         rememberMe: Bool,
         accessToken: String,
         department: String,
         position: String,
         profileImage: Int) {
        
        self.registrationCode = registrationCode
        self.savedEmail = savedEmail
        self.savedPW = savedPW
        self.savedName = savedName
        self.savedWorkID = savedWorkID
        self.savedBD = savedBD
        self.savedPhone = savedPhone
        self.rememberMe = rememberMe
        self.accessToken = accessToken
        self.department = department
        self.position = position
        self.profileImage = profileImage
    }
    
    init() {
        self.registrationCode = ""
        self.savedEmail = ""
        self.savedPW = ""
        self.savedName = ""
        self.savedWorkID = ""
        self.savedBD = ""
        self.savedPhone = ""
        self.rememberMe = true
        self.accessToken = ""
        self.department = ""
        self.position = ""
        self.profileImage = 1
    }
    
}
