///
//  RegisterPage1ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/12/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class RegisterPage3ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate {
    var user : User!
    @IBOutlet var contentScrollView: UIScrollView!
    
    @IBOutlet var phoneTextfield: RegisterTextField!
    @IBOutlet var workID: RegisterTextField!
    @IBOutlet var nameTextfield: RegisterTextField!
    @IBOutlet var bdDatePicker: RegisterTextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        self.contentScrollView.delegate = self
        
        //Create date picker for birthday entry
        createDatePicker()
        
        self.navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer){
        //Hide keyboard for the view
        view.endEditing(true)
    }
    
    //Move view with keyboard
    func addObservers(){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil){
            notification in
            self.keyboardWillShow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil){
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsetsMake(0, 0, frame.height, 0)
        contentScrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        contentScrollView.contentInset = UIEdgeInsets.zero
    }
    
    //Disable horizontal scolling
    func scrollViewDidScroll(_ contentScrollView: UIScrollView) {
        if contentScrollView.contentOffset.x>0 || contentScrollView.contentOffset.x < 0 {
            contentScrollView.contentOffset.x = 0
        }
    }
    
    func createDatePicker() {
        //Format date picker
        datePicker.datePickerMode = .date
        
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Bar button item
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: false)
        
        //Assign date picker to text field
        bdDatePicker.inputAccessoryView = toolbar
        bdDatePicker.inputView = datePicker
    }
    
    @objc func donePressed(){
        
        //Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        //Add date to textfield
        bdDatePicker.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let backDestination = viewController as? RegisterPage2ViewController {
            user.savedName = nameTextfield.text!
            user.savedPhone = phoneTextfield.text!
            user.savedBD = bdDatePicker.text!
            user.savedWorkID = workID.text!
            backDestination.user = user
        }
    }
}

