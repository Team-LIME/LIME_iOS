//
//  UsersViewController.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/06.
//

import UIKit
import ReactorKit
import RxSwift
import RxDataSources

class UsersViewController: LIME_iOS.UIViewController, View {
    typealias Reactor = UsersViewReactor
    
    // MARK: - Object lifecycle
    
    init() {
        self.dataSource = type(of: self).dataSourceFactory()
        super.init(nibName: nil, bundle: nil)
        reactor = UsersViewReactor()
        self.tabBarItem = UITabBarItem(title: "친구",
                                       image: UIImage(systemName: "person"),
                                       selectedImage: UIImage(systemName: "person.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    
    fileprivate var dataSource: RxCollectionViewSectionedReloadDataSource<UsersViewSection>
    
    //MARK: - UI
    
    lazy var cellLayout = UICollectionViewFlowLayout()
    
    lazy var usersCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: cellLayout).then {
            $0.backgroundColor = .clear
            $0.alwaysBounceVertical = true
            $0.register(UsersViewMyProfileCell.self, forCellWithReuseIdentifier: UsersViewMyProfileCell.registerId)
            $0.register(UsersViewOtherProfileCell.self, forCellWithReuseIdentifier: UsersViewOtherProfileCell.registerId)
        }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usersCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let leftLabelFrame = CGRect(x: 0, y: 0,
                                    width: view.frame.width - 30,
                                    height: view.frame.height)
        let leftLabel = UILabel(frame: leftLabelFrame)
        leftLabel.font = .boldSystemFont(ofSize: 24)
        leftLabel.text = "친구"
        
        navigationItem.titleView = leftLabel
        navigationBarSettings(true)
    }
    
    override func setupConstraints() {
        self.usersCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Binding
    func bind(reactor: UsersViewReactor) {
        
        self.rx.viewDidLoad
            .map { .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //Output
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: self.usersCollectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        self.usersCollectionView.rx.setDelegate(self)
          .disposed(by: self.disposeBag)
        
        //Error
        reactor.state.map{ $0.errorMessage }
            .bind(to: self.view.rx.toastMessage)
            .disposed(by: disposeBag)
    }
}

extension UsersViewController {
    private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<UsersViewSection> {
        return .init(configureCell: { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
                case let .myProfile(reactor):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersViewMyProfileCell.registerId, for: indexPath) as! UsersViewMyProfileCell
                    cell.reactor = reactor
                    return cell
                    
                case let .otherProfile(reactor):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersViewOtherProfileCell.registerId, for: indexPath) as! UsersViewOtherProfileCell
                    cell.reactor = reactor
                    return cell

            }
        })
    }
}


extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = collectionView.frame.width

        guard let item = reactor?.currentState
                .sections[indexPath.section]
                .items[indexPath.row] else { return .zero }
        
        switch item {
            case .myProfile:
                return CGSize(width: maxWidth - 30, height: 75)
            case .otherProfile:
                return CGSize(width: maxWidth - 30, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = reactor?.currentState
                .sections[section] else { return .zero }
        
        switch section {
            case .myProfile:
                return UIEdgeInsets(top: 10, left: 0, bottom:20, right: 0)
            case .otherProfile:
                return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
    }
}
