//
//  NavigationBar.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/04.
//

import Foundation
import UIKit

extension UINavigationItem {
    static func setButtonFont(navigation: UINavigationItem) {
        let naviBarButtonTextAttributes = [NSAttributedString.Key.font: UIFont.nexonFont(ofSize: 16, weight: .semibold)]
        navigation.rightBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
        navigation.leftBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
        navigation.backBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
    }
}

extension UINavigationBar {
    static func setTitleFont(navigation: UINavigationBar?) {
        let naviBarTextAttributes = [NSAttributedString.Key.font: UIFont.nexonFont(ofSize: 20, weight: .bold)]
        navigation?.titleTextAttributes = naviBarTextAttributes
    }
}

extension UINavigationController {
    static func setTitleFont(navigation: UINavigationController?) {
        let naviBarTextAttributes = [NSAttributedString.Key.font: UIFont.nexonFont(ofSize: 20, weight: .bold)]
        navigation?.navigationBar.titleTextAttributes = naviBarTextAttributes
        
        let naviBarButtonTextAttributes = [NSAttributedString.Key.font: UIFont.nexonFont(ofSize: 16, weight: .semibold)]
        navigation?.navigationItem.rightBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
        navigation?.navigationItem.leftBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
        navigation?.navigationItem.backBarButtonItem?.setTitleTextAttributes(naviBarButtonTextAttributes, for: .normal)
    }
}
