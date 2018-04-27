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
    
//    String username = ((String) Utils.notNull(request.get("username"))).toLowerCase();
//    String password = (String) Utils.notNull(request.get("password"));
//    boolean remember = (boolean) Utils.notNull(request.get("remember"));
//    String name = (String) Utils.notNull(request.get("name"));
//    String phone = (String) request.get("phone");
//    String workId = (String) request.get("workId");
//    Instant birthday = Utils.parseInstantStr((String) request.get("birthday"));
//    Instant joinedDate = Utils.parseInstantStr((String) request.get("joinedDate"));
//    String avatar = (String) request.get("avatar");
//    String regCode = (String)request.get("regCode");
//
    
}
