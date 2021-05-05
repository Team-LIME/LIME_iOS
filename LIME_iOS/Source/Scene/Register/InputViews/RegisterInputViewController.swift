//
//  RegisterInputViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/03.
//

import UIKit
import RxCocoa
import RxSwift

enum RegisterInputType {
    case type
    case email
    case pw
    case name
    case intro
    case generation
}

class RegisterInputViewController<T>: LIME_iOS.UIViewController, UIGestureRecognizerDelegate {
    fileprivate struct Constant {
        var inputType: RegisterInputType
        var title: String
        var buttonTitle: String
        var placeHolder: String?
        var keyboardType: UIKeyboardType
        var textContentType: UITextContentType
        var isSecureTextEntry: Bool
    }
    
    //MARK: - Object lifecycle
    init(inputType: RegisterInputType, onClickButtonEvent: @escaping (T?) -> Void) {
        
        switch inputType {
            case .type:
                self.constant = Constant(inputType: .type,
                                         title: "직업",
                                         buttonTitle: "다음",
                                         placeHolder: nil,
                                         keyboardType: .default,
                                         textContentType: .username,
                                         isSecureTextEntry: false)
            case .email:
                self.constant = Constant(inputType: .email,
                                         title: "이메일",
                                         buttonTitle: "다음",
                                         placeHolder: "이메일을 입력해 주세요",
                                         keyboardType: .emailAddress,
                                         textContentType: .emailAddress,
                                         isSecureTextEntry: false)
                
            case .pw:
                self.constant = Constant(inputType: .pw,
                                         title: "비밀번호",
                                         buttonTitle: "다음",
                                         placeHolder: "비밀번호를 입력해 주세요",
                                         keyboardType: .alphabet,
                                         textContentType: .newPassword,
                                         isSecureTextEntry: true)
                
            case .name:
                self.constant = Constant(inputType: .name,
                                         title: "이름",
                                         buttonTitle: "다음",
                                         placeHolder: "이름을 입력해 주세요",
                                         keyboardType: .default,
                                         textContentType: .name,
                                         isSecureTextEntry: false)
                
            case .intro:
                self.constant = Constant(inputType: .intro,
                                         title: "한줄소개",
                                         buttonTitle: "다음",
                                         placeHolder: "한줄소개를 입력해 주세요",
                                         keyboardType: .default,
                                         textContentType: .username,
                                         isSecureTextEntry: false)
                
            case .generation:
                self.constant = Constant(inputType: .generation,
                                         title: "기수",
                                         buttonTitle: "가입",
                                         placeHolder: "기수를 입력해 주세요",
                                         keyboardType: .numberPad,
                                         textContentType: .telephoneNumber,
                                         isSecureTextEntry: false)
        }
        
        self.onClickButton = onClickButtonEvent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initOnClickButtonEvent(onClickButton: @escaping (T?) -> Void) {
        self.onClickButton = onClickButton
    }
    
    // MARK: - Properties
    
    fileprivate var constant: Constant
    fileprivate var onClickButton: (T?) -> Void
    
    //MARK: - UI
    
    lazy var inputTextField = UITextField().then {
        $0.placeholder = constant.placeHolder
        $0.textContentType = constant.textContentType
        $0.keyboardType = constant.keyboardType
        $0.font = .boldSystemFont(ofSize: 24)
        $0.isSecureTextEntry = constant.isSecureTextEntry
    }
    lazy var titleLabel = UILabel().then {
        $0.text = constant.title
        $0.font = .systemFont(ofSize: 14)
    }
    lazy var nextButton = UIButton().then {
        $0.setTitle(constant.buttonTitle, for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5
    }
    lazy var radioButtonView = UIStackView().then {
        $0.axis = .horizontal
    }
    lazy var studentRadioButton = RadioButton().then {
        $0.setTitle("학생", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .none
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.borderColor = UIColor.systemGray.cgColor
    }
    lazy var teacherRadioButton = RadioButton().then {
        $0.setTitle("교사", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .none
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    private func initializationDialogButton(type: UserTypeEnum) {
        studentRadioButton.alternateButton = [teacherRadioButton]
        teacherRadioButton.alternateButton = [studentRadioButton]
        
        switch type {
            case UserTypeEnum.student:
                studentRadioButton.isSelected = true
                teacherRadioButton.isSelected = false
            case UserTypeEnum.teacher:
                studentRadioButton.isSelected = false
                teacherRadioButton.isSelected = true
            case UserTypeEnum.__unknown: break
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(nextButton)
        
        if case .type = constant.inputType {
            self.view.addSubview(radioButtonView)
            
            radioButtonView.addArrangedSubview(studentRadioButton)
            radioButtonView.addArrangedSubview(teacherRadioButton)
            
            initializationDialogButton(type: UserTypeEnum.student)
        } else {
            self.view.addSubview(inputTextField)
        }
        
        addKeyboardNotification()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSettings(self, nil, true)
        inputTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //Nothing
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
        
        if case .type = constant.inputType {
            radioButtonView.snp.makeConstraints {
                $0.left.equalTo(titleLabel.snp.left)
                $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(15)
                $0.top.equalTo(titleLabel.snp.bottom).offset(5)
                $0.height.equalTo(40)
            }
            
            studentRadioButton.snp.makeConstraints {
                $0.height.equalTo(radioButtonView)
                $0.width.equalTo(radioButtonView).multipliedBy(0.49)
            }
            
            teacherRadioButton.snp.makeConstraints {
                $0.height.equalTo(radioButtonView)
                $0.width.equalTo(radioButtonView).multipliedBy(0.49)
            }
        } else {
            inputTextField.snp.makeConstraints {
                $0.left.equalTo(titleLabel.snp.left)
                $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(15)
                $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            }
        }
    }
    
    //MARK: - Binding
    
    func bind() {
        self.nextButton.rx.tap
            .flatMapLatest { self.validateHanlding() } //유효성 검사
            .subscribe(onNext: { [weak self] isComplete in
                if (isComplete) {
                    self?.onClickButton(self?.getConvertedData())
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getConvertedData() -> T? {
        if case .type = constant.inputType {
            let isStudentPicked = studentRadioButton.isSelected
            let pickedJob = isStudentPicked ? UserTypeEnum.student : UserTypeEnum.teacher
            
            return pickedJob as? T
        } else {
            return inputTextField.text as? T
        }
    }
    
}

//MARK: - Check Empty / Validation
extension RegisterInputViewController {
    
    func validateHanlding() -> Observable<Bool> {
        return Observable.just(Void())
            .flatMap { self.checkEmpty(self.inputTextField.text ?? "") }
            .flatMap{ self.validate(self.inputTextField.text ?? "") }
            .catchError { error in
                var errorMessage:String
                
                if let error = error as? LimeError, case let .error(message, _, _) = error {
                    errorMessage = message
                } else {
                    errorMessage = "알수없는 오류가 발생했습니다 : \(error.localizedDescription)"
                }
                
                self.view.makeToast(errorMessage, duration: 0.5, position: .top)
                
                return .error(error)
            }
            .map { true }
            .catchErrorJustReturn(false)
    }
    
    private func checkEmpty(_ data: String) -> Observable<Void> {
        if(constant.inputType != .type && data.isEmpty){
            return .error(LimeError.error(message: "\(constant.title)을(를) 입력 해 주세요"))
        }
        return Observable.just(Void()).map{ Void() }
    }

    private func validate(_ data: String) -> Observable<Void> {
        switch constant.inputType {
            case .type: break
            case .name: break
            case .intro: break
            case .email:
                if (!data.isValidEmail()){
                    return .error(LimeError.error(message: "올바른 이메일을 입력 해 주세요"))
                }
            case .pw:
                if (!data.isValidPw()){
                    return .error(LimeError.error(message: "올바른 비밀번호를 입력 해 주세요"))
                }
            case .generation:
                if (!data.isValidGeneration()){
                    return .error(LimeError.error(message: "올바른 기수를 입력 해 주세요"))
                }
        }
        return Observable.just(Void()).map{ Void() }
    }
}


//MARK: - Keyboard Show/Hide Observer
extension RegisterInputViewController {
    private func addKeyboardNotification() {
        
        //MARK: keyboard Will Show Notification
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            guard let keybordFrm = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            var safeBot: CGFloat = 0
            if let uBot = UIApplication.shared.windows.first?.safeAreaInsets.bottom { safeBot = uBot }
            let newHeight: CGFloat = keybordFrm.height - safeBot
            self.nextButton.snp.removeConstraints()
            
            self.nextButton.snp.makeConstraints {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-(newHeight+10))
                $0.left.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.height.equalTo(50)
            }
            self.updateViewConstraints()
        }
        
        //MARK: keyboard Will Hide Notification
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            self.nextButton.snp.removeConstraints()
            self.nextButton.snp.makeConstraints {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.left.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.height.equalTo(50)
            }
            self.updateViewConstraints()
        }
    }
}
