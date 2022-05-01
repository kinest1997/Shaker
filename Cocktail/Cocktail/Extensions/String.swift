//
//  String.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/15.
//

import Foundation
import UIKit

extension String {
    /// 로컬라이즈된 string을 반환해준다
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
    
    /// 레시피의 ARRAY를받아서 1,2,3,4 순으로 반환해준다
    static func makeRecipeText(recipe: [String]) -> String {
        let spaceStrings = recipe.enumerated().map {
            """
            
            \($0.offset + 1).  \($0.element.localized)
            
            
            """
        }
        let fullString = spaceStrings.reduce("") { $0 + $1 }
        return fullString
    }
    
    /// 재료의 ARRAY를 받아서 1,2,3,4 순으로반환해준다
    static func makeIngredientsText(ingredients: [Cocktail.Ingredients]) -> String {
        
        let spaceStrings = ingredients.enumerated().map {
            """
            
            \($0.offset + 1).  \($0.element.rawValue.localized)
            
            
            """
        }
        
        let fullString = spaceStrings.reduce("") { $0 + $1 }
        return fullString
    }
}

extension NSMutableAttributedString {
    /// 큰 주황색 텍스트가 있는 타이틀을 만들어준다
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
    
    /// 주황색 글자를 만들어준다
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
