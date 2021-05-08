//
//  ChatsViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/06.
//

import UIKit
import ReactorKit
import RxSwift

class ChatsViewController: LIME_iOS.UIViewController, View {
    typealias Reactor = ChatsViewReactor
    
    // MARK: - Object lifecycle
    
    init(){
        super.init(nibName: nil, bundle: nil)
        reactor = ChatsViewReactor()
        self.tabBarItem = UITabBarItem(title: "채팅",
                                       image: UIImage(systemName: "message"),
                                       selectedImage: UIImage(systemName: "message.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI
    
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupConstraints() {
        
    }
    
    //MARK: - Binding
    func bind(reactor: ChatsViewReactor) {
        //Output
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
        
        //Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
}
