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
    private let provider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])
    private let decoder = JSONDecoder()
    
    private let authAPI: AuthAPI
    private let authLocal: AuthLocal
    
    init(authAPI: AuthAPI, authLocal: AuthLocal) {
        self.authAPI = authAPI
        self.authLocal = authLocal
    }
    
    func login(_ request: LoginRequest) -> Single<Void> {
        return provider.rx.request(.postLogin(request))
            .map(Response<LoginResponse>.self, using: decoder)
            .withUnretained(self)
            .flatMap { owner, element in
                owner.authLocal.saveToken(element.data.toEntity())
            }
    }
    
    func register(_ request: RegisterRequest) -> Single<Void> {
        return provider.rx.request(.postRegister(request))
            .map(Response<RegisterResponse>.self, using: decoder)
            .map { _ in Void() }
    }
}

