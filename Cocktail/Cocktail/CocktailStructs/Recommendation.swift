//
//  Recommendation.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/09.
//

import Foundation

struct Recommendation: Codable {
    var hashTagName: String
    var list: [String]

    /// 이름배열을 받아오면 그것의 이름을 가진 칵테일을 반환해주는것
    func spitRecipe(data: [Cocktail]) -> [Cocktail] {

        let enumArray = data.enumerated()

        let recipe = enumArray.filter({ data in
            list.contains(data.element.name)
        }).map {$0.element}

        return recipe.sorted {
            $0.glass.rawValue > $1.glass.rawValue
        }
    }
}
