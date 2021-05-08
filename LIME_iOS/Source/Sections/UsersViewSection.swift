//
//  UsersViewSection.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/08.
//

import RxDataSources

enum UsersViewSection {
  case myProfile([ShotViewSectionItem])
  case otherProfile([ShotViewSectionItem])
}

extension UsersViewSection: SectionModelType {
  var items: [ShotViewSectionItem] {
    switch self {
        case .myProfile(let items): return items
        case .otherProfile(let items): return items
    }
  }

  init(original: UsersViewSection, items: [ShotViewSectionItem]) {
    switch original {
        case .myProfile: self = .myProfile(items)
        case .otherProfile: self = .otherProfile(items)
    }
  }
}

enum ShotViewSectionItem {
  case myProfile(UsersViewMyProfileCellReactor)
  case otherProfile(UsersViewOtherProfileCellReactor)
}
