//
//  ViewWithScrollViewComponent.swift
//  ScrollViewKeyboardShowHideDemo
//
//  Created by doriswu on 2016/9/10.
//  Copyright © 2016年 doriswu. All rights reserved.
//

import UIKit

class ViewWithScrollViewComponent: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var contentInset = UIEdgeInsets()
    
    override func drawRect(rect: CGRect) {
        contentInset = scrollView.contentInset
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewWithScrollViewComponent.closekeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func closekeyboard() {
        self.endEditing(true)
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.convertRect(keyboardFrame, fromView: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let pointZero:CGPoint = CGPointZero
        scrollView.contentOffset = pointZero
        scrollView.contentInset = contentInset
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}
