//
//  ViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import UIKit
import RxSwift
import Lottie

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    private var loadingView = AnimationView().then {
        $0.animation = Animation.named("LottieLogo1", subdirectory: "Resource/Lottie")
        $0.contentMode = .scaleAspectFit
    }
    
    private var backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.5
    }
    
    func startLoading() {
        view.bringSubviewToFront(backgroundView)
        view.bringSubviewToFront(loadingView)
        loadingViewConstraintSettings()
        
        backgroundView.isHidden = false
        loadingView.isHidden = false
        loadingView.play()
    }
    
    func stopLoading() {
        backgroundView.isHidden = true
        loadingView.isHidden = true
        loadingView.stop()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        view.addSubview(backgroundView)
        view.addSubview(loadingView)
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSettings()
    }
    
    private func navigationBarSettings(){
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }

    
    func bind() { }
    
    private func loadingViewConstraintSettings() {
        loadingView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
            $0.center.equalTo(view.center)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
