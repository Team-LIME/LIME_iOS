//
//  AuthLocal.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import RxSwift
import RealmSwift

class AuthLocal: LIME_iOS.Local {
    lazy var realm: Realm! = getReam() // keychain why? more high security를 보장해야한다. == 키체인말고는 답이 없다
    
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
    
    func getToken() -> Single<TokenEntity> {
        return Single<TokenEntity>.create { [weak self] single in
            guard let self = self else {
                single(.error(LimeError.error(message: "토큰 조회 실패", keys: [.retry])))
                return Disposables.create()
            }
            let data = self.realm.objects(TokenEntity.self)
            if(data.isEmpty){
                single(.error(LimeError.error(message: "토큰 조회 실패", keys: [.retry])))
            }else{
                single(.success(data.first!))
            }

            return Disposables.create()
        }
    }

}
