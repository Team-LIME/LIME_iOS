//
//  RxApolloError.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Apollo

struct RxApolloError: Error {
    var errors: [GraphQLError]?
}
