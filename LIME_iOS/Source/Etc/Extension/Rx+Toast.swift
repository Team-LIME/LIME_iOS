//
//  Rx+Toast.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/22.
//

import Foundation
import Toast
import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UIView {
    public var toastMessage: Binder<String?> {
        return Binder(self.base) { base, message in
            base.makeToast(message, duration: 0.5, position: .top)
        }
    }
}
