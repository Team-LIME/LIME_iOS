//
//  Rx+Apollo.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Foundation
import Apollo
import RxSwift

public enum ApolloError: Error {
  case graphQLErrors([GraphQLError])
}

extension RxSwift.Reactive where Base: Apollo.ApolloClient {
    
    public func fetch<Query: GraphQLQuery>(query: Query,
                                           cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                           contextIdentifier: UUID? = nil,
                                           queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return Observable<Query.Data>.create { observer in
            base.fetch(query: query,
                       cachePolicy: cachePolicy,
                       contextIdentifier: contextIdentifier,
                       queue: queue) { response in
                switch response {
                    case let .success(graphQLResponse):
                        if let errors = graphQLResponse.errors {
                            observer.onError(ApolloError.graphQLErrors(errors))
                        } else if let data = graphQLResponse.data {
                            observer.onNext(data)
                        } else {
                            observer.onCompleted()
                        }
                    case let .failure(error):
                        observer.onError(error)
                }
                
            }
            
            return Disposables.create()
        }
    }
}

/// Extend ApolloClient with `rx` proxy.
extension Apollo.ApolloClient: ReactiveCompatible { }
