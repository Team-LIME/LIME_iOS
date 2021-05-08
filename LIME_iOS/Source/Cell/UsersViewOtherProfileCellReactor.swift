//
//  UsersViewOtherProfileCellReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/08.
//

import Foundation
import ReactorKit
import RxSwift

class UsersViewOtherProfileCellReactor: Reactor {    
    typealias Action = NoAction
    
    struct State {
        let otherProfile: UsersQuery.Data.GetOtherUser
    }

    let initialState: State

    init(otherProfile: UsersQuery.Data.GetOtherUser) {
      self.initialState = State(otherProfile: otherProfile)
      _ = self.state
    }
}
