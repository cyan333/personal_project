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
                        let thisUser = User()
                        thisUser.email = userName
                        thisUser.fullName = json["name"] as! String
                        thisUser.phone = json["phone"] as! String
                        thisUser.rememberMe = rememberMe
                        thisUser.accessToken = json["accessToken"] as! String
                        if let birthday = json["birthday"] as? String {
                            thisUser.birthday = birthday
                        }
                        if let workId = json["workId"] as? String {
                            thisUser.workID = workId
                        }
                        if let phone = json["phone"] as? String {
                            thisUser.phone = phone
                        }
                        if let profileImage = json["avatarId"] as? Int {
                            thisUser.profileImage = profileImage
                        }
                        completion("",thisUser)
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
        
        if demoMode {
            let user1 = User()
            user1.fullName = "Shanshan Xie"
            user1.roleName = "CEO"
            user1.birthday = "3-24-1995"
            user1.email = "sxie@wpi.edu"
            user1.isconfirmed = true
            user1.joinDay = "8/24/2014"
            
            let user2 = User()
            user2.fullName = "Fangming Ning"
            user2.roleName = "Sofware Engineer"
            user2.birthday = "1-4-1994"
            user2.email = "fmning@wpi.edu"
            user2.isconfirmed = false
            user2.joinDay = "2/24/2014"
            
            completion("",[user1,user2])
            return
        }
        let request = Utiles.getRequestWithAccessToken(toSubURL: "get_all_users", withJson: ["limit": limit, "offset": offset])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline, [User]())
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error, [User]())
                    }
                    else{
                        let jsonList = json["userList"] as! [Any]
                        var userList = [User]()
                        for case let map as [String: Any] in jsonList {
                            
                            let user = User()
                            user.userID = map["id"] as! Int
                            user.isconfirmed = map["confirmed"] as! Bool
                            user.isactivated = map["activated"] as! Bool
                            user.fullName = map["name"] as! String
                            user.roleName = map["roleName"] as! String
                            if let phone = map["phone"] as? String {
                                user.phone = phone
                            }
                            if let workID = map["workId"] as? String {
                                user.workID = workID
                            }
                            if let profileImage = map["avatarId"] as? Int {
                                user.profileImage = profileImage
                            }
                            if let birthday = map["birthday"] as? String {
                                user.birthday = birthday
                            }
                            if let joinDay = map["joinedDay"] as? String {
                                user.joinDay = joinDay
                            }
                            userList.append(user)
                        }
                        completion("", userList)
                    }
                }
                else {
                    completion(serviceInternalError, [User]())
                }
                
            }
        }
        
    }
    
    open class func registerUser(regCode: String,
                                 email: String,
                                 pw: String,
                                 name: String,
                                 workID: String,
                                 birthday: String,
                                 phone: String,
                                 rememberMe: Bool,
                                 completion: @escaping (_ error: String, _ accessToken: String) -> Void) {
        if demoMode {
            completion("", "")
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
                completion(serviceOffline, "")
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error, "")
                    }
                    else{
                        completion("", json["accessToken"] as! String)
                    }
                }
                else {
                    completion(serviceInternalError, "")
                }
                
            }
        }
    }
    
}
