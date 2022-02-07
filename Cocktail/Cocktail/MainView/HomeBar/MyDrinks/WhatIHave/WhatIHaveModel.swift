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
    /// 현재 보여주는 재료목록중 내가 가진것들만 체크해서 뱉어주는것
    func returnCellData(total: [String], nowIHave: [String]) -> [(title: String, checked: Bool)] {
        let iHave = Set(total).intersection(Set(nowIHave)).map {
            (title: $0, checked: true)
        }

        let iDontHave = Set(total).subtracting(Set(nowIHave)).map {
            (title: $0, checked: false)
        }

        let result = Array(iHave + iDontHave).sorted { $0.title < $1.title }

        return result
    }

    /// 단순 userDefault 를 받아오는것
    func nowRecipe() -> [String] {
        guard let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] else { return []}
        return data
    }

    /// 선택한 재료를 지우는것
    func modifyMyDrinks(ingredient: String) {
        var totalIHave = nowRecipe()
        if totalIHave.contains(ingredient) {
            totalIHave.removeAll {$0 == ingredient}
        } else {
            totalIHave.append(ingredient)
        }
        UserDefaults.standard.set(totalIHave, forKey: "whatIHave")
    }
}
