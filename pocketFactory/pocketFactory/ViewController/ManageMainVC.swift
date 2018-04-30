//
//  ManageMainVC.swift
//  pocketFactory
//
//  Created by NingFangming on 4/27/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import UIKit

class ManagePeopleProfileNameDepartmentCell: UITableViewCell {
    
    @IBOutlet var peopleProfileImage: UIImageView!
    @IBOutlet var peopleNameLabel: UILabel!
    @IBOutlet var peopleDepartmentLabel: UILabel!
    @IBOutlet var peoplePositionLabel: UILabel!
}

class ManageRoleCell: UITableViewCell {
    @IBOutlet weak var roleNameLabel: UILabel!
    
}

class ManageMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var manageSegCtrl: UISegmentedControl!
    @IBOutlet weak var manageTableView: UITableView!
    
    var userList = [User]()
    var roleList = [Role]()
    
    //Flags
    var loadingRoleList = false
    
    override func viewDidLoad() {
        
        UserManager.getUserList(limit: 1, offset: 1) { (error, someUsers) in
            self.userList = someUsers
            self.manageTableView.reloadData()
        }
        setupNavBar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch manageSegCtrl.selectedSegmentIndex {
        case 0:
            returnValue = userList.count
            break
        case 1:
            returnValue = 0
            break
        case 2:
            returnValue = roleList.count
            break
        default:
            returnValue = 0
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch manageSegCtrl.selectedSegmentIndex {
        case 0:
            let managePeopleCell = tableView.dequeueReusableCell(withIdentifier: "ManagePeopleProfileNameDepartmentCell") as! ManagePeopleProfileNameDepartmentCell
            managePeopleCell.peopleNameLabel?.text = userList[indexPath.row].savedName
            managePeopleCell.peopleDepartmentLabel?.text = userList[indexPath.row].department
            managePeopleCell.peoplePositionLabel?.text = userList[indexPath.row].position
            return managePeopleCell
        case 1:
            break
        case 2:
            let manageRoleCell = tableView.dequeueReusableCell(withIdentifier: "ManageRoleCell") as! ManageRoleCell
            manageRoleCell.roleNameLabel?.text = roleList[indexPath.row].name
            return manageRoleCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func switchManageMainTbViewAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            manageTableView.reloadData()
            break
        case 1:
            
            
            break
        case 2:
            if self.roleList.count > 0 {
                manageTableView.reloadData()
            }
            else {
                if !loadingRoleList {
                    self.loadingRoleList = true
                    RoleManager.getRoleList(limit: 1, offset: 1) { (error, someRoles) in
                        self.roleList = someRoles
                        self.manageTableView.reloadData()
                    }
                }
            }
            break
        default:
            break
        }
        
    }
}
