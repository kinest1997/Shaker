//
//  UIViewController.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/08.
//

import UIKit

extension UIViewController {

    /// 현재의 가장 기반 뷰 컨트롤러를 알려준다
    static var rootViewController: UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.rootViewController
    }
    
    /// 로그인 하라는 알람을 띄워준다
    func pleaseLoginAlert() {
        let alert = UIAlertController(title: "로그인시에 사용가능합니다".localized, message: "로그인은 설정에서 할수있습니다".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
