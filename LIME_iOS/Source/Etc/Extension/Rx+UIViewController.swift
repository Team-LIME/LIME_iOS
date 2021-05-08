//
//  Rx+UIViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/03.
//

import RxSwift
import RxCocoa

extension Reactive where Base: LIME_iOS.UIViewController {

    internal var isLoading: Binder<Bool> {
        return Binder(self.base) { viewcontroller, active in
            if active {
                viewcontroller.startLoading()
            } else {
                viewcontroller.stopLoading()
            }
        }
    }

}
