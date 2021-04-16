//
//  GraphQLRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import RxSwift
import Foundation
import ReactorKit
import Apollo

class GraphQLRepository {
    func fetchUsersViewData() -> (success: Observable<UsersQuery.Data?>, error: Observable<Void>) {
        return fetch(query: UsersQuery())
    }
    
    func fetchChatRoomsViewData() -> (success: Observable<ChatRoomsQuery.Data?>, error: Observable<Void>) {
        return fetch(query: ChatRoomsQuery())
    }
}

extension GraphQLRepository {
    func fetch<Query: GraphQLQuery>(query: Query) -> (success: Observable<Query.Data?>, error: Observable<Void>) {
        let queryEvents = NetworkManager.shared.apollo.rx.fetch(query: query).share()
        
        let success = queryEvents.flatMap { response -> Observable<Query.Data?> in
            return .just(response.data)
        }.share()
        
        let error = queryEvents.flatMap { response -> Observable<Void> in
            if (response.errors != nil) { return .error(RxApolloError(errors: response.errors)) }
            return .just(Void())
        }.share()
        
        return (success, error)
    }
    
    func graphQLErrorHandler(error: Error, _ handler: @escaping (String, QueryEndpoint) -> Void) {
        if let error = error as? RxApolloError {
            for errorbody in error.errors ?? [] {
                for path in errorbody["path"] as! [String] {
                    handler(errorbody.message ?? "", QueryEndpoint(rawValue: path))
                }
            }
        }
    }
}
