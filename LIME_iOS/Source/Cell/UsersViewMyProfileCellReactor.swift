//
//  UsersViewMyProfileCellReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/08.
//

import Foundation
import ReactorKit
import RxSwift

class UsersViewMyProfileCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        let myProfile: UsersQuery.Data.GetMyProfile
    }

    let initialState: State

    init(myProfile: UsersQuery.Data.GetMyProfile) {
      self.initialState = State(myProfile: myProfile)
      _ = self.state
    }
}
