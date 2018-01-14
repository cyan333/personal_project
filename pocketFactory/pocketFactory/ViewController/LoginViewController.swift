//
//  ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/9/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet var contentScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.usernameTextField.tag = 1 //Increment accordingly
        self.passwordTextField.tag = 2
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    deinit {
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
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField.tag == 1 {
            self.passwordTextField.becomeFirstResponder()
        }
        else{
            self.passwordTextField.resignFirstResponder()
        }
        return false
    }

}

