///
//  RegisterPage1ViewController.swift
//  pocketFactory
//
//  Created by NingFangming on 1/12/18.
//  Copyright © 2018 fangming. All rights reserved.
//

//import UIKit
//
//class RegisterPage3ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
//        view.addGestureRecognizer(tapGesture)
//        
//        self.contentScrollView.delegate = self
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        addObservers()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        removeObservers()
//    }
//    
//    @objc func didTapView(gesture: UITapGestureRecognizer){
//        //Hide keyboard for the view
//        view.endEditing(true)
//    }
//    
//    func addObservers(){
//        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil){
//            notification in
//            self.keyboardWillShow(notification: notification)
//        }
//        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil){
//            notification in
//            self.keyboardWillHide(notification: notification)
//        }
//    }
//    func removeObservers(){
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    func keyboardWillShow(notification: Notification){
//        guard let userInfo = notification.userInfo,
//            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//                return
//        }
//        let contentInset = UIEdgeInsetsMake(0, 0, frame.height, 0)
//        contentScrollView.contentInset = contentInset
//    }
//    
//    func keyboardWillHide(notification: Notification){
//        contentScrollView.contentInset = UIEdgeInsets.zero
//    }
//    
//    //Disable horizontal scolling
//    func scrollViewDidScroll(_ contentScrollView: UIScrollView) {
//        if contentScrollView.contentOffset.x>0 || contentScrollView.contentOffset.x < 0 {
//            contentScrollView.contentOffset.x = 0
//        }
//    }
//    
//    
//    
//}

