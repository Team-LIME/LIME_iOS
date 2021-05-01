//
//  WelcomeViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import UIKit
import Then
import SnapKit

class WelcomeViewController: LIME_iOS.ViewController {
    
    //MARK: - UI
    
    lazy var registerBtn = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .none
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (onClickRegisterBtn)))
    }
    
    lazy var loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5.0
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (onClickLoginBtn)))
    }
    
    //MARK: - receive events from UI
    
    @objc
    func onClickLoginBtn() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc
    func onClickRegisterBtn() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    // MARK: - View lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        
        registerBtn.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        loginBtn.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.right.equalTo(registerBtn)
            $0.left.equalTo(registerBtn)
            $0.bottom.equalTo(registerBtn.snp.top).offset(-10)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
