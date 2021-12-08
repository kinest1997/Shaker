//
//  UIViewController.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/08.
//

import UIKit

extension UIViewController {
    static var rootViewController: UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.rootViewController
    }
}
