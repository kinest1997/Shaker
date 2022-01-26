//
//  CoccktailRecipeViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/20.
//

import Foundation
import RxCocoa
import RxSwift
import Differentiator
import RxDataSources

struct CocktailRecipeViewModel: CocktailRecpeViewBindable {

    var filterButtonTapped = PublishRelay<Void>()
    
    var arrangeButtonTapped = PublishRelay<Void>()
    
    var filterRecipe = PublishSubject<SortingStandard>()
    
    var viewWillAppear = PublishSubject<Void>()
    
    var dismissLoadingView: Signal<Void>
    
    var sortedRecipe: Driver<[Cocktail]>
    
    var dismissFilterView: Signal<Void>
    
    var showFilterView: Signal<Void>
    
    var filterviewModel = FilterViewModel()
    
    var searchViewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    init(model: CocktailRecipeModel = CocktailRecipeModel()) {
        
        let firstRecipe = viewWillAppear
            .flatMapLatest { _ in
                model.getRecipeRx()
            }
        
        viewWillAppear
            .bind(to: filterviewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
//        let conditions = filterviewModel.conditionsOfCocktail
        
        let textOutput = searchViewModel.outPuts
            .asObservable()
        
        filterRecipe.onNext(.name)
        
        let finalResultRecipes = Observable.combineLatest(firstRecipe, filterviewModel.conditionsOfCocktail, textOutput, filterRecipe){ recipe, conditions, searchText, sortingStandard -> [Cocktail] in
            
            let filteredRecipe = model.sortingRecipes(
                origin: recipe,
                alcohol: conditions[0].condition as! [Cocktail.Alcohol],
                base: conditions[1].condition as! [Cocktail.Base],
                drinktype: conditions[2].condition as! [Cocktail.DrinkType],
                craft: conditions[3].condition as! [Cocktail.Craft],
                glass: conditions[4].condition as! [Cocktail.Glass],
                color: conditions[5].condition as! [Cocktail.Color]
            ).sorted { $0.name < $1.name }
            
            if searchText != "" {
                let searchedRecipe = filteredRecipe.filter({
                    return $0.name.localized.lowercased().contains(searchText) || $0.ingredients.map({ baby in
                        baby.rawValue.localized.lowercased()
                    })[0...].contains(searchText) ||  $0.recipe.contains(searchText)
                })
                return model.sorting(standard: sortingStandard, recipe: searchedRecipe)
            } else {
                return model.sorting(standard: sortingStandard, recipe: filteredRecipe)
            }
        }
            
        sortedRecipe = Observable.merge(finalResultRecipes, firstRecipe)
            .asDriver(onErrorDriveWith: .empty())
        
        dismissFilterView = filterviewModel.dismissFilterView
        
        showFilterView = filterButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        filterButtonTapped
            .bind(to: filterviewModel.showFilterView)
            .disposed(by: disposeBag)
        
        dismissLoadingView = finalResultRecipes
            .map { _ in Void() }
            .take(1)
            .asSignal(onErrorSignalWith: .empty())
    }
}
