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

class LoginViewController: LIME_iOS.ViewController, View, UIGestureRecognizerDelegate {
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
    
    //MARK: Email Input UI
    lazy var emailBox = CardView().then {
        $0.cornerRadius = 5.0
        $0.borderWidth = 1
        $0.borderColor = .systemGray4
        $0.backgroundColor = .none
    }
    
    lazy var emailIcon = UIImageView().then {
        $0.tintColor = .systemGray4
        $0.image = UIImage(systemName: "person.circle.fill")
    }
    
    lazy var emailField = UITextField().then {
        $0.keyboardType = .emailAddress
        $0.placeholder = "이메일을 입력 해 주세요"
        $0.font = .systemFont(ofSize: 14)
    }

    
    //MARK: Pw Input UI
    lazy var pwBox = CardView().then {
        $0.cornerRadius = 5.0
        $0.borderWidth = 1
        $0.borderColor = .systemGray4
        $0.backgroundColor = .none
    }

    lazy var pwIcon = UIImageView().then {
        $0.tintColor = .systemGray4
        $0.image = UIImage(systemName: "lock.circle.fill")
    }
    
    lazy var pwField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.placeholder = "비밀번호를 입력 해 주세요"
        $0.font = .systemFont(ofSize: 14)
    }
        
    lazy var loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5.0
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    
    private func eamilInputViewConstraintSettings() {
        view.addSubview(emailBox)
        emailBox.addSubview(emailIcon)
        emailBox.addSubview(emailField)
        
        emailBox.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        emailIcon.snp.makeConstraints {
            $0.height.equalTo(emailBox).inset(10)
            $0.width.equalTo(emailBox.snp.height).inset(10)
            $0.centerY.equalTo(emailBox)
            $0.left.equalTo(emailBox).inset(10)
        }
        
        emailField.snp.makeConstraints {
            $0.height.equalTo(emailBox)
            $0.left.equalTo(emailIcon.snp.right).offset(10)
            $0.right.equalTo(emailBox.snp.right)
        }
        
        
    }
    
    private func pwInputViewConstraintSettings() {
        view.addSubview(pwBox)
        pwBox.addSubview(pwIcon)
        pwBox.addSubview(pwField)
        
        pwBox.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(emailBox.snp.bottom).offset(10)
        }
        
        pwIcon.snp.makeConstraints {
            $0.height.equalTo(pwBox).inset(10)
            $0.width.equalTo(pwBox.snp.height).inset(10)
            $0.centerY.equalTo(pwBox)
            $0.left.equalTo(pwBox).inset(10)
        }
        
        pwField.snp.makeConstraints {
            $0.height.equalTo(pwBox)
            $0.left.equalTo(pwIcon.snp.right).offset(10)
            $0.right.equalTo(pwBox.snp.right)
        }
        
    }
    
    private func loginBtnConstraintSettings() {
        view.addSubview(loginBtn)
        
        loginBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(pwBox.snp.bottom).offset(20)
            $0.left.equalTo(pwBox)
            $0.right.equalTo(pwBox)
        }
    }
    
    private func navigationBarSettings() {
        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(onTapBackButton))

        self.navigationController?.navigationBar.sizeToFit()
        
        navigationItem.titleView = UILabel().then {
            $0.text = "로그인"
            $0.font = .boldSystemFont(ofSize: 14)
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: - receive events from UI
    
    @objc
    func onTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK: - Rout to Another VC
    
    private func routeToHomeView(){
        self.present(UINavigationController(rootViewController: HomeViewController()), animated: false)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eamilInputViewConstraintSettings()
        pwInputViewConstraintSettings()
        loginBtnConstraintSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSettings()
    }
    
    //MARK: - Binding Data
    func bind(reactor: LoginViewReactor) {
        reactor.state.map { $0.isSuccessLogin }
            .filter{ $0 }
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.routeToHomeView()
            }.disposed(by: disposeBag)
        
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
        
        // Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Binding UI
    override func bind() {
        loginBtn.rx.tap
            .map { .login(self.emailField.text ?? "",
                          self.pwField.text ?? "") }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}
