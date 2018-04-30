//
//  userManager.swift
//  pocketFactory
//
//  Created by NingFangming on 4/22/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import Alamofire



open class UserManager {
    
    open class func userLogin(userName: String, password: String, rememberMe: Bool, completion: @escaping (_ error: String, _ userData: User) -> Void) {
        if demoMode {
            completion("",User())
            return
        }
        let request = Utiles.getRequest(toSubURL: "login", withJson: ["username": userName, "password": password, "remember":rememberMe])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline, User())
                
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error, User())
                    }
                    else{
                        if json["activated"] as! Bool {
                            let thisUser = User(registrationCode: "",
                                                savedEmail: userName,
                                                savedPW: "",
                                                savedName: json["name"] as! String,
                                                savedWorkID: "",
                                                savedBD: "",
                                                savedPhone: json["phone"] as! String,
                                                rememberMe: rememberMe,
                                                accessToken: json["accessToken"] as! String,
                                                department: "",
                                                position: "",
                                                profileImage: 0)
                            if let birthday = json["birthday"] as? String {
                                thisUser.savedBD = birthday
                            }
                            if let workId = json["workId"] as? String {
                                thisUser.savedWorkID = workId
                            }
                            if let phone = json["phone"] as? String {
                                thisUser.savedPhone = phone
                            }
                            if let profileImage = json["avatarId"] as? Int {
                                thisUser.profileImage = profileImage
                            }
                            completion("",thisUser)
                        }
                        else {
                            completion("Your account is not activated. Please contact your manager.", User())
                        }
                    }
                }
                else {
                    completion(serviceInternalError, User())
                }
                
            }
        }
    }
    
    open class func checkRegistration(registrationCode: String, completion: @escaping (_ error: String) -> Void) {
        if demoMode {
            completion("")
            return
        }
        let request = Utiles.getRequest(toSubURL: "validate_reg_code", withJson: ["regCode": registrationCode])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline)
                
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error)
                    }
                    else{
                        completion("")
                    }
                }
                else {
                    completion(serviceInternalError)
                }

            }
        }
    }
    
    open class func checkUsername(userName: String, completion: @escaping (_ error: String) -> Void) {
        if demoMode {
            completion("")
            return
        }
        let request = Utiles.getRequest(toSubURL: "check_username", withJson: ["username": userName])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline)
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error)
                    }
                    else{
                        completion("")
                    }
                }
                else {
                    completion(serviceInternalError)
                }
                
            }
        }
    }
    
    open class func getUserList(limit: Int, offset: Int, completion: @escaping (_ error: String, _ userList: [User]) -> Void) {
        let user1 = User()
        user1.savedName = "谢珊珊"
        user1.department = "ECE Department"
        user1.position = "CEO"
        let user2 = User()
        user2.savedName = "宁方鸣"
        user2.department = "CS Department"
        user2.position = "扫厕所"
        
        completion("",[user1,user2])
        
    }
    
    open class func registerUser(regCode: String,
                                 email: String,
                                 pw: String,
                                 name: String,
                                 workID: String,
                                 birthday: String,
                                 phone: String,
                                 rememberMe: Bool,
                                 completion: @escaping (_ error: String, _ accessToken: String, _ activated: Bool) -> Void) {
        if demoMode {
            completion("", "", true)
            return
        }
        let request = Utiles.getRequest(toSubURL: "register", withJson: ["regCode": regCode,
                                                                         "username": email,
                                                                         "password": pw,
                                                                         "name": name,
                                                                         "workId": workID,
                                                                         "birthday": birthday,
                                                                         "phone": phone,
                                                                         "remember": rememberMe] as [String : Any])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline, "", false)
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error, "", false)
                    }
                    else{
                        completion("", json["accessToken"] as! String, json["activated"] as! Bool)
                    }
                }
                else {
                    completion(serviceInternalError, "", false)
                }
                
            }
        }
    }
    
}
