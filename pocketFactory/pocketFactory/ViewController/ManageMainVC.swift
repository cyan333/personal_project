//
//  ManageMainVC.swift
//  pocketFactory
//
//  Created by NingFangming on 4/27/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import UIKit

class ManageMainVC: UIViewController {
    
    override func viewDidLoad() {
        setupNavBar()
    }
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    

    @IBAction func switchManageMainTbViewAction(_ sender: UISegmentedControl) {
    }
}
