//
//  LoginResponse.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation

class LoginResponse: Decodable {
    var token: String?
    
    enum Key : String, CodingKey{
        case token = "x-access-token"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: Key.self)
        
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
    }
}

extension LoginResponse {
    func toEntity() -> TokenEntity? {
        return (self.token == nil) ? nil : TokenEntity(token: self.token!)
    }
}
