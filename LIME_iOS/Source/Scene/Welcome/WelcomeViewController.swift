//
//  WelcomeViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import UIKit
import Then
import SnapKit

class WelcomeViewController: LIME_iOS.UIViewController {
    
    //MARK: - UI
    
    lazy var registerBtn = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .none
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.borderColor = UIColor.systemGray.cgColor
    }
    lazy var loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5.0
    }
    
    //MARK: - route To Another VC
    
    func routeToLoginViewController() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    func routeToRegisterViewController() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }
    
    // MARK: - View lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setupConstraints() {
        registerBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        loginBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.right.equalTo(registerBtn)
            $0.left.equalTo(registerBtn)
            $0.bottom.equalTo(registerBtn.snp.top).offset(-10)
        }
    }
    
    //MARK: - Binding
    
    private func bind() {
        loginBtn.rx.tap
            .subscribe(onNext: { self.routeToLoginViewController() })
            .disposed(by: disposeBag)
        
        registerBtn.rx.tap
            .subscribe(onNext: { self.routeToRegisterViewController() })
            .disposed(by: disposeBag)
    }
    
}
