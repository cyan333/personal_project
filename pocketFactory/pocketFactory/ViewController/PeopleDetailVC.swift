//
//  PeopleDetailVC.swift
//  pocketFactory
//
//  Created by NingFangming on 4/30/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import UIKit

class PeopleDetailCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectDetailLabel: UILabel!
    
}

class PeopleDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var thisUser = User()
    var thisUserSubjectDetail = [String]()
    var thisUserSubject = [String]()
    
    override func viewDidLoad() {
        thisUserSubjectDetail = [thisUser.birthday, thisUser.email, thisUser.fullName, thisUser.joinDay, thisUser.phone, thisUser.roleName]
        thisUserSubject = ["Birthday", "Email","Full Name","Join Day","Phone","Role"]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisUserSubject.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let detailCell = tableView.dequeueReusableCell(withIdentifier: "PeopleDetailCell") as! PeopleDetailCell
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "PeopleDetailCell") as! PeopleDetailCell
        
        detailCell.subjectLabel?.text = thisUserSubject[indexPath.row]
        detailCell.subjectDetailLabel?.text = thisUserSubjectDetail[indexPath.row]
        
        
        return detailCell
    }
}

