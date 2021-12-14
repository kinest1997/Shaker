//
//  ColorChoiceModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import Foundation

struct ColorChoiceModel {
    func getLastRecipe() -> [Cocktail] {
        return FirebaseRecipe.shared.recipe.filter { selectedColor.contains($0.color) }
    }
}
