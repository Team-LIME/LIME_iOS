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
    
    lazy var restRepository = RestRepository.shared
    
    init() {
        self.initialState = State(isSuccessRegister: false,
                                  isLoading: false)
    }
    
    enum Action {
        case register(_ email: String, _ pw: String,
                      _ name: String, _ intro: String,
                      _ generation: String, _ type: UserTypeEnum)
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
                    validate(.register(email, pw, name, intro, generation, type)),
                    restRepository.register(RegisterRequest(email: email,
                                                            pw: pw,
                                                            name: name,
                                                            intro: intro,
                                                            generation: Int(generation) ?? 0,
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

extension RegisterViewReactor {
    private func validate(_ action: Action) -> Observable<Mutation> {
        switch action {
            case let .register(email, pw, name, intro, generation, _):
                if(email.isEmpty) {
                    return .error(LimeError.error(message: "아이디를 입력해 주세요."))
                } else if(pw.isEmpty) {
                    return .error(LimeError.error(message: "비밀번호를 입력해 주세요."))
                } else if(name.isEmpty) {
                    return .error(LimeError.error(message: "이름을 입력해 주세요."))
                } else if(intro.isEmpty) {
                    return .error(LimeError.error(message: "한줄소개를 입력해 주세요."))
                } else if(generation.isEmpty) {
                    return .error(LimeError.error(message: "기수를 입력해 주세요."))
                } else if(generation.isValidNmber()) {
                    return .error(LimeError.error(message: "올바른 기수를 입력해 주세요."))
                }
        }
        return Observable.just(Void()).map{ Mutation.non }
    }
}
