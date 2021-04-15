//
//  UserRepository.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation
import RxSwift

protocol UserRepository {
    func fetchUserList()
    func fetchMyProfile()
    func fetchUserProfileByEmail(_ email: String)
}