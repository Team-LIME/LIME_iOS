//
//  RegisterResponse.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation

class RegisterResponse: Decodable {
    var email: String?
    var pw: String?
    var name: String?
    var intro: String?
    var generation: String?
    var type: String?
    
    enum Key : String, CodingKey{
        case email
        case pw
        case name
        case intro
        case generation
        case type
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: Key.self)
        
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.pw = try container.decodeIfPresent(String.self, forKey: .pw)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.intro = try container.decodeIfPresent(String.self, forKey: .intro)
        self.generation = try container.decodeIfPresent(String.self, forKey: .generation)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}
