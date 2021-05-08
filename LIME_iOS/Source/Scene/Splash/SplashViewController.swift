//
//  SplashViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import UIKit
import Then
import SnapKit
import ReactorKit
import RxCocoa
import RxViewController

class SplashViewController: LIME_iOS.UIViewController, View {
    typealias Reactor = SplashViewReactor
    
    // MARK: - Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.reactor = SplashViewReactor(authRepository: AuthRepository())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Rout to Another VC
    
    fileprivate func routeToWelcomeView() {
        DispatchQueue.main.async {
            let destinationVC = UINavigationController(rootViewController: WelcomeViewController()).then {
                $0.modalPresentationStyle = .fullScreen
            }
            self.present(destinationVC, animated: false)
        }
    }
    
    fileprivate func routeToHomeView() {
        DispatchQueue.main.async {
            let destinationVC = HomeViewController().then {
                $0.modalPresentationStyle = .fullScreen
            }
            self.present(destinationVC, animated: false)
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Binding
    
    func bind(reactor: SplashViewReactor) {
        //Input
        self.rx.viewDidLoad
            .map { .refresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        //Output
        reactor.state.map { $0.isTokenActive }
            .distinctUntilChanged()
            .bind(to: self.rx.isTokenActive)
            .disposed(by: self.disposeBag)

        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.isLoading)
            .disposed(by: self.disposeBag)

        //Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: self.disposeBag)
    }
    
}


import RxSwift
import RxCocoa

extension Reactive where Base: SplashViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    internal var isTokenActive: Binder<Bool> {
        return Binder(self.base) { viewcontroller, active in
            if active {
                viewcontroller.routeToHomeView()
            } else {
                viewcontroller.routeToWelcomeView()
            }
        }
    }
    
}
