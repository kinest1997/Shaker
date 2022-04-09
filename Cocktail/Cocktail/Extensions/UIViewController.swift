//
//  UIViewController.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/08.
//

import UIKit
import SwiftUI

extension UIViewController {
    static var rootViewController: UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.rootViewController
    }
    
    /// 로그인시에 가능하다는 팝업
    func pleaseLoginAlert() {
        let alert = UIAlertController(title: "로그인시에 사용가능합니다".localized, message: "로그인은 설정에서 할수있습니다".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// 간단한 알람을 띄워준다
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default))
        DispatchQueue.main.async {
            self.show(alert, sender: nil)
        }
    }
}


#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
