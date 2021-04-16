//
//  NetworkManager.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Foundation
import Apollo

class NetworkManager {
    static let shared = NetworkManager()
    
    private let requestURL = URL(string: Constants.GRAPHQL_DEFAULT_URL)!
    
    private(set) lazy var apollo: ApolloClient = {
          let cache = InMemoryNormalizedCache()
          let store = ApolloStore(cache: cache)
          
          let client = URLSessionClient()
          let provider = NetworkInterceptorProvider(store: store, client: client)
          let url = requestURL

          let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
          return ApolloClient(networkTransport: requestChainTransport, store: store)
      }()
}
