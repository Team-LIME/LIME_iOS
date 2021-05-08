//
//  UsersViewOtherProfileCell.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/08.
//

import UIKit
import ReactorKit
import RxSwift

class UsersViewOtherProfileCell: LIME_iOS.UICollectionViewCell, View {
    static let registerId = "\(UsersViewOtherProfileCell.self)"
    
    typealias Reactor = UsersViewOtherProfileCellReactor
    
    // MARK: - Object lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.contentStackView)
        self.contentView.addSubview(self.profileImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.introLabel)
    }
    
    //MARK: - UI
    
    lazy var profileImageView = UIImageView().then {
        $0.backgroundColor = .black
    }
    lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    lazy var introLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
        $0.textAlignment = .right
    }
    lazy var contentStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentStackView.addArrangedSubview(profileImageView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(introLabel)
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
        
        profileImageView.snp.makeConstraints {
            $0.left.equalTo(self.contentStackView)
            $0.top.equalTo(self.contentStackView)
            $0.bottom.equalTo(self.contentStackView)
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(10)
            $0.top.bottom.equalTo(self.contentStackView)
        }
        
        introLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.right).offset(10)
            $0.top.bottom.right.equalTo(self.contentStackView)
        }
        
    }
    
    //MARK: - Binding
    func bind(reactor: UsersViewOtherProfileCellReactor) {
        reactor.state.map { $0.otherProfile.name }
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)

        reactor.state.map { $0.otherProfile.intro }
            .bind(to: self.introLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.otherProfile.profileImages }
            .map{ $0.first }
            .bind(to: self.profileImageView.rx.profileImageURL)
            .disposed(by: self.disposeBag)
    }
}
