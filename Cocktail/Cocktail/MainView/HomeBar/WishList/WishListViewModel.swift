//
//  WishListViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/12.
//

import Foundation
import RxSwift
import RxCocoa

struct WishListCocktailViewModel: WishListViewBindable {
    let cellTapped = PublishRelay<IndexPath>()
    //
    let cellDeleted = PublishRelay<IndexPath>()
    //
    let viewWillappear = PublishSubject<Void>()
    
    let updateCellData: Driver<[Cocktail]>
    
    let showDetailView: Signal<Cocktail>
    
    init(model: WishListmodel = WishListmodel()) {
        
        let mainRecipe = model.getWishListRx()
        
        
        let modifiedRecipe = Observable.combineLatest(mainRecipe.asObservable(), cellDeleted) { recipe, index in
            model.deleteWishList(list: recipe, cocktail: recipe[index.row])
        }
        
        /*
         let modifiedRecipe = cellDeleted.withLatestFrom(mainRecipe) { indexPath, observer in
         model.deleteWishList(list: observer, cocktail: observer[indexPath.row])
         }
         */
        
        
        updateCellData = Observable.merge(viewWillappear, modifiedRecipe)
            .flatMap { _ in mainRecipe }
            .asDriver(onErrorDriveWith: .empty())
        
        showDetailView = Observable.combineLatest(mainRecipe.asObservable(), cellTapped) { recipe, index in
            recipe[index.row]
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}

// 셀을 지운다 -> 최근 리스트에서 해당하는 indexpath 의 칵테일을 지운다, 그 리스트를 업로드한다.
//
