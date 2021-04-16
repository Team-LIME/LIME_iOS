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
    
    init() {
        self.initialState = State()
        
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        
        }
    }
}

