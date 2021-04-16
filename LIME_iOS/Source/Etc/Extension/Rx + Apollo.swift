//
//  Rx + Apollo.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Foundation
import Apollo
import RxSwift

extension RxSwift.Reactive where Base: ApolloClient {
    
    public func fetch<Query: GraphQLQuery>(query: Query,
                                           cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                           contextIdentifier: UUID? = nil,
                                           queue: DispatchQueue = DispatchQueue.main) -> Observable<GraphQLResult<Query.Data>> {
        return Observable<GraphQLResult<Query.Data>>.create { observer in
            base.fetch(query: query,
                       cachePolicy: cachePolicy,
                       contextIdentifier: contextIdentifier,
                       queue: queue) { response in
                switch response {
                    case .success(let data):
                        observer.onNext(data)
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
}

/// Extend ApolloClient with `rx` proxy.
extension ApolloClient: ReactiveCompatible { }
