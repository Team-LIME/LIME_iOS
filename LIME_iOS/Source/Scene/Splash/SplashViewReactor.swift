//
//  SplashViewReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import ReactorKit
import RxSwift
import RxCocoa

class SplashViewReactor: Reactor {
    var initialState: State
    
    lazy var restRepository = RestRepository.shared
    
    init() {
        self.initialState = State(isTokenActive: false,
                                  isLoading: false)
        
    }
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setIsTokenActive(Bool)
        case setLoading(Bool)
        case setError(Error)
        case non
    }
    
    struct State {
        var isTokenActive: Bool
        var isLoading: Bool
        var errorMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .refresh:
                return Observable.concat([
                    .just(Mutation.setLoading(true)),
                    restRepository.fetchTokenStatus()
                        .asObservable()
                        .map { Mutation.setIsTokenActive($0) },
                    .just(Mutation.setLoading(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.errorMessage = nil
        switch mutation {
            case let .setIsTokenActive(isTokenActive):
                state.isTokenActive = isTokenActive
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
                state.isTokenActive = false
            case .non: break
        }
        return state
    }
}



