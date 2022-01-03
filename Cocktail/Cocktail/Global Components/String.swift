//
//  String.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/15.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}

extension NSMutableAttributedString {
    static func addBigOrangeText(text: String, firstRange: NSRange, bigFont: UIFont, secondRange: NSRange, smallFont: UIFont, orangeRange: NSRange) -> NSMutableAttributedString {
        let nsText = NSMutableAttributedString(string: text)
        let mainColor = UIColor.mainGray
        
        nsText.addAttribute(.font, value: smallFont, range: firstRange)
        nsText.addAttribute(.font, value: smallFont, range: secondRange)
        
        nsText.addAttribute(.foregroundColor, value: mainColor, range: firstRange)
        nsText.addAttribute(.foregroundColor, value: mainColor, range: secondRange)
        
        nsText.addAttribute(.font, value: bigFont, range: orangeRange)
        nsText.addAttribute(.foregroundColor, value: UIColor.mainOrange, range: orangeRange)
        return nsText
    }
    
    static func addOrangeText(text: String, firstRange: NSRange, secondRange: NSRange, smallFont: UIFont, orangeRange: NSRange) -> NSMutableAttributedString {
        let nsText = NSMutableAttributedString(string: text)
        let mainColor = UIColor.mainGray
        
        nsText.addAttribute(.font, value: smallFont, range: firstRange)
        nsText.addAttribute(.font, value: smallFont, range: secondRange)
        
        nsText.addAttribute(.foregroundColor, value: mainColor, range: firstRange)
        nsText.addAttribute(.foregroundColor, value: mainColor, range: secondRange)
        
        nsText.addAttribute(.font, value: smallFont, range: orangeRange)
        nsText.addAttribute(.foregroundColor, value: UIColor.mainOrange, range: orangeRange)
        return nsText
    }
}
