//
//  RegisterPage1ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/12/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class RegisterPage1ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate {
    var user : User!
    
    //Links from storyboard
    @IBOutlet var contentScrollView: UIScrollView!
    
    @IBOutlet var regTextField: RegisterTextField!
    
    @IBAction func nextBtn(_ sender: Any) {
        //Check if registration code text field is empty
        if regTextField.text!.trimmingCharacters(in: .whitespaces) == "" {
            Utiles.show(alertMessage: NSLocalizedString("Please enter the registration code", comment: ""), onViewController: self)
        }
        else {
            //Check registration code
            UserManager.checkRegistration(registrationCode: regTextField.text!) { (error) in
                if error == "" {
                    self.performSegue(withIdentifier: "regToEmail", sender: nil)
                }
                else{
                    print(error)
                    Utiles.show(alertMessage: error, onViewController: self)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        self.contentScrollView.delegate = self
        
        //Init user
        user = User.init()
        
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
    
    //Pass registration code with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RegisterPage2ViewController {
            user.registrationCode = regTextField.text!
            destination.user = user
        }
    }

    
}

