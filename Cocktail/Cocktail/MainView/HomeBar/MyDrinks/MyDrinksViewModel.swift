//
//  MyDrinksViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/17.
//

import Foundation
import RxCocoa
import RxSwift

struct MyDrinksViewModel: MyDrinkViewBindable {
    
    //input
    let whatICanMakeButtonTapped = PublishRelay<Void>()
    
    let cellTapped = PublishRelay<IndexPath>()
    
    let viewWillAppear = PublishRelay<Void>()
    
    //output
    let showIngredientsView: Signal<Cocktail.Base>
    
    let showRecipeListView: Signal<[Cocktail]>
    
    let updateWhatICanMakeButton: Signal<String>
    
    let updateCellData: Driver<[MyDrinkCell.CellData]>
    
    var changeButtonColor: Signal<Bool>
    
    let ingredientsWhatIHave = PublishSubject<[String]>()
    
    let recipeWhatICanMake = PublishSubject<[Cocktail]>()
    
    let disposeBag = DisposeBag()
    
    init(model: MyDrinksModel = MyDrinksModel()) {
        
        let cocktailBaseArray = Driver.just(Cocktail.Base.allCases)
        
        viewWillAppear
            .compactMap { _ -> [String]? in
                if let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] {
                    return data
                } else {
                    return []
                }
            }
            .bind(to: ingredientsWhatIHave)
            .disposed(by: disposeBag)
        
        changeButtonColor = recipeWhatICanMake
            .map { array in
                return array.isEmpty ? false: true
            }
            .asSignal(onErrorSignalWith: .empty())
        
        showIngredientsView = cellTapped.withLatestFrom(cocktailBaseArray) { index, array in
            return array[index.row]
        }
        .asSignal(onErrorSignalWith: .empty())
        
        showRecipeListView = whatICanMakeButtonTapped.withLatestFrom(recipeWhatICanMake) { _, array in
            return array
        }
        .asSignal(onErrorSignalWith: .empty())
        
        Observable.combineLatest(ingredientsWhatIHave, model.makeTotalRecipe().asObservable()) { ingredients, cocktail in
            model.recipeWhatICanMake(myIngredients: Set(ingredients), recipes: cocktail)
        }
        .bind(to: recipeWhatICanMake)
        .disposed(by: disposeBag)
        
        updateWhatICanMakeButton = recipeWhatICanMake
            .map(model.updateWhatICanMakeButton)
            .asSignal(onErrorSignalWith: .empty())
        
        updateCellData = Observable.combineLatest(cocktailBaseArray.asObservable(), ingredientsWhatIHave) { base, ingre in
            base.map { cocktailBase in
                (name: cocktailBase.rawValue, count: model.updateIngredientsBadge(base: cocktailBase, whatIHave: ingre))
            }
        }
        .asDriver(onErrorDriveWith: .empty())
    }
}
