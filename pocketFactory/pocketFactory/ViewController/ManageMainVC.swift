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
    @IBOutlet var peoplePositionLabel: UILabel!
}

class ManageRoleCell: UITableViewCell {
    @IBOutlet weak var roleNameLabel: UILabel!
    
}

class ManageMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating {
    

    @IBOutlet weak var manageSegCtrl: UISegmentedControl!
    @IBOutlet weak var manageTableView: UITableView!
    
    var searchController: UISearchController!
    
    var userList = [User]()
    var filteredUsers = [User]()
    var userFromMain = User()
    
    var roleList = [Role]()
    var filteredRoles = [Role]()
    var roleFromMain = Role()
    
    
    //Flags
    var loadingRoleList = false
    
    override func viewDidLoad() {
        setupNavBar()
        UserManager.getUserList(limit: 100, offset: 0) { (error, someUsers) in
            if error != "" {
                Utiles.show(alertMessage: error, onViewController: self)
            }
            else {
                self.userList = someUsers
                self.manageTableView.reloadData()
            }
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
            switch manageSegCtrl.selectedSegmentIndex {
            case 0:
                if isFiltering() {
                    return filteredUsers.count
                }
                else {
                    returnValue = userList.count
                }
                break
            case 1:
                returnValue = 0
                break
            case 2:
                if isFiltering() {
                    return filteredRoles.count
                }
                else {
                    returnValue = roleList.count
                }
                
                break
            default:
                returnValue = 0
                break
            }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tempUser = User()
        var tempRole = Role()
        
        switch manageSegCtrl.selectedSegmentIndex {
        case 0:
            let managePeopleCell = tableView.dequeueReusableCell(withIdentifier: "ManagePeopleProfileNameDepartmentCell") as! ManagePeopleProfileNameDepartmentCell
            if isFiltering() {
                tempUser = filteredUsers[indexPath.row]
            }
            else {
                tempUser = userList[indexPath.row]
            }
            managePeopleCell.peopleNameLabel?.text = tempUser.fullName
            managePeopleCell.peoplePositionLabel?.text = tempUser.roleName
            return managePeopleCell
            
        case 1:
            break
        case 2:
            let manageRoleCell = tableView.dequeueReusableCell(withIdentifier: "ManageRoleCell") as! ManageRoleCell
            if isFiltering() {
                tempRole = filteredRoles[indexPath.row]
            }
            else {
                tempRole = roleList[indexPath.row]
            }
            manageRoleCell.roleNameLabel?.text = tempRole.name
            return manageRoleCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch manageSegCtrl.selectedSegmentIndex {
        case 0:
            return 70
        case 1:
            break
        case 2:
            return UITableViewAutomaticDimension
        default:
            break
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected", indexPath.row)
        
        switch manageSegCtrl.selectedSegmentIndex {
        case 0:
            userFromMain = userList[indexPath.row]
            performSegue(withIdentifier: "peopleToPeopleDetail", sender: self)
        case 1:
            break
        case 2:
            roleFromMain = roleList[indexPath.row]
            performSegue(withIdentifier: "roleToRoleDetail", sender: self)
        default:
            break
        } 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PeopleDetailVC {
            destination.thisUser = userFromMain
        }
        else if let destination = segue.destination as? RoleDetailVC {
            destination.thisRole = roleFromMain
        }
    }
    
    func setupNavBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Result"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = userList.filter({ (user: User) -> Bool in
            return user.fullName.lowercased().contains(searchText.lowercased())
        })
        filteredRoles = roleList.filter({ (role: Role) -> Bool in
            return role.name.lowercased().contains(searchText.lowercased())
        })
        manageTableView.reloadData()
        
    }
    
    //Let table view knows that search bar is filtering result
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
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
