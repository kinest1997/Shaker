//
//  ColorChoiceModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import Foundation

struct ColorChoiceModel {
    func getLastReceipe(_ colors: [Cocktail.Color]) -> [Cocktail] {
        return FirebaseRecipe.shared.recipe.filter { colors.contains($0.color) }
    }
}
