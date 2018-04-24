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

        let request = Utiles.getRequest(toSubURL: "validate_reg_code", withJson: ["regCode": registrationCode] as [String : Any])
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
        
        let request = Utiles.getRequest(toSubURL: "check_username", withJson: ["username": userName] as [String : Any])
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
}
