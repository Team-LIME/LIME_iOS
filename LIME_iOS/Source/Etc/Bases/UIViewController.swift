//
//  ViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/15.
//

import UIKit
import RxSwift
import Lottie

class UIViewController: UIKit.UIViewController {
    
    //MARK: Properties
    var disposeBag = DisposeBag()
    
    
    //MARK: - Loading
    
    private var loadingView = AnimationView().then {
        $0.animation = Animation.named("Loading", subdirectory: "Resource/Lottie")
        $0.contentMode = .scaleAspectFit
    }
    private var loadingBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.5
    }
    
    private func loadingViewConstraintSettings() {
        view.addSubview(loadingBackgroundView)
        view.addSubview(loadingView)

        loadingView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
            $0.center.equalTo(view.center)
        }
        
        loadingBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func startLoading() {
        view.bringSubviewToFront(loadingBackgroundView)
        view.bringSubviewToFront(loadingView)
        loadingViewConstraintSettings()
        
        loadingBackgroundView.isHidden = false
        loadingView.isHidden = false
        loadingView.play()
    }
    
    func stopLoading() {
        loadingBackgroundView.isHidden = true
        loadingView.isHidden = true
        loadingView.stop()
    }
    
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        self.view.backgroundColor = .white
        loadingViewConstraintSettings()
        stopLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSettings()
    }
    
    
    // MARK: - Layout Constraints
    
    private(set) var didSetupConstraints = false
    
    override func updateViewConstraints() {
      if !self.didSetupConstraints {
        self.setupConstraints()
        self.didSetupConstraints = true
      }
      super.updateViewConstraints()
    }

    func setupConstraints() {
      // Override point
    }

    
    //MARK: - receive events from UI
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }


    // MARK: - [Navigation Bar + Navigation Item] Settings
    
    private func navigationBarSettings() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func navigationBarSettings(_ gestureDelegate: UIGestureRecognizerDelegate, _ titleText: String?, _ isHideDivider: Bool = false) {
        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = gestureDelegate
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(onTapBackButton))

        self.navigationController?.navigationBar.sizeToFit()
        
        if(titleText != nil) {
            navigationItem.titleView = UILabel().then {
                $0.text = titleText
                $0.font = .boldSystemFont(ofSize: 14)
            }
        }
        
        if (isHideDivider) {
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else {
            self.navigationController?.navigationBar.shadowImage = nil
        }
    }
    
    @objc
    func onTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
