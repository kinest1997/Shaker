//
//  ColorChoiceViewModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/14.
//

import RxSwift
import RxCocoa
import FirebaseStorage

struct ColorChoiceViewModel: ColorChoiceViewBindable {
    let disposeBag = DisposeBag()
    let alcoholChoiceViewModel = AlcoholChoiceViewModel()
    
    //viewModel -> view
    let colorArray: Driver<[Cocktail.Color]>
    let updateItem: Signal<(indexPath: IndexPath, selected: [Bool])>
    let myFavor: Signal<Bool>
    let buttonLabelCount: Signal<Int>
    let saveMyFavor: Signal<[Cocktail.Color]>
    let presentAlert: Driver<Void>
    let presentAlcoholChoiceView: Driver<Void>

    //view -> viewModel
    let nextButtonTapped = PublishRelay<Void>()
    let itemSelected = PublishRelay<IndexPath>()
    
    //superViewModel -> viewModel
    let updateMyFavor = PublishSubject<Bool>()
    
    init(model: ColorChoiceModel = ColorChoiceModel()) {
        self.colorArray = Driver.just(Cocktail.Color.allCases)
        
        let selectStatus = itemSelected
            .scan(into: Array(repeating: false, count: Cocktail.Color.allCases.count)) {
                $0[$1.row].toggle()
            }
        
        self.updateItem = Observable
            .combineLatest(
                itemSelected.asObservable(),
                selectStatus
            ) { (indexPath: $0, selected: $1) }
            .asSignal(onErrorSignalWith: .empty())
        
        
        self.myFavor = updateMyFavor
            .startWith(true)
            .asSignal(onErrorSignalWith: .empty())
        
        let selectedColor = itemSelected
            .withLatestFrom(colorArray) { $1[$0.row] }
            .scan(into: [Cocktail.Color]()) {
                if $0.contains($1) {
                    guard let number = $0.firstIndex(of: $1) else { return }
                    $0.remove(at: number)
                } else {
                    $0.append($1)
                }
            }
        
        self.buttonLabelCount = selectedColor
            .map(model.getLastReceipe)
            .map { $0.count }
            .asSignal(onErrorJustReturn: 0)
        
        self.saveMyFavor = nextButtonTapped
            .flatMapLatest { selectedColor }
            .asSignal(onErrorSignalWith: .empty())
        
        let lastRecipe = Observable
            .combineLatest(
                nextButtonTapped.withLatestFrom(selectedColor),
                model.getReciepe().asObservable()
            ) { colors, cocktails in
                cocktails.filter {
                    colors.contains($0.color)
                }
            }
        
        self.presentAlert = lastRecipe
            .filter { $0.isEmpty }
            .map { _ in Void() }
            .asDriver(onErrorDriveWith: .empty())
        
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
            .map { _ in Void() }
            .asDriver(onErrorDriveWith: .empty())
    }
}
