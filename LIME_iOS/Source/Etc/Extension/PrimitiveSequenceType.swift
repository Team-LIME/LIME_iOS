//
//  PrimitiveSequenceType.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import Foundation
import RxSwift

extension PrimitiveSequenceType where Trait == SingleTrait {
    public func withUnretained<Object: AnyObject, Out>(_ obj: Object, resultSelector: @escaping (Object, Element) -> Out) -> Single<Out> {
        map { [weak obj] element -> Out in
            guard let obj = obj else { throw LimeError.error(message: "알 수 없는 오류 발생", keys: [.unhandled, .basic]) }
            return resultSelector(obj, element)
        }
    }
    
    public func withUnretained<Object: AnyObject>(_ obj: Object) -> Single<(Object, Element)> {
        return withUnretained(obj) { ($0, $1) }
    }
}
