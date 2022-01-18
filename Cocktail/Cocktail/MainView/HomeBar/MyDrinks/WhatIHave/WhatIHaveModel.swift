//
//  WhatIHaveModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/17.
//

import Foundation
import RxSwift
import RxCocoa

struct WhatIHaveModel {
    
    func returnCellData(total: [String], now: [String]) -> [WhatIHaveCollectionViewCell.CellData] {
        let iHave = Set(total).intersection(Set(now)).map {
            (title: $0, checked: true)
        }
        
        let iDontHave = Set(total).subtracting(Set(now)).map {
            (title: $0, checked: false)
        }
        
        let result = Array(iHave + iDontHave).sorted { $0.title > $1.title}
        
        return result
    }
    
    func modifyMyIngredients(total: [String], indexPath: IndexPath) -> [String]{
        
        guard let nowRecipe = UserDefaults.standard.object(forKey: "whatIHave") as? [String] else { return []}
        
        var modifiedIngredients = nowRecipe
        if modifiedIngredients.contains(total[indexPath.row]) {
            guard let index = modifiedIngredients.firstIndex(of: total[indexPath.row]) else { return modifiedIngredients}
            modifiedIngredients.remove(at: index)
        } else {
            modifiedIngredients.append(total[indexPath.row])
        }
        UserDefaults.standard.set(modifiedIngredients, forKey: "whatIHave")
        return modifiedIngredients
    }
}
