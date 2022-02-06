//
//  MyDrinksModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/17.
//

import Foundation
import RxCocoa
import RxSwift

struct MyDrinksModel {

    func updateIngredientsBadge(base: Cocktail.Base, whatIHave: [String]) -> Int {
            let origin = Set(base.list.map {
                $0.rawValue })
            let subtracted = origin.subtracting(Set(whatIHave))
            let originCount = origin.count - subtracted.count
            return originCount
        }

    func updateWhatICanMakeButton(recipes: [Cocktail]) -> String {
            if recipes.count != 0 {
               return "\(recipes.count)" + " " + "EA".localized + " " + "making".localized
            } else {
                return "Choose more ingredients!".localized
            }
        }

    func recipeWhatICanMake(myIngredients: Set<String>, recipes: [Cocktail]) -> [Cocktail] {
            var lastRecipe = [Cocktail]()
        recipes.forEach {
                let someSet = Set($0.ingredients.map({ baby in
                    baby.rawValue
                }))
                if someSet.subtracting(myIngredients).isEmpty {
                    lastRecipe.append($0)
                }
            }
            return lastRecipe
        }

    func makeTotalRecipe() -> Single<[Cocktail]> {
        return FirebaseRecipe.shared.getRecipeRx()
    }
}
