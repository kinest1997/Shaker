//
//  ColorChoiceModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import Foundation
import RxSwift

struct ColorChoiceModel {
    func getLastReceipe(_ colors: [Cocktail.Color]) -> [Cocktail] {
        return FirebaseRecipe.shared.recipe.filter { colors.contains($0.color) }
    }
    
    func getReciepe() -> Single<[Cocktail]> {
        return FirebaseRecipe.shared.getRecipe()
    }
}
