//
//  ApolloManager.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/07.
//

import Foundation
import Apollo

class ApolloNetworkManager {
    static var apolloClient:ApolloClient {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = URL(string: Constants.GRAPHQL_DEFAULT_URL)!
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }
}
