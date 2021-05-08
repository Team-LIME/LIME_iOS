//
//  RegisterViewReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import ReactorKit
import RxSwift
import RxCocoa

class RegisterViewReactor: Reactor {
    var initialState: State
    
    var authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        self.initialState = State(isSuccessRegister: false,
                                  isLoading: false)
    }
    
    enum Action {
        case register(email: String, pw: String,
                      name: String, intro: String,
                      generation: Int, type: UserTypeEnum)
    }
    
    enum Mutation {
        case setSuccessRegister(Bool)
        case setLoading(Bool)
        case setError(Error)
        case non
    }
    
    struct State {
        var isSuccessRegister: Bool
        var isLoading: Bool
        var errorMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .register(email, pw, name, intro, generation, type):
                return Observable.concat([
                    .just(Mutation.setLoading(true)),
                    authRepository.register(RegisterRequest(email: email,
                                                            pw: pw,
                                                            name: name,
                                                            intro: intro,
                                                            generation: generation,
                                                            type: type))
                        .asObservable()
                        .map { Mutation.setSuccessRegister(true) },
                    .just(Mutation.setLoading(false)),
                ]).catchError{ .just(Mutation.setError($0)) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.errorMessage = nil
        switch mutation {
            case .setSuccessRegister(let isSuccessRegister):
                state.isSuccessRegister = isSuccessRegister
            case let .setLoading(isLoading):
                state.isLoading = isLoading
            case let .setError(error):
                if let error = error as? LimeError,
                   case let .error(message, _, _) = error {
                    state.errorMessage = message
                } else {
                    state.errorMessage = "알수없는 오류가 발생했습니다 : \(error.localizedDescription)"
                }
                state.isLoading = false
                state.isSuccessRegister = false
            case .non: break
        }
        return state
    }
}
