//
//  HomeViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//

import UIKit
import Then
import SnapKit
import ReactorKit

class HomeViewController: LIME_iOS.UIViewController, View {
    typealias Reactor = HomeViewReactor
    
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
        reactor = HomeViewReactor()
    }
        
    
    //MARK: - UI
    
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Binding Data
    func bind(reactor: HomeViewReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                //TODO: -로딩처리
            }).disposed(by: disposeBag)
        
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
}
