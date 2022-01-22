//
//  CoccktailRecipeViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/20.
//

import Foundation
import RxCocoa
import RxSwift

struct CocktailRecipeViewModel: CocktailRecpeViewBindable {
    var filterButtonTapped = PublishRelay<Void>()
    
    var arrangeButtonTapped = PublishRelay<Void>()
    
    var filterRecipe = PublishSubject<SortingStandard>()
    
    var viewWillAppear = PublishSubject<Void>()
    
    var sortedRecipe: Driver<[Cocktail]>
    
    var showFilterView: Signal<Void>
    
    var dismissLoadingView: Signal<Void>
    
    var filterviewModel = FilterViewModel()
    
    var searchController = SearchViewModel()
    
    init() {
        
    }
    
}
