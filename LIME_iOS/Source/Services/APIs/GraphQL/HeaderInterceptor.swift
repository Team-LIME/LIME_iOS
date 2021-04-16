//
//  HeaderInterceptor.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Foundation
import Apollo

class HeaderInterceptor : ApolloInterceptor {
    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
        
        request.addHeader(name: "x-access-token", value: "")
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
        
    }
}
