//
//  RegisterTextField.swift
//  pocketFactory
//
//  Created by NingFangming on 1/10/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import UIKit

class RegisterTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor(hexString: "CCCCCC").cgColor
        self.layer.borderWidth = 1
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 7)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

}
