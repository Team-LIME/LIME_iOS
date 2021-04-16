//
//  RegisterRequest.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

class RegisterRequest: Encodable {
    var email: String
    var pw: String
    var name: String
    var intro: String
    var generation: Int
    var type: String
    
    init(email:String,
         pw: String,
         name: String,
         intro: String,
         generation: Int,
         type: String){
        self.email = email
        self.pw = pw
        self.name = name
        self.intro = intro
        self.generation = generation
        self.type = type
    }
}
