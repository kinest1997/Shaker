//
//  MyOwnCocktailRecipeViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/14.
//

import Foundation
import RxCocoa
import RxSwift

struct MyOwnCocktailViewModel: MyOwnCocktailRecipeViewBindable {
    var cellTapped = PublishRelay<IndexPath>()
    
    var cellDeleted = PublishRelay<IndexPath>()
    
    var viewWillappear = PublishSubject<Void>()
    
    var addButtonTapped = PublishRelay<Void>()
    
    var updateCellData: Driver<[Cocktail]>
    
    var showDetailView: Signal<Cocktail>
    
    var showAddView: Signal<Void>
    
    let cellData = PublishSubject<[Cocktail]>()
    
    let disposeBag = DisposeBag()
    
    init(model: MyOwnCocktailRecipeModel = MyOwnCocktailRecipeModel()) {
        
        let mainData = viewWillappear
            .flatMap { _ in
                model.getMyRecipeRx()
            }
        
        let modifiedData = cellDeleted.withLatestFrom(cellData) { index, cocktail in
            model.deleteMyRecipe(list: cocktail, cocktail: cocktail[index.row])
            model.deleteWishList(list: cocktail, cocktail: cocktail[index.row])
        }
            .flatMap { _ in
                model.getMyRecipeRx()
            }
        
        Observable.merge(mainData, modifiedData)
            .bind(to: cellData)
            .disposed(by: disposeBag)
        
        updateCellData = cellData
            .asDriver(onErrorDriveWith: .empty())
        
        
        showDetailView = cellTapped.withLatestFrom(cellData) { index, cocktail in
            cocktail[index.row]
        }
        .asSignal(onErrorSignalWith: .empty())
        
        showAddView = addButtonTapped
            .asSignal()
    }
}
