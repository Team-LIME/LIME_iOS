//
//  HomeViewReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import ReactorKit
import RxSwift
import RxCocoa

class HomeViewReactor: Reactor {
    var initialState: State
    
    init() {
        self.initialState = State(isLoading: false)
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(Error)
        case non
    }
    
    struct State {
        var isLoading: Bool
        var errorMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.errorMessage = nil
        switch mutation {
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
                //TODO:- change another state to Failed
            case .non: break
        }
        return state
    }
}



