//
//  Rx+UIImageView.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/09.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    var imageURL: Binder<String?> {
        Binder(self.base) { base, url in
            base.downloadImage(from: url)
        }
    }
    
    var profileImageURL: Binder<String?> {
        Binder(self.base) { base, url in
            base.downloadProfileImage(from: url)
        }
    }
}

