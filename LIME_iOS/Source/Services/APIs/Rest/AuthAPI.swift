//
//  AuthAPI.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation
import Moya

enum AuthAPI {
    case postLogin(_ request: LoginRequest)
    case postRegister(_ request: RegisterRequest)
}

extension AuthAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.REST_DEFAULT_URL+"auth")!
    }
    
    var path: String {
        switch self {
        case .postLogin:
            return "/login"
        case .postRegister:
            return "/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin:
            return .post
        case .postRegister:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .postLogin(request):
            return .requestData(try! JSONEncoder().encode(request))
        case let .postRegister(request):
            return .requestData(try! JSONEncoder().encode(request))
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
