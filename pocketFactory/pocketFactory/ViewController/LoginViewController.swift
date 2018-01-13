//
//  ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/9/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var UsernameTextField: LoginTextField!
    @IBOutlet weak var PWTextField: LoginTextField!
    @IBOutlet var ContentView: UIView!
    
    var originalY: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.UsernameTextField.delegate = self;
        self.PWTextField.delegate = self;
        self.UsernameTextField.tag = 1 //Increment accordingly
        self.PWTextField.tag = 2
        
        originalY = ContentView.frame.origin.y;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let YneedToBe = self.originalY - 100
        if (self.ContentView.frame.origin.y != YneedToBe){
            UIView.animate(withDuration: 0.5) {
                self.ContentView.frame.origin.y = YneedToBe
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.ContentView.frame.origin.y = self.originalY;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField.tag == 1 {
            self.PWTextField.becomeFirstResponder()
        }
        else{
            self.PWTextField.resignFirstResponder()
        }
        
//        if let nextField = UsernameTextField.superview?.viewWithTag(UsernameTextField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            // Not found, so remove keyboard.
//            PWTextField.resignFirstResponder()
//        }
        // Do not add a line break
        return false
    }

}

