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
    
    //viewModel -> SuperViewModel
    var conditionsOfCocktail: Observable<[FilteredView.FilterData]>
    
    // view -> viewModel
    var cellTapped = PublishRelay<IndexPath>()
    
    var closeButtonTapped = PublishRelay<Void>()
    
    var saveButtonTapped = PublishRelay<Void>()
    
    var resetButton = PublishRelay<Void>()
    
    let modifiedCondition = PublishSubject<[FilteredView.FilterData]>()
    
    let updateCell: Signal<(index: IndexPath, checked: [[Bool]])>
    
    let conditionsArray: Driver<[FilteredView.FilterData]>
    
    init() {
        
        self.conditionsArray = Driver.just(                [
            (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
            (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
            (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
            (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
            (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
            (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
        ])
        
        let resetConditions = resetButton.withLatestFrom(self.conditionsArray)
        
        let selectedConditions = cellTapped
            .withLatestFrom(conditionsArray) { index, cellData in
                (cellData.map { $0.section }[index.section][index.row] , index)
            }
            .scan(into: [
                (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
                (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
                (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
                (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
                (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
                (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
            ] as! [FilteredView.FilterData] ) {base, data in
                if base[data.1.section].condition.contains(where: { condition in
                    condition.rawValue == data.0.rawValue
                }) {
                    base[data.1.section].condition.removeAll { condition in
                        condition.rawValue == data.0.rawValue
                    }
                } else {
                    base[data.1.section].condition.append(data.0)
                }
            }

        conditionsOfCocktail = Observable.merge(resetConditions, selectedConditions)
            .startWith([
                (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
                (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
                (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
                (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
                (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
                (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
            ])

        
        let selectedStatus = cellTapped
            .scan(into: [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ].map {
                $0.map { _ in false }
            }) { data, index in
                data[index.section][index.row].toggle()
            }
        
        updateCell = Observable.zip(cellTapped, selectedStatus) {
            (index: $0, checked: $1)
        }
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
