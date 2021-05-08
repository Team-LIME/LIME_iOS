//
//  Preview.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/04/30.
//

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiView: UITabBarController, context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UITabBarController {
        // 해당 라인을 수정하여 원하는 ViewController를 확인하세요.
        
        HomeViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some SwiftUI.View {
        Group {
            ViewControllerRepresentable()
//                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        }

    }
} #endif
