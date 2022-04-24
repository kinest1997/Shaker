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

    let cellDeleted = PublishRelay<IndexPath>()

    let viewWillappear = PublishSubject<Void>()

    let updateCellData: Driver<[Cocktail]>

    let showDetailView: Signal<Cocktail>

    let cellData = PublishSubject<[Cocktail]>()

    let disposeBag = DisposeBag()

    init(model: WishListmodel = WishListmodel()) {

        let mainRecipe = viewWillappear
            .flatMap { _ in
                model.getWishListRx()
            }

        let modifiedRecipe = cellDeleted
            .withLatestFrom(cellData) { indexPath, array in
                model.deleteWishList(list: array, cocktail: array[indexPath.row])
            }
            .flatMap { _ in
                model.getWishListRx()
            }

        Observable.merge(mainRecipe, modifiedRecipe)
            .bind(to: cellData)
            .disposed(by: disposeBag)

        updateCellData = cellData
            .asDriver(onErrorDriveWith: .empty())

        showDetailView = cellTapped.withLatestFrom(cellData) { index, recipe in
            recipe[index.row]
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}
