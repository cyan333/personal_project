//
//  LoginTextField.swift
//  pocketFactory
//
//  Created by NingFangming on 1/9/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 7)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
