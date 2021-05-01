//
//  TokenEntitiy.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation
import RealmSwift

class TokenEntity: Object {
    @objc dynamic var token: String = ""
    
    init(token: String){
        self.token = token
    }
    
    override init(){
        super.init()
    }
}
