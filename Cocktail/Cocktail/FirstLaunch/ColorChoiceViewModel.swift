//
//  ColorChoiceViewModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import RxSwift
import RxCocoa

struct ColorChoiceViewModel: ColorChoiceViewBindable {
    let disposeBag = DisposeBag()
    let alcoholChoiceViewModel = AlcoholChoiceViewModel()
    
    //viewModel -> view
    let colorArray: Driver<[Cocktail.Color]>
    let updateItem: Signal<IndexPath>
    let buttonLabelCount: Signal<Int>
    let myFavor: Signal<Bool>
    let saveMyFavor: Signal<Void>
    let presentAlert: Driver<Void>
    let presentAlcoholChoiceView: Driver<AlcoholChoiceViewModel>

    //view -> viewModel
    let nextButtonTapped = PublishRelay<Void>()
    let itemSelected = PublishRelay<IndexPath>()
    
    //superViewModel -> viewModel
    let updateMyFavor = PublishSubject<Bool>()
    
    init(model: ColorChoiceModel = ColorChoiceModel()) {
        self.colorArray = Driver.just(Cocktail.Color.allCases)
        
        self.updateItem = itemSelected.asSignal(onErrorSignalWith: .empty())
        
        self.buttonLabelCount = itemSelected
            .map { _ in Void() }
            .map(model.getLastRecipe)
            .map { $0.count }
            .asSignal(onErrorJustReturn: 0)
        
        self.myFavor = updateMyFavor
            .startWith(true)
            .asSignal(onErrorSignalWith: .empty())
        
        self.saveMyFavor = nextButtonTapped
            .withLatestFrom(myFavor)
            .filter { $0 == true }
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        let lastRecipe = nextButtonTapped
            .map(model.getLastRecipe)
            .share()
        
        self.presentAlert = lastRecipe
            .filter { $0.isEmpty }
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        myFavor
            .asObservable()
            .bind(to: alcoholChoiceViewModel.updateMyFavor)
            .disposed(by: disposeBag)
        
        lastRecipe
            .filter { !$0.isEmpty }
            .bind(to: alcoholChoiceViewModel.updateFilteredRecipe)
            .disposed(by: disposeBag)
    
        self.presentAlcoholChoiceView = lastRecipe
            .filter { !$0.isEmpty }
            .map { _ -> AlcoholChoiceViewModel in
                return alcoholChoiceViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
