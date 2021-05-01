//
//  Rx+Moya.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/01.
//

import RxSwift
import RxCocoa
import Moya
import Alamofire
import Foundation

extension Reactive where Base: MoyaProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Moya.Response> {
        return Single.create { [weak base] single in
            
            if(!NetworkReachabilityManager(host:Constants.REST_DEFAULT_URL)!.isReachable){
                single(.error(LimeError.error(message: "서버에 접속할 수 없습니다.")))
            }
            
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                    case let .success(response):
                        single(.success(response))
                        
                    case let .failure(error):
                        let errorBody = (try? error.response?.mapJSON() as? Dictionary<String, Any>) ?? Dictionary()
                        single(.error(LimeError.error(message: errorBody["message"] as? String ?? "네트워크 오류가 발생했습니다.")))
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }.timeout(120, scheduler: MainScheduler.asyncInstance)
        .catchError {
            if let error = $0 as? RxError,
               case .timeout = error {
                return .error(LimeError.error(message: "요청시간이 만료되었습니다."))
            }
            return .error($0)
        }
    }
}
