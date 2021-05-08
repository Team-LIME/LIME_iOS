//
//  UsersViewReactor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/06.
//

import Foundation
import ReactorKit
import RxSwift

class UsersViewReactor: Reactor {
    var initialState: State
    var queryRepository: QueryRepository
    
    init() {
        self.initialState = State(sections: [],
                                  isLoading: false)
        self.queryRepository = QueryRepository()
    }
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setResponse(UsersQuery.Data.GetMyProfile, [UsersQuery.Data.GetOtherUser])
        case setLoading(Bool)
        case setError(Error)
        case non
    }
    
    struct State {
        var sections: [UsersViewSection]
        var isLoading: Bool
        var errorMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .refresh:
                return queryRepository.fetchUsersViewData()
                    .map { res in
                        guard let myProfile = res.getMyProfile else { return .setError(LimeError.error(message: "내 정보조회 실패")) }
                        guard let otherProfiles = res.getOtherUsers else { return .setError(LimeError.error(message: "유저 정보조회 실패")) }
                        
                        return .setResponse(myProfile, otherProfiles)
                    }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.errorMessage = nil
        switch mutation {
        case let .setResponse(myProfile, otherProfiles):
            
            let myProfileItem = [ShotViewSectionItem.myProfile(UsersViewMyProfileCellReactor(myProfile: myProfile))]
            let otherProfileItems = otherProfiles.map { ShotViewSectionItem.otherProfile(UsersViewOtherProfileCellReactor(otherProfile: $0)) }
            
            state.sections = [UsersViewSection.myProfile(myProfileItem),
                              UsersViewSection.otherProfile(otherProfileItems)]
            
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
            state.sections = []
        case .non: break
        }
        return state
    }
}
