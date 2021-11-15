//
//  String.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/15.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
