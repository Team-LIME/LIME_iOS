//
//  LoginRequest.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import CryptoSwift

class LoginRequest: Encodable {
    var email: String
    var pw: String
    
    init(email: String,
         pw: String){
        self.email = email
        self.pw = pw.sha512()
    }
}
