//
//  RoleDetailVC.swift
//  pocketFactory
//
//  Created by NingFangming on 4/30/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import UIKit

class RoleDetailCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var subjectContent: UILabel!
    
}

class RoleDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var thisRole : Role!
    var thisRoleSubjectContent = [String]()
    var thisRoleSubject = [String]()
    
    override func viewDidLoad() {
        thisRoleSubjectContent = [thisRole.name,
                                  thisRole.canCreateProduct ? "Allowed" : "Not Allowed",
                                  thisRole.department,
                                  thisRole.canCreateTask ? "Allowed" : "Not Allowed",
                                  thisRole.ownerName,
                                  String(thisRole.positionLevel),
                                  thisRole.updateBy]
        thisRoleSubject = ["Role Name",
                           "Product Create",
                           "Department",
                           "Task Create",
                           "Owner",
                           "Position",
                           "Updated By"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisRoleSubject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "RoleDetailCell") as! RoleDetailCell
        
        detailCell.subject?.text = thisRoleSubject[indexPath.row]
        detailCell.subjectContent?.text = thisRoleSubjectContent[indexPath.row]
        
        return detailCell
    }
    

}

