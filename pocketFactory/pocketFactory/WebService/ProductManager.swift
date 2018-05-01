//
//  productManager.swift
//  pocketFactory
//
//  Created by NingFangming on 4/29/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import Alamofire


open class ProductManager {
    
    
    open class func getUserList(limit: Int, offset: Int, completion: @escaping (_ error: String, _ userList: [User]) -> Void) {
        let user1 = User()
        user1.fullName = "谢珊珊"
        user1.roleName = "CEO"
        let user2 = User()
        user2.fullName = "宁方鸣"
        user2.roleName = "扫厕所"
        
        completion("",[user1,user2])
        
    }
    
    
}
