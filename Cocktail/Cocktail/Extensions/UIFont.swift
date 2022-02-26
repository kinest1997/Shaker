//
//  UIFont.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/31.
//

import Foundation
import UIKit

extension UIFont {
    static func nexonFont(ofSize: CGFloat, weight: UIFont.Weight ) -> UIFont {
        switch weight {
        case .bold, .black, .heavy:
            return UIFont(name: "NEXON Lv1 Gothic OTF Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .semibold, .medium, .regular:
            return UIFont(name: "NEXON Lv1 Gothic OTF", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light, .thin, .ultraLight:
            return UIFont(name: "NEXON Lv1 Gothic OTF Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        default:
            return .systemFont(ofSize: ofSize)
        }
    }
}
