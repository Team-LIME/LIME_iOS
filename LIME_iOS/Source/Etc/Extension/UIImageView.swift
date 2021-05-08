//
//  UIImageView.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/09.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadProfileImage(from url: String?) {
        
        DispatchQueue.main.async {
            self.image = nil // 초기
            self.layer.cornerRadius = self.bounds.width / 2.3
            self.clipsToBounds = true
            
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: URL(string: url ?? ""),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ], completionHandler: { result in
                    switch result {
                        case .success(let value):
                            print("success profile image download: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            self.image = UIImage(named: "profile")
                            print("fail profile image download: \(error.localizedDescription)")
                    }
                })
            self.contentMode = .scaleAspectFill
        }
    }
    
    func downloadImage(from url: String?) {
        self.image = nil // 초기화
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: URL(string: url ?? ""),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler: { result in
                switch result {
                    case .success(let value):
                        print("success image download : \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        self.image = UIImage(named: "not_found_image")
                        print("fail image download : \(error.localizedDescription)")
                }
            })
    }

}
