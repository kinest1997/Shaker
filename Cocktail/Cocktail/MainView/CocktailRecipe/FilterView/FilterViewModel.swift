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
    var viewWillAppear = PublishSubject<Void>()
    
    var cellData: Observable<[SectionOfFilterCell]>
    
    var showFilterView = PublishSubject<Void>()
    
    
    //viewModel -> SuperViewModel
    var conditionsOfCocktail: Observable<[FilteredView.FilterData]>
    
    // view -> viewModel
    var cellTapped = PublishRelay<IndexPath>()
    
    var closeButtonTapped = PublishRelay<Void>()
    
    var saveButtonTapped = PublishRelay<Void>()
    
    var resetButton = PublishRelay<Void>()
    
    let conditionsArray: Driver<[FilteredView.FilterData]>
    
    var dismissFilterView: Signal<Void>
    
    var selectedConditions: Observable<[FilteredView.FilterData]>
    
    var selectedStatus = Observable<[[Bool]]>.just([Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ].map {
        $0.map { _ in false }
    })
    
    init(model: FilterModel = FilterModel()) {
//        self.conditionsArray = Driver.just(model.emptyconditionArray)
//    
//        let resetButtonTapped = resetButton
//            .map { _ in IndexPath(row: 20, section: 20)}
//
//        let tappedData = Observable.merge(cellTapped.asObservable(), resetButtonTapped)
//            .scan(into: model.emptyconditionArray) {base, index in
//                
//                if index == IndexPath(row: 20, section: 20) {
//                    base = model.emptyconditionArray
//                } else {
//                    if base[index.section].condition.contains(where: { condition in
//                        condition.rawValue == base.map { $0.section }[index.section][index.row].rawValue
//                    }){
//                        guard let number = base[index.section].condition.firstIndex(where: { condition in
//                            condition.rawValue == base.map { $0.section }[index.section][index.row].rawValue
//                        }) else { return }
//                        base[index.section].condition.remove(at: number)
//                    } else {
//                        base[index.section].condition.append(base.map { $0.section }[index.section][index.row])
//                    }
//                }
//            }
//
//        conditionsOfCocktail = saveButtonTapped.withLatestFrom(tappedData)
//        
//        selectedStatus = Observable.merge(cellTapped.asObservable(), resetButtonTapped)
//            .scan(into: [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ].map {
//                $0.map { _ in false }
//            }) { data, index in
//                if index == IndexPath(row: 20, section: 20) {
//                    data = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ].map {
//                        $0.map { _ in false }
//                    }
//                } else {
//                    data[index.section][index.row].toggle()
//                }
//            }
//        
//        dismissFilterView = Observable<Void>.merge(resetButton.asObservable(), closeButtonTapped.asObservable(), saveButtonTapped.asObservable())
//            .asSignal(onErrorSignalWith: .empty())
//        
//
//        let showTableViewDataTrigger = Observable.merge(resetButton.asObservable(), viewWillAppear)
//        
//        cellData = Observable.merge(resetButton.asObservable(), viewWillAppear)
//            .map { _ in
//                let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
//                
//                let componentsOfCocktail = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ]
//                
//                let sections = [
//                    SectionOfFilterCell(header: filterSections[0], items: componentsOfCocktail[0]),
//                    SectionOfFilterCell(header: filterSections[1], items: componentsOfCocktail[1]),
//                    SectionOfFilterCell(header: filterSections[2], items: componentsOfCocktail[2]),
//                    SectionOfFilterCell(header: filterSections[3], items: componentsOfCocktail[3]),
//                    SectionOfFilterCell(header: filterSections[4], items: componentsOfCocktail[4]),
//                    SectionOfFilterCell(header: filterSections[5], items: componentsOfCocktail[5]),
//                ]
//                
//                return sections
//            }
    }
}

//셀이 탭 될때마다 해당셀의 이미지를 새로고침해준다

//리셋버튼, 또는 저장 버튼이 눌리면 칵테일 필터링 조건을 슈퍼뷰모델로 보내준다
//리셋버튼, 또는 뷰가 처음 나타날떄 테이블뷰를 그려준다

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
