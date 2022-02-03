//
//  CocktailRecipeModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/22.
//

import Foundation
import RxCocoa
import RxSwift

struct CocktailRecipeModel {
    
    let uid = FirebaseRecipe.shared.uid
    
    let ref = FirebaseRecipe.shared.ref
    
    ///칵테일 레시피를 받아오는 것
    func getRecipeRx() -> Single<[Cocktail]> {
        return Single.create { observer in
            ref.child("CocktailRecipes").observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [[String: Any]],
                      let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                          observer(.success([Cocktail]()))
                          return }
                observer(.success(cocktailList))
            }
            return Disposables.create()
        }
    }
    
    ///칵테일 조건을 받았을떄 그 조건을 정렬하여 레시피를 반환해주는것
    func filteredRecipe(conditions: [FilteredView.FilterData], recipe: [Cocktail]) -> [Cocktail] {
        let filteredRecipe = sortingRecipes(
            origin: recipe,
            alcohol: conditions[0].condition as! [Cocktail.Alcohol],
            base: conditions[1].condition as! [Cocktail.Base],
            drinktype: conditions[2].condition as! [Cocktail.DrinkType],
            craft: conditions[3].condition as! [Cocktail.Craft],
            glass: conditions[4].condition as! [Cocktail.Glass],
            color: conditions[5].condition as! [Cocktail.Color]
        ).sorted { $0.name < $1.name }
        
        return filteredRecipe
    }
    
    ///검색창에 의해 필터링된 레시피를 반환
    func serchedRecipe(filteredRecipe: [Cocktail], searchText: String) -> [Cocktail] {
        let searchedRecipe = filteredRecipe.filter({
            return $0.name.localized.lowercased().contains(searchText) ||
            $0.ingredients.map { $0.rawValue.localized.lowercased() }[0...].contains(searchText) ||
            $0.recipe.contains(searchText)
        })
        return searchedRecipe
    }
    
    ///칵테일 조건을 받았을떄 그 조건에 따라 필터링된 레시피를 반환
    func sortingRecipes(origin: [Cocktail], alcohol: [Cocktail.Alcohol], base: [Cocktail.Base], drinktype: [Cocktail.DrinkType], craft: [Cocktail.Craft], glass: [Cocktail.Glass], color: [Cocktail.Color]) -> [Cocktail] {
        var alcoholSorted = [Cocktail]()
        var baseSorted = [Cocktail]()
        var drinktypeSorted = [Cocktail]()
        var craftSorted = [Cocktail]()
        var glassSorted = [Cocktail]()
        var colorSorted = [Cocktail]()
        
        if alcohol.isEmpty {
            alcoholSorted = origin
        } else {
            for i in alcohol {
                let alcoholSortedRecipe = origin.filter {
                    $0.alcohol == i
                }
                alcoholSorted.append(contentsOf: alcoholSortedRecipe)
            }
        }
        
        if base.isEmpty {
            baseSorted = origin
        } else {
            for i in base {
                let baseSortedRecipe = origin.filter {
                    $0.base == i
                }
                baseSorted.append(contentsOf: baseSortedRecipe)
            }
        }
        
        if drinktype.isEmpty {
            drinktypeSorted = origin
        } else {
            for i in drinktype {
                let sorted = origin.filter {
                    $0.drinkType == i
                }
                drinktypeSorted.append(contentsOf: sorted)
            }
        }
        
        if craft.isEmpty {
            craftSorted = origin
        } else {
            for i in craft {
                let sorted = origin.filter {
                    $0.craft == i
                }
                craftSorted.append(contentsOf: sorted)
            }
        }
        
        if glass.isEmpty {
            glassSorted = origin
        } else {
            for i in glass {
                let sorted = origin.filter {
                    $0.glass == i
                }
                glassSorted.append(contentsOf: sorted)
            }
        }
        
        if color.isEmpty {
            colorSorted = origin
        } else {
            for i in color {
                let sorted = origin.filter {
                    $0.color == i
                }
                colorSorted.append(contentsOf: sorted)
            }
        }
        let final = Set(baseSorted).intersection(Set(alcoholSorted))
            .intersection(Set(drinktypeSorted)).intersection(Set(craftSorted)).intersection(Set(glassSorted)).intersection(Set(colorSorted))
        return Array(final)
    }
    
    func sorting(standard: SortingStandard, recipe: [Cocktail]) -> [Cocktail] {
        switch standard {
        case .alcohol:
            return recipe.sorted { $0.alcohol.rank < $1.alcohol.rank}
            
        case .name:
            return recipe.sorted { $0.name < $1.name }
            
        case .ingredientsCount:
            return recipe.sorted { $0.ingredients.count < $1.ingredients.count}
            
        default:
            return recipe
        }
    }
}
