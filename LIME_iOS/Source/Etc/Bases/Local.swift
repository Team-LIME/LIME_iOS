//
//  Local.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation
import RealmSwift

class Local {
    private static var realmInstance : Realm!
    
    func getReam() -> Realm! {
        if(Local.realmInstance == nil){
            Local.realmInstance = try! Realm()
        }
        return Local.realmInstance
    }
}
