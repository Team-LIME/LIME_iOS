//
//  AuthRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Moya
import RxSwift
import Alamofire
import Foundation
import RxMoya

class AuthRepository: LIME_iOS.RestRepository<AuthAPI, AuthLocal> {
    //MARK: - 로그인
    func login(_ request: LoginRequest) -> Single<Void> {
        return provider.rx.request(.postLogin(request))
            .map(Response<LoginResponse>.self, using: decoder)
            .withUnretained(self)
            .flatMap { owner, element in
                owner.local.saveToken(element.data.toEntity())
            }
    }

    //MARK: - 회원가입
    func register(_ request: RegisterRequest) -> Single<Void> {
        return provider.rx.request(.postRegister(request))
            .map(MessageResponse.self, using: decoder)
            .map { _ in Void() }
    }

    //MARK: - 토큰상태 조회
    func fetchTokenStatus() -> Single<Bool> {
        return local.getToken()
            .withUnretained(self)
            .flatMap { owner, element in
                return owner.provider.rx.request(.getTokenInfo(element.token))
                    .map(Response<FetchTokenInfoResponse>.self, using: self.decoder)
                    .map { _ in true }
            }.catchError { _ in .just(false) }
    }
}

