//
//  Constants.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation

struct Constants {
    
    static let REST_DEFAULT_URL = "\(SERVER_IP):\(SERVER_PORT)/api/\(SERVER_VERSION)/"
    static let GRAPHQL_DEFAULT_URL = "\(SERVER_IP):\(SERVER_PORT)/graphql"
    
    
    static let SERVER_IP = "http://10.80.163.135"
    static let SERVER_PORT = "3000"
    static let SERVER_VERSION = "v1"
}
