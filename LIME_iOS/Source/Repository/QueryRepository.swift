//
//  QueryRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import RxSwift
import Foundation
import ReactorKit
import Apollo

class QueryRepository: GraphQLRepository {
    
    func fetchUsersViewData() -> Observable<UsersQuery.Data> {
        return apolloClient.rx.fetch(query: UsersQuery())
    }
    
    func fetchChatRoomsViewData() -> Observable<ChatRoomsQuery.Data> {
        return apolloClient.rx.fetch(query: ChatRoomsQuery())
    }
}
