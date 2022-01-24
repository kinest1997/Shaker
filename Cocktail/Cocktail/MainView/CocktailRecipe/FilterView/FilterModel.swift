//
//  FilterModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/24.
//

import Foundation

struct FilterModel {
    
    let emptyconditionArray: [FilteredView.FilterData] = [
        (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
        (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
        (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
        (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
        (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
        (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
    ]
}
