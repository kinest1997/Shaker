//
//  WhatIHaveViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/17.
//

import Foundation
import RxCocoa
import RxSwift

struct WhatIHaveViewModel: WhatIHaveViewBindable {

    // view -> viewModel

    var cellTapped = PublishRelay<IndexPath>()

    var viewWillAppear = PublishSubject<Void>()

    // viewModel -> view

    var ingredientsArray: Driver<[WhatIHaveCollectionViewCell.CellData]>

    // superViewModel -> viewModel
    var listData = PublishSubject<[String]>()

    // onlyHere
    var userData = PublishSubject<[String]>()

    let disposeBag = DisposeBag()

    init(model: WhatIHaveModel = WhatIHaveModel()) {

        viewWillAppear
            .map { _ -> [String] in
                guard let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] else { return []}
                return data }
            .bind(to: userData)
            .disposed(by: disposeBag)

        let first = Observable.combineLatest(listData, userData) { total, iHave in
            model.returnCellData(total: total, nowIHave: iHave.sorted { $0 < $1 })
        }

        let cellTapUpdate = cellTapped.withLatestFrom(listData) { index, iHave -> [(title: String, checked: Bool)] in
            let array = iHave.sorted { $0 < $1 }
            model.modifyMyDrinks(ingredient: array[index.row])
           return model.returnCellData(total: array, nowIHave: model.nowRecipe())
        }

        ingredientsArray = Observable.merge(first, cellTapUpdate)
            .asDriver(onErrorDriveWith: .empty())
    }
}
