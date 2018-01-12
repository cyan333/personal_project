//
//  ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/9/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var UsernameTextField: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.UsernameTextField.delegate = self;
        UsernameTextField.tag = 0 //Increment accordingly
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = UsernameTextField.superview?.viewWithTag(UsernameTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            UsernameTextField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

}

