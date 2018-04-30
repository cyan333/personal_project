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
        let role1 = Role()
        role1.name = "Department Head"
        let role2 = Role()
        role2.name = "Professor"
        let role3 = Role()
        role3.name = "Professor"
        completion("",[role1,role2,role3])
        
    }
    
    
}
