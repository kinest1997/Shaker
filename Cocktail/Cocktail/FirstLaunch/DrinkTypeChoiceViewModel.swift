//
//  DrinkTypeChoiceViewModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa

struct DrinkTypeChoiceViewModel: DrinkTypeChoiceViewBindable {
    //viewModel -> view
    let setImageAndData: Signal<Cocktail.DrinkType>
    let buttonLabelCount: Signal<Int>
    let presentAlert: Signal<Void>
    let presentBaseChoiceViewController: Signal<[Cocktail]>
    
    //view -> viewModel
    let cocktailTypeButtonTapped = PublishRelay<Cocktail.DrinkType>()
    let nextButtonTapped = PublishRelay<Void>()
    let informationButtonTapped = PublishRelay<Void>()
    
    //superViewModel -> viewModel
    let filteredRecipe = PublishSubject<[Cocktail]>()
    
    init() {
        setImageAndData = cocktailTypeButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        let lastRecipe = Observable
            .combineLatest(
                filteredRecipe.asObservable(),
                cocktailTypeButtonTapped.asObservable()
            ) { recipe, drinkType in
                return recipe.filter {
                    $0.drinkType == drinkType
                }
            }
            .share()
        
        buttonLabelCount = lastRecipe
            .map { $0.count }
            .asSignal(onErrorSignalWith: .empty())
          
        presentAlert = nextButtonTapped
            .withLatestFrom(lastRecipe)
            .filter { $0.isEmpty }
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        presentBaseChoiceViewController = nextButtonTapped
            .withLatestFrom(lastRecipe)
            .filter { !$0.isEmpty }
            .asSignal(onErrorSignalWith: .empty())
    }
}
