//
//  FilterViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import Differentiator

struct FilterViewModel: FilterViewBindable {
    var showFilterView = PublishSubject<Void>()

    
    //viewModel -> SuperViewModel
    var conditionsOfCocktail: Observable<[FilteredView.FilterData]>
    
    // view -> viewModel
    var cellTapped = PublishRelay<IndexPath>()
    
    var closeButtonTapped = PublishRelay<Void>()
    
    var saveButtonTapped = PublishRelay<Void>()
    
    var resetButton = PublishRelay<Void>()
    
    let updateCell: Signal<(index: IndexPath, checked: [[Bool]])>
    
    let conditionsArray: Driver<[FilteredView.FilterData]>
    
    var dismissFilterView: Signal<Void>
    
    var selectedConditions: Observable<[FilteredView.FilterData]>
    
    init(model: FilterModel = FilterModel()) {
        self.conditionsArray = Driver.just(model.emptyconditionArray)
        
        let resetConditions = resetButton.withLatestFrom(self.conditionsArray)
        
        let tappedData = cellTapped
            .scan(into: model.emptyconditionArray) {base, index in
                if base[index.section].condition.contains(where: { condition in
                    condition.rawValue == base.map { $0.section }[index.section][index.row].rawValue
                }){
                    guard let number = base[index.section].condition.firstIndex(where: { condition in
                        condition.rawValue == base.map { $0.section }[index.section][index.row].rawValue
                    }) else { return }
                    base[index.section].condition.remove(at: number)
                } else {
                    base[index.section].condition.append(base.map { $0.section }[index.section][index.row])
                }
            }

        selectedConditions = Observable.merge(tappedData, resetButton.map { model.emptyconditionArray })
        
        let finalSaveData = Observable.merge(resetConditions, selectedConditions)
        
        conditionsOfCocktail = saveButtonTapped.withLatestFrom(finalSaveData)
        
        
        let selectedStatus = cellTapped
            .scan(into: [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ].map {
                $0.map { _ in false }
            }) { data, index in
                data[index.section][index.row].toggle()
            }
        
        resetButton.withLatestFrom(selectedStatus) { data,asd in
            
        }
        
        updateCell = Observable.zip(cellTapped, selectedStatus) {
            (index: $0, checked: $1)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        dismissFilterView = Observable<Void>.merge(resetButton.asObservable(), closeButtonTapped.asObservable(), saveButtonTapped.asObservable())
            .asSignal(onErrorSignalWith: .empty())

        
    }
}

//섹션에 들어가는 정보: 여기선 셀의 정보와 헤더의 이름
//아이템은 원래 다른 객체로 만들어주려고 했는데 셀에 들어가는 정보가 그냥 string하나가 끝이라 string array로 만들어줌
struct SectionOfFilterCell {
    var header: String
    
    //아이템은 원래 다른 객체로 만들어주려고 했는데 셀에 들어가는 정보가 그냥 string하나가 끝이라 string array로 만들어줌
    var items: [String]
}

extension SectionOfFilterCell: SectionModelType {
    
    typealias Item = String
    
    init(original: SectionOfFilterCell, items: [Item]) {
        self = original
        self.items = items
    }
}
