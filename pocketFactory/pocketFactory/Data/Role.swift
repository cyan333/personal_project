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
    var positionLevel: Int
    var ownerName: String
    var updateBy: String
    var canCreateTask: Bool
    var canCreateProduct: Bool
    
    
    init(name: String,
         positionLevel: Int,
         ownerName: String,
         updateBy: String,
         canCreateTask: Bool,
         canCreateProduct: Bool) {
        self.name = name
        self.positionLevel = positionLevel
        self.ownerName = ownerName
        self.updateBy = updateBy
        self.canCreateTask = canCreateTask
        self.canCreateProduct = canCreateProduct

    }
    
    init() {
        self.name = ""
        self.positionLevel = 1
        self.ownerName = ""
        self.updateBy = ""
        self.canCreateTask = false
        self.canCreateProduct = false
    }
    
}
