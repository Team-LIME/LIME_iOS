//
//  String.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import Foundation

extension String {
    func isValidGeneration() -> Bool {

        let emailRegEx = "[1-6]"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPw() -> Bool {

        let pwRegEx = "[a-zA-Z0-9!@#$%^*+=-]{7,20}"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwTest.evaluate(with: self)
    }
}
