//
//  RoleManager.swift
//  pocketFactory
//
//  Created by NingFangming on 4/29/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import Alamofire


open class RoleManager {
    
    open class func getRoleList(limit: Int, offset: Int, completion: @escaping (_ error: String, _ roleList: [Role]) -> Void) {
        
        if demoMode {
            let role1 = Role()
            role1.name = "Department Head"
            role1.canCreateProduct = false
            role1.canCreateTask = true
            role1.ownerName = "Shanshan Xie"
            role1.positionLevel = 1
            role1.updateBy = "Fangqing Xie"
            
            let role2 = Role()
            role2.name = "Professor"
            role2.canCreateProduct = true
            role2.canCreateTask = true
            role2.ownerName = "Fangqing Xie"
            role2.positionLevel = 11
            role2.updateBy = "Fangming Ning"
            
            let role3 = Role()
            role3.name = "Tutor"
            role3.canCreateProduct = true
            role3.canCreateTask = false
            role3.ownerName = "Fangming Ning"
            role3.positionLevel = 5
            role3.updateBy = "Minyi Yang"
            
            completion("",[role1,role2,role3])
            return
        }
        
        let request = Utiles.getRequestWithAccessToken(toSubURL: "get_all_roles", withJson: ["limit": limit, "offset": offset])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline, [Role]())
            case .success(let data):
                if let json = data as? [String : Any] {
                    if let error = json["errMsg"] as? String {
                        completion(error, [Role]())
                    }
                    else{
                        let jsonList = json["roleList"] as! [Any]
                        var roleList = [Role]()
                        for case let map as [String: Any] in jsonList {
                            
                            let role = Role()
                            role.id = map["id"] as! Int
                            role.name = map["name"] as! String
                            //Not Required Field, can be null
                            if let department = map["department"] as? String {
                                role.department = department
                            }
                            
                            roleList.append(role)
                        }
                        completion("", roleList)
                    }
                }
                else {
                    completion(serviceInternalError, [Role]())
                }
                
            }
        }
        
    }
    
    
}
