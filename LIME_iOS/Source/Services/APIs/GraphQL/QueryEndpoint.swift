//
//  QueryEndpoint.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/16.
//

import Foundation

enum QueryEndpoint {
    case REPOSITORY
    case USER
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
            case QueryEndpoint.REPOSITORY.rawValue: self = .REPOSITORY
            case QueryEndpoint.USER.rawValue: self = .USER
            default: fatalError("QueryEndpoint rawValue is nil")
        }
    }
    
    var rawValue: String {
        switch self {
            case .REPOSITORY:
                return ""
//                return String(describing: SearchRepoQuery.Data.Search.self).lowercased()
            case .USER:
                return ""
//                return String(describing: SearchRepoQuery.Data.User.self).lowercased()
        }
    }
}
