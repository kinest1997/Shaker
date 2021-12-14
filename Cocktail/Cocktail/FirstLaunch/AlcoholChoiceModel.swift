//
//  AlcoholChoiceModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import Foundation

struct AlcoholChoiceModel {
    func getSelectedAlcohole() -> [Cocktail] {
        return filteredRecipe.filter { $0.alcohol == alcoholSelected }
    }
}
