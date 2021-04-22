//
//  LoginViewReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import ReactorKit
import RxSwift
import RxCocoa

class LoginViewReactor: Reactor {
    var initialState: State
    lazy var restRepository = RestRepository.shared
    
    init() {
        self.initialState = State(isSuccessLogin: false,
                                  isLoading: false)
    }
    
    enum Action {
        case login(LoginRequest)
    }
    
    enum Mutation {
        case setSuccessLogin(Bool)
        case setLoading(Bool)
        case setError(Error)
        case non
    }
    
    struct State {
        var isSuccessLogin: Bool
        var isLoading: Bool
        var errorMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .login(loginRequest):
                return Observable.concat([
                    .just(Mutation.setLoading(true)),
                     validate(.login(loginRequest)),
                    restRepository.login(LoginRequest(email: loginRequest.email, pw: loginRequest.pw))
                        .asObservable()
                        .map { Mutation.setSuccessLogin(true) },
                    .just(Mutation.setLoading(false)),
                ]).catchError{ .just(Mutation.setError($0)) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.errorMessage = nil
        switch mutation {
            case let .setSuccessLogin(isSuccessLogin):
                state.isSuccessLogin = isSuccessLogin
            case let .setLoading(isLoading):
                state.isLoading = isLoading
            case let .setError(error):
                if let error = error as? LimeError,
                   case let .error(message, _, _) = error {
                    state.errorMessage = message
                } else {
                    state.errorMessage = "알수없는 오류가 발생했습니다."
                }
                state.isLoading = false
                state.isSuccessLogin = false
            case .non: break
        }
        return state
    }
}

extension LoginViewReactor {
    private func validate(_ action: Action) -> Observable<Mutation> {
        switch action {
            case let .login(loginRequest):
                if(loginRequest.email.isEmpty) {
                    return .error(LimeError.error(message: "아이디를 입력해 주세요."))
                } else if(loginRequest.pw.isEmpty) {
                    return .error(LimeError.error(message: "비밀번호를 입력해 주세요."))
                }
        }
        return Observable.just(Void()).map{ Mutation.non }
    }
}


