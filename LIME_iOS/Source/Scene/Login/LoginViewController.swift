//
//  LoginViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import UIKit
import Then
import SnapKit
import ReactorKit

class LoginViewController: LIME_iOS.ViewController, View {
    typealias Reactor = LoginViewReactor
    
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
        reactor = LoginViewReactor()
    }
    
    //MARK: - UI
    
    lazy var emailField = UITextField().then {
        $0.keyboardType = .emailAddress
    }
    
    lazy var pwField = UITextField().then {
        $0.isSecureTextEntry = true
    }
    
    lazy var loginButton = UIButton().then {
        $0.backgroundColor = .red
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Binding Data
    func bind(reactor: LoginViewReactor) {
        reactor.state.map { $0.isSuccessLogin }
            .filter{ $0 }
            .bind { [weak self] _ in
                guard let self = self else { return }
                //TODO: -성공처리
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                //TODO: -로딩처리
            }).disposed(by: disposeBag)
        
        // Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Binding UI
    override func bind() {
        loginButton.rx.tap
            .map {.login(LoginRequest(email: self.emailField.text ?? "",
                                      pw: self.pwField.text ?? ""))
            }.bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}
