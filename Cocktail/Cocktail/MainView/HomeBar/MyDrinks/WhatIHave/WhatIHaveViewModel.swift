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
    var cellTapped = PublishRelay<IndexPath>()
    
    var viewWillAppear = PublishSubject<Void>()
    
    var viewWillDisappear = PublishSubject<Void>()
    
    var listData = PublishSubject<Cocktail.Base>()
    
    var cellData: Driver<[WhatIHaveCollectionViewCell.CellData]>
    
    let nowIngredients = PublishSubject<[String]>()
    
    let modifiedCellData = PublishSubject<[WhatIHaveCollectionViewCell.CellData]>()
    
    let disposeBag = DisposeBag()
    
    init(model: WhatIHaveModel = WhatIHaveModel()) {
        let totalInredients = listData.map { $0.list.map { $0.rawValue } }
            .asDriver(onErrorDriveWith: .empty())
        
        let firstData = viewWillAppear
            .map { () -> [String] in
                guard let nowRecipe = UserDefaults.standard.object(forKey: "whatIHave") as? [String] else { return []}
                return nowRecipe
            }

        let modifiedRecipe = cellTapped.withLatestFrom(totalInredients) { index, total in
            model.modifyMyIngredients(total: total, indexPath: index)
        }
            .asObservable()
        
        Observable.merge(firstData, modifiedRecipe)
            .debug("why")
            .bind(to: nowIngredients)
            .disposed(by: disposeBag)
        
        cellData = nowIngredients.withLatestFrom(totalInredients) { total, now in
            model.returnCellData(total: now, now: total)
        }
        .debug("celldata")
        .asDriver(onErrorDriveWith: .empty())
    
    }
}
