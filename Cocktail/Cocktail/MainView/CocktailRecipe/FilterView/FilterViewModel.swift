//
//  FilterViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import Foundation
import RxCocoa
import RxSwift

struct FilterViewModel: FilterViewBindable {
    var cellTapped: PublishRelay<IndexPath>
    
    var closeButtonTapped: PublishRelay<Void>
    
    var saveButtonTapped: PublishRelay<Void>
    
    var resetButton: PublishRelay<Void>
    
    var conditionsOfCocktail: [FilteredView.FilterData]
    
    
}
