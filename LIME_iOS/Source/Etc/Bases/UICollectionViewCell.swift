//
//  UICollectionViewCell.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/08.
//

import UIKit
import RxSwift
import SnapKit


class UICollectionViewCell: UIKit.UICollectionViewCell {

  var disposeBag = DisposeBag()
  

  // MARK: Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }

}
