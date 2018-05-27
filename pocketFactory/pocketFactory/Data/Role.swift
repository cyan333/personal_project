//
//  Role.swift
//  pocketFactory
//
//  Created by NingFangming on 4/27/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
open class Role {
    var name: String
    var department: String
    var positionLevel: Int
    var ownerName: String
    var updateBy: String
    var canCreateTask: Bool
    var canCreateProduct: Bool
    var id : Int
    
  
    
    init() {
        self.name = ""
        self.positionLevel = 0
        self.ownerName = ""
        self.updateBy = ""
        self.canCreateTask = false
        self.canCreateProduct = false
        self.id = 0
        self.department = ""
    }
    
}
