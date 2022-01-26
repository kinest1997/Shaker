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
    
    func makeDefaultFilterData() -> [SectionOfFilterCell] {
        let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
        
        let componentsOfCocktail = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ]
            .map { $0.map { FilterCellData(name: $0, selected: false)}}
        
        let sections = [
            SectionOfFilterCell(header: filterSections[0], items: componentsOfCocktail[0]),
            SectionOfFilterCell(header: filterSections[1], items: componentsOfCocktail[1]),
            SectionOfFilterCell(header: filterSections[2], items: componentsOfCocktail[2]),
            SectionOfFilterCell(header: filterSections[3], items: componentsOfCocktail[3]),
            SectionOfFilterCell(header: filterSections[4], items: componentsOfCocktail[4]),
            SectionOfFilterCell(header: filterSections[5], items: componentsOfCocktail[5]),
        ]
        return sections
    }
    
    func modifiedFilterCellData(data: [[(name: String, checked: Bool)]]) -> [SectionOfFilterCell] {
        let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
        
        let componentsOfCocktail = data.map { firstArray in
            firstArray.map { lastData in
                FilterCellData(name: lastData.name, selected: lastData.checked)
            }
        }
        
        let sections = [
            SectionOfFilterCell(header: filterSections[0], items: componentsOfCocktail[0]),
            SectionOfFilterCell(header: filterSections[1], items: componentsOfCocktail[1]),
            SectionOfFilterCell(header: filterSections[2], items: componentsOfCocktail[2]),
            SectionOfFilterCell(header: filterSections[3], items: componentsOfCocktail[3]),
            SectionOfFilterCell(header: filterSections[4], items: componentsOfCocktail[4]),
            SectionOfFilterCell(header: filterSections[5], items: componentsOfCocktail[5]),
        ]
        return sections
    }
}
