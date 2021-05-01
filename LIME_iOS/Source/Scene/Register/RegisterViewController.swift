//
//  RegisterViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import UIKit
import Then
import SnapKit
import ReactorKit

class RegisterViewController: LIME_iOS.ViewController, View {
    typealias Reactor = RegisterViewReactor
    
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
        reactor = RegisterViewReactor()
    }
        
    //MARK: - UI
    
    lazy var emailField = UITextField().then {
        $0.keyboardType = .emailAddress
    }
    
    lazy var pwField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.keyboardType = .alphabet
    }
    
    lazy var nameField = UITextField().then {
        $0.keyboardType = .default
    }
    
    lazy var introField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.keyboardType = .default
    }
    
    lazy var generationField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.textContentType = .telephoneNumber
        $0.keyboardType = .numberPad
    }
  
    //TODO: Type RadioButton 생성 (학생 / 교사)
//    lazy var typeField = UITextField().then {
//
//    }
    
    lazy var registerButton = UIButton().then {
        $0.backgroundColor = .red
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Binding Data
    func bind(reactor: RegisterViewReactor) {
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
        
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Binding UI
    override func bind() {
        registerButton.rx.tap
            .map {.register(self.emailField.text ?? "",
                            self.pwField.text ?? "",
                            self.nameField.text ?? "",
                            self.introField.text ?? "",
                            self.generationField.text ?? "",
                            .student)
                //TODO: Type처리
            }.bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}
