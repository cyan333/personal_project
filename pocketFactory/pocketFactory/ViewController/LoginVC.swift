//
//  ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/9/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate  {

    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet weak var rememberMe: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.usernameTextField.tag = 1 //Increment accordingly
        self.passwordTextField.tag = 2
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        self.contentScrollView.delegate = self
        
        //Set Bg color for navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.yellow
        //Set btn color
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Press return key to continute editing
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
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        UserManager.userLogin(userName: usernameTextField.text!, password: passwordTextField.text!, rememberMe: (rememberMe != nil)) { (error, thisUser) in
            if error == "" {
                currentUser = thisUser
                self.performSegue(withIdentifier: "loginToMain", sender: nil)
            }
            else {
                Utiles.show(alertMessage: error, onViewController: self)
            }
        }
        
    }
    

}

