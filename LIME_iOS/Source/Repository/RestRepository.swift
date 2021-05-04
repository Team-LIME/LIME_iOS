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
    
    //MARK: - 로그인
    func login(_ request: LoginRequest) -> Single<Void> {
        return authProvider.rx.request(.postLogin(request))
            .map(Response<LoginResponse>.self, using: decoder)
            .withUnretained(self)
            .flatMap { owner, element in
                owner.authLocal.saveToken(element.data.toEntity())
            }
    }
    
    //MARK: - 회원가입
    func register(_ request: RegisterRequest) -> Single<Void> {
        return authProvider.rx.request(.postRegister(request))
            .map(MessageResponse.self, using: decoder)
            .map { _ in Void() }
    }
    
    //MARK: - 토큰상태 조회
    func fetchTokenStatus() -> Single<Bool> {
        return authLocal.getToken()
            .flatMap { [weak self] in
                guard let self  = self else { return .error(LimeError.error(message: "토큰 오류", keys: [.basic]))}
                return self.authProvider.rx.request(.getTokenInfo($0.token))
                    .map(Response<FetchTokenInfoResponse>.self, using: self.decoder)
                    .map { _ in true }
            }.catchError { _ in .just(false) }
    }
}

