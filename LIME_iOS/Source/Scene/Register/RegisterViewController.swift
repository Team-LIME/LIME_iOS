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

class RegisterViewController: RegisterInputViewController<UserTypeEnum>, View {
    typealias Reactor = RegisterViewReactor
    
    // MARK: - properties
    
    lazy var emailInputViewController = RegisterInputViewController<String>(inputType: .email,
                                                                            onClickButtonEvent: { email in
                                                                                self.email = email ?? ""
                                                                                self.routeToPwInputView()
                                                                            })

    lazy var pwInputViewController = RegisterInputViewController<String>(inputType: .pw,
                                                                         onClickButtonEvent: { pw in
                                                                            self.pw = pw ?? ""
                                                                            self.routeToNameInputView()
                                                                         })

    lazy var nameInputViewController = RegisterInputViewController<String>(inputType: .name,
                                                                           onClickButtonEvent: { name in
                                                                            self.name = name ?? ""
                                                                            self.routeToIntroInputView()
                                                                           })

    lazy var introInputViewController = RegisterInputViewController<String>(inputType: .intro,
                                                                            onClickButtonEvent: { intro in
                                                                                self.intro = intro ?? ""
                                                                                if self.type == .teacher {
                                                                                    self.registerRequest()
                                                                                }else {
                                                                                    self.routeToGenerationInputView()
                                                                                }
                                                                            })

    lazy var generationInputViewController = RegisterInputViewController<Int>(inputType: .generation,
                                                                              onClickButtonEvent: { generation in
                                                                                self.generation = generation ?? 0
                                                                                self.registerRequest()
                                                                              })
    
    //MARK: - Propertiess
    var email: String = ""
    var pw: String = ""
    var name: String = ""
    var intro: String = ""
    var generation: Int = 0
    var type: UserTypeEnum = .student
    
    // MARK: - Object lifecycle
    
    init() {
        super.init(inputType: .type) { _ in }
        reactor = RegisterViewReactor()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Rout to Another VC
    
    func routeToEmailInputView(){
        self.navigationController?.pushViewController(emailInputViewController, animated: true)
    }

    func routeToPwInputView(){
        self.navigationController?.pushViewController(pwInputViewController, animated: true)
    }

    func routeToNameInputView(){
        self.navigationController?.pushViewController(nameInputViewController, animated: true)
    }

    func routeToIntroInputView(){
        self.navigationController?.pushViewController(introInputViewController, animated: true)
    }

    func routeToGenerationInputView(){
        self.navigationController?.pushViewController(generationInputViewController, animated: true)
    }
    
    func registerRequest(){
        Observable.just(.register(email: self.email,
                                  pw: self.pw,
                                  name: self.name,
                                  intro: self.intro,
                                  generation: self.generation,
                                  type: self.type))
            .bind(to: self.reactor!.action)
            .disposed(by: self.disposeBag)
    }
    
    func successRegister(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "회원가입에 성공했습니다.", message: "로그인 페이지로 이동합니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOnClickButtonEvent(onClickButton: { type in
            self.type = type ?? .student
            self.routeToEmailInputView()
        })
    }
    
    //MARK: - Binding Data
    
    func bind(reactor: RegisterViewReactor) {
        //Output
        let isLoading = reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .share()
            
        isLoading
            .bind(to: self.generationInputViewController.rx.isLoading)
            .disposed(by: disposeBag)
        
        isLoading
            .bind(to: self.introInputViewController.rx.isLoading)
            .disposed(by: disposeBag)
        
        
        reactor.state.map { $0.isSuccessRegister }
            .filter{ $0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.successRegister()
            })
            .disposed(by: disposeBag)
        
        
        //Error
        let error = reactor.state.map{ $0.errorMessage }
            .share()
            
        error
            .bind(to: self.generationInputViewController.view.rx.toastMessage)
            .disposed(by: disposeBag)
        
        error
            .bind(to: self.introInputViewController.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
    
}
