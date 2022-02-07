//
//  AssistantModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/14.
//

import Foundation

struct AssistantModel {

    enum Views {
        case myRecipe
        case wishList
        case myDrink
    }

    func sendViewData(indexPath: IndexPath) -> Views? {
        switch indexPath.row {
        case 0:
            return .myDrink
        case 1:
            return .myRecipe
        case 2:
            return .wishList
        default:
            return nil
        }
    }

    func cellData() -> [AssistantCell.CellData] {
        Assist.allCases
            .map { assist in
                (title: assist.title, explain: assist.explain)
            }
    }

    enum Assist: Int, CaseIterable {
        case myDrink
        case myOwnCocktail
        case wishList

        var title: String {
            switch self {
            case .myDrink:
                return "내 술장"
            case .myOwnCocktail:
                return "나의 레시피"
            case .wishList:
                return "즐겨찾기"
            }
        }

        var explain: String {
            switch self {
            case .myDrink:
                return "Find out the recipes that you can make with the ingredients you have!".localized
            case .myOwnCocktail:
                return "Let's go see the recipe I made".localized
            case .wishList:
                return "Let's go see the recipe that I added to my favorites".localized
            }
        }
    }

}
