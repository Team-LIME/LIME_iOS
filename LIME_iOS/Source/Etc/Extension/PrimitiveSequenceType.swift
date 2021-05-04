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

extension ObservableType {
    /**
     Provides an unretained, safe to use (i.e. not implicitly unwrapped), reference to an object along with the events emitted by the sequence.
     
     In the case the provided object cannot be retained successfully, the seqeunce will complete.
     
     - note: Be careful when using this operator in a sequence that has a buffer or replay, for example `share(replay: 1)`, as the sharing buffer will also include the provided object, which could potentially cause a retain cycle.
     
     - parameter obj: The object to provide an unretained reference on.
     - parameter resultSelector: A function to combine the unretained referenced on `obj` and the value of the observable sequence.
     - returns: An observable sequence that contains the result of `resultSelector` being called with an unretained reference on `obj` and the values of the original sequence.
     */
    public func withUnretained<Object: AnyObject, Out>( _ obj: Object, resultSelector: @escaping (Object, Element) -> Out) -> Observable<Out> {
        map { [weak obj] element -> Out in
            guard let obj = obj else { throw LimeError.error(message: "알 수 없는 오류 발생", keys: [.unhandled, .basic]) }
            return resultSelector(obj, element)
        }
    }
    
    public func withUnretained<Object: AnyObject>(_ obj: Object) -> Observable<(Object, Element)> {
        return withUnretained(obj) { ($0, $1) }
    }
}
