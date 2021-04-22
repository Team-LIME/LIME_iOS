//
//  RestRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Moya
import RxSwift
import Alamofire
import Foundation
import RxMoya

class RestRepository {
    static let shared = RestRepository()
    
    private lazy var decoder = JSONDecoder()
    
    private lazy var authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])
    private lazy var authLocal = AuthLocal()
    
    func login(_ request: LoginRequest) -> Single<Void> {
        return authProvider.rx.request(.postLogin(request))
            .map(Response<LoginResponse>.self, using: decoder)
            .withUnretained(self)
            .flatMap { owner, element in
                owner.authLocal.saveToken(element.data.toEntity())
            }
    }
    
    func register(_ request: RegisterRequest) -> Single<Void> {
        return authProvider.rx.request(.postRegister(request))
            .map(Response<RegisterResponse>.self, using: decoder)
            .map { _ in Void() }
    }
}

