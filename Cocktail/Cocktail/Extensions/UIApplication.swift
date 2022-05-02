//
//  UIApplication.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/08.
//

import UIKit

extension UIApplication {
    /// 현재 최상단의 뷰컨트롤러를 알려준다
    class func topMostViewController(_ viewController: UIViewController?) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topMostViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            tab.selectedViewController = tab.children.first
            if let selected = tab.selectedViewController {
                return topMostViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topMostViewController(presented)
        }
        return viewController
    }
}
