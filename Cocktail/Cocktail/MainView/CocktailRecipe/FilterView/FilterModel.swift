//
//  FilterModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/24.
//

import Foundation

struct FilterModel {
    
    let emptyconditionArray: [FilteredView.FilterData] = [
        (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
        (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
        (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
        (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
        (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
        (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
    ]
    
    let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
    
    ///아무것도 체크되지않은 상태의 조건을 반환해주는 함수
    func makeDefaultFilterData() -> [SectionOfFilterCell] {
        let componentsOfCocktail = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ]
            .map { $0.map { FilterCellData(name: $0, selected: false)}}
        
        let result = makeComponentsOfCocktail(data: componentsOfCocktail)
        return result
    }
    
    ///어딘가 체크된 상태의 조건을 반환해주는 함수
    func modifiedFilterCellData(data: [[(name: String, checked: Bool)]]) -> [SectionOfFilterCell] {
        let componentsOfCocktail = data.map { firstArray in
            firstArray.map { lastData in
                FilterCellData(name: lastData.name, selected: lastData.checked)
            }
        }
        let result = makeComponentsOfCocktail(data: componentsOfCocktail)
        return result
    }
    
    ///날것의 셀의 체크된 상태의 데이터를 받아 셀의 정보로 변환
    func makeComponentsOfCocktail(data: [[FilterCellData]]) -> [SectionOfFilterCell] {
        let sections = [
            SectionOfFilterCell(header: filterSections[0], items: data[0]),
            SectionOfFilterCell(header: filterSections[1], items: data[1]),
            SectionOfFilterCell(header: filterSections[2], items: data[2]),
            SectionOfFilterCell(header: filterSections[3], items: data[3]),
            SectionOfFilterCell(header: filterSections[4], items: data[4]),
            SectionOfFilterCell(header: filterSections[5], items: data[5]),
        ]
        return sections
    }
    
    ///셀이 탭 될때마다 칵테일의 조건을 확인해서 조작해주는 함수
    func modifyConditionArray(base: inout [FilteredView.FilterData], index: IndexPath ) {
        if index == IndexPath(row: 20, section: 20) {
            base = self.emptyconditionArray
        } else {
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
    }
}
