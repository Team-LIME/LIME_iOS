//
//  String.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import Foundation

extension String {
    func isValidNmber() -> Bool {

        let emailRegEx = "[1-6]"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
