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
