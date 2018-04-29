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
    @IBOutlet var peopleNextArrowImage: UIImageView!
    @IBOutlet var peoplePositionLabel: UILabel!
    
    
}

class ManageMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["Milk", "Monkey", "Break"]
    let product = ["40W Charger", "Battery Charger", "Waterproof Charger"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagePeopleProfileNameDepartmentCell") as! ManagePeopleProfileNameDepartmentCell
        cell.peopleNameLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    override func viewDidLoad() {
        
        
        setupNavBar()
        
        
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
    }
}
