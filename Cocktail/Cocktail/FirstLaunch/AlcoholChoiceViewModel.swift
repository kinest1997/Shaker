//
//  AlcoholChoiceViewModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import RxSwift
import RxCocoa
import UIKit

struct AlcoholChoiceViewModel: AlcoholChoiceViewBindable {
    //viewModel -> view
    let myFavor: Signal<Bool>
    let isNextButtonEnabled: Signal<Bool>
    let setButtonImage: Signal<Cocktail.Alcohol>
    let buttonLabelCount: Signal<Int>
    let showReadyToLaunchViewController: Driver<Void>
    let presentAlert: Driver<Void>
    let showDrinkTypeChoiceView: Driver<DrinkTypeChoiceViewComponents>
    
    //view -> viewModel
    let alcoholLevelButtonTapped = PublishRelay<Cocktail.Alcohol>()
    let nextButtonTapped = PublishRelay<Void>()
    
    //superViewModel -> viewModel
    let updateMyFavor = PublishSubject<Bool>()
    let updateFilteredRecipe = PublishSubject<[Cocktail]>()
    
    init(model: AlcoholChoiceModel = AlcoholChoiceModel()) {
        self.myFavor = updateMyFavor
            .startWith(true)
            .asSignal(onErrorSignalWith: .empty())
        
        self.isNextButtonEnabled = alcoholLevelButtonTapped
            .map { _ in true }
            .startWith(false)
            .asSignal(onErrorJustReturn: false)
        
        self.saveMyFavor = alcoholLevelButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        self.setButtonImage = alcoholLevelButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        self.buttonLabelCount = alcoholLevelButtonTapped
            .withLatestFrom(updateFilteredRecipe)
            .map { $0.count }
            .asSignal(onErrorJustReturn: 0)
        
        self.showReadyToLaunchViewController = nextButtonTapped
            .withLatestFrom(myFavor)
            .filter { $0 }
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        let lastRecipe = nextButtonTapped
            .withLatestFrom(myFavor)
            .filter { !$0 }
            .withLatestFrom(updateFilteredRecipe)
            .map {
                $0.filter { $0.alcohol == self.alcoholSelected }
            }
            .share()
        
        self.presentAlert = lastRecipe
            .filter { $0.isEmpty }
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        let drinkTypeChoiceViewComponents = Observable
            .combineLatest(
                myFavor.asObservable(),
                updateFilteredRecipe.asObservable()
            ) { (favor: $0, recipe: $1) }
        
        self.showDrinkTypeChoiceView = lastRecipe
            .filter { !$0.isEmpty }
            .flatMap { _ in
                return drinkTypeChoiceViewComponents
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
