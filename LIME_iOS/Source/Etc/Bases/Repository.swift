//
//  RestRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/07.
//

import Foundation
import Moya
import Apollo

class RestRepository <AP: LIME_iOS.TargetType, LO: LIME_iOS.Local> {
    lazy var provider = MoyaProvider<AP>(plugins: [NetworkLoggerPlugin()])
    lazy var local = LO()
    lazy var decoder = JSONDecoder()
}

class GraphQLRepository {
    lazy var apolloClient = ApolloNetworkManager.apolloClient
    let decoder = JSONDecoder()
}

