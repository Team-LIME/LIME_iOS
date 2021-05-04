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

class SplashViewController: LIME_iOS.UIViewController, View {
    typealias Reactor = SplashViewReactor
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    //MARK: - Setup
    
    private func setup(){
        reactor = SplashViewReactor()
    }
        
    
    //MARK: - UI
    
    
    //MARK: - Rout to Another VC
    
    private func routeToWelcomeView() {
        DispatchQueue.main.async {
            let destinationVC = UINavigationController(rootViewController: WelcomeViewController()).then {
                $0.modalPresentationStyle = .fullScreen
            }
            self.present(destinationVC, animated: false)
        }
    }
    
    private func routeToHomeView() {
        DispatchQueue.main.async {
            let destinationVC = UINavigationController(rootViewController: HomeViewController()).then {
                $0.modalPresentationStyle = .fullScreen
            }
            self.present(destinationVC, animated: false)
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just(.refresh)
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    
    //MARK: - Binding Data
    
    func bind(reactor: SplashViewReactor) {
        //Output
        reactor.state.map { $0.isTokenActive }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isTokenActive in
                guard let self = self else { return }
                
                if(isTokenActive) {
                    self.routeToHomeView()
                }else{
                    self.routeToWelcomeView()
                }
                
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                if value {
                    self.startLoading()
                }else {
                    self.stopLoading()
                }
            }).disposed(by: disposeBag)
        
        //Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
}
