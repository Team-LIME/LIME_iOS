//
//  HomeViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/29.
//v

import UIKit
import Then
import SnapKit
import ReactorKit

class HomeViewController: LIME_iOS.UITabBarController {
    //MARK: - UI
    
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewControllers = [UINavigationController(rootViewController: UsersViewController()),
                                UINavigationController(rootViewController: ChatsViewController()),
                                UINavigationController(rootViewController: MoreViewController())]
        
        self.tabBar.tintColor = .systemGreen
    }
    
    override func setupConstraints() {
        
    }
}
