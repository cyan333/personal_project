//
//  RegisterPage1ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/12/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class RegisterPage2ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate {
    var user : User!
    
    //Text Field
    @IBOutlet var email: RegisterTextField!
   
    
    @IBOutlet var pwTextfield: RegisterTextField!
    @IBOutlet var pwConfirmTextfield: RegisterTextField!
    
    @IBAction func nextBtn(_ sender: Any) {
        //Check pw matching
        if pwTextfield.text == pwConfirmTextfield.text {
            //Then check email
            if !validateEmail(enteredEmail: email.text!) {
                Utiles.show(alertMessage: NSLocalizedString("Email adress is not valid", comment: ""), onViewController: self)

            }
            else {
                //Then check if email exist
                UserManager.checkUsername(userName: email.text!, completion: { (error) in
                    if error != "" {
                        print(error)
                        Utiles.show(alertMessage: error, onViewController: self)
                    }
                    else {
                        self.performSegue(withIdentifier: "reg2ToReg3", sender: nil)
                    }
                })
            }
        }
        else {
            Utiles.show(alertMessage: NSLocalizedString("Password does not match", comment: ""), onViewController: self)
        }
    }
    
    @IBOutlet var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        self.contentScrollView.delegate = self
        
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
        print(frame.height)
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
    
    //Validate Email
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    //Pass registration code with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RegisterPage3ViewController {
            user.savedEmail = email.text!
            user.savedPW = pwTextfield.text!
            destination.user = user
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let backDestination = viewController as? RegisterPage1ViewController {
            user.savedEmail = email.text!
            backDestination.user = user
        }
    }
    
}


