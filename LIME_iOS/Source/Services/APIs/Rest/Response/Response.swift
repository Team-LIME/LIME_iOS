//
//  Response.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation

class Response<T: Decodable>: Decodable {
    var message : String
    var data: T
}

class MessageResponse: Decodable {
    var message : String
}
