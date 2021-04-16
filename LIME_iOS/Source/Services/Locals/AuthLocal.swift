//
//  AuthLocal.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import RxSwift
import RealmSwift

class AuthLocal: LIME_iOS.Local {
    lazy var realm: Realm! = getReam()
    
    func saveToken(_ tokenEntity: TokenEntity?) -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard let tokenEntity = tokenEntity else {
                single(.error(LimeError.error(message: "토큰 저장 실패", keys: [.retry])))
                return Disposables.create()
            }
            
            guard let self = self else {
                single(.error(LimeError.error(message: "토큰 저장 실패", keys: [.retry])))
                return Disposables.create()
            }
            
            do{
                try self.realm.write {
                    self.realm.delete(self.realm.objects(TokenEntity.self))
                    self.realm.add(tokenEntity)
                }
                single(.success(Void()))
            }
            catch{
                single(.error(LimeError.error(message: "토큰 저장 실패", keys: [.retry])))
            }
            return Disposables.create()
        }
    }

}
