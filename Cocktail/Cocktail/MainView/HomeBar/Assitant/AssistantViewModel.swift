//
//  AssistantViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxAppState

struct AssistantViewModel: AssistantViewBindable {

    var cellTapped = PublishRelay<IndexPath>()

    var viewWillappear = PublishSubject<Void>()

    var showPage: Signal<AssistantModel.Views>

    var cellData: Driver<[AssistantCell.CellData]>

    let disposeBag = DisposeBag()

    let wishListViewModel = WishListCocktailViewModel()

    let myOwnRecipeViewModel = MyOwnCocktailViewModel()

    let myDrinkViewModel = MyDrinksViewModel()

    init (model: AssistantModel = AssistantModel()) {
        showPage = cellTapped
            .compactMap(model.sendViewData)
            .asSignal(onErrorSignalWith: .empty())

        cellData = viewWillappear
            .compactMap { _ in
                model.cellData()
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
