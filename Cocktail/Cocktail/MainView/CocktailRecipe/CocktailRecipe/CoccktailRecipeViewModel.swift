//
//  CoccktailRecipeViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/20.
//

import Foundation
import RxCocoa
import RxSwift
import Differentiator
import RxDataSources

struct CocktailRecipeViewModel: CocktailRecpeViewBindable {
    
    //view -> viewModel
    var cellTapped = PublishRelay<IndexPath>()
    
    var filterButtonTapped = PublishRelay<Void>()
    
    var arrangeButtonTapped = PublishRelay<Void>()
    
    var filterRecipe = PublishSubject<SortingStandard>()
    
    var viewWillAppear = PublishSubject<Void>()
    
    //viewModel - > view
    
    var showDetailview: Signal<Cocktail>
    
    var dismissLoadingView: Signal<Void>
    
    var sortedRecipe: Driver<[Cocktail]>
    
    var dismissFilterView: Signal<Void>
    
    var showFilterView: Signal<Void>
    
    //only here
    var nowShowingRecipes = PublishSubject<[Cocktail]>()
    
    var filterviewModel = FilterViewModel()
    
    var searchViewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    init(model: CocktailRecipeModel = CocktailRecipeModel()) {
        
        let firstRecipe = viewWillAppear
            .flatMapLatest { _ in
                model.getRecipeRx()
            }
        
        viewWillAppear
            .bind(to: filterviewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        //텍스트 아웃풋을 가져오고 초기값을 줌
        let textOutput = searchViewModel.outPuts
            .asObservable()
            .startWith("")
        
        //레시피 정렬 옵션에 초기값을 줌 onnext로 viewdidload안에 넣었는데 그건좀 별로라 여기로 옮김
        let filterOptionTapped = filterRecipe
            .startWith(.name)
        
        //최종적으로 검색, 필터링, 정렬을 종합해서 레시피 목록
        let finalResultRecipes = Observable.combineLatest(firstRecipe, filterviewModel.conditionsOfCocktail, textOutput, filterOptionTapped){ recipe, conditions, searchText, sortingStandard -> [Cocktail] in
            
            let filteredRecipe = model.sortingRecipes(
                origin: recipe,
                alcohol: conditions[0].condition as! [Cocktail.Alcohol],
                base: conditions[1].condition as! [Cocktail.Base],
                drinktype: conditions[2].condition as! [Cocktail.DrinkType],
                craft: conditions[3].condition as! [Cocktail.Craft],
                glass: conditions[4].condition as! [Cocktail.Glass],
                color: conditions[5].condition as! [Cocktail.Color]
            ).sorted { $0.name < $1.name }
            
            if searchText != "" {
                let searchedRecipe = filteredRecipe.filter({
                    return $0.name.localized.lowercased().contains(searchText) || $0.ingredients.map({ baby in
                        baby.rawValue.localized.lowercased()
                    })[0...].contains(searchText) ||  $0.recipe.contains(searchText)
                })
                return model.sorting(standard: sortingStandard, recipe: searchedRecipe)
            } else {
                return model.sorting(standard: sortingStandard, recipe: filteredRecipe)
            }
        }
        //시작하자마자 맨처음에 기본적으로 레시피를 보여주고, 필터링된 레시피를 이후에 보여줌
        let nowRecipe = Observable.merge(finalResultRecipes, firstRecipe)
        
        nowRecipe
            .bind(to: nowShowingRecipes)
            .disposed(by: disposeBag)
        
        sortedRecipe = nowRecipe
            .asDriver(onErrorDriveWith: .empty())
        
        //필터뷰를 숨겨줌
        dismissFilterView = filterviewModel.dismissFilterView
        
        //필터뷰를 보여줌
        showFilterView = filterButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        //필터를 보여주는 버튼을 눌렀을때 보여줌
        filterButtonTapped
            .bind(to: filterviewModel.showFilterView)
            .disposed(by: disposeBag)
        
        //첫 레시피 로딩다하면 로딩뷰 사라지게해줌
        dismissLoadingView = firstRecipe
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        showDetailview = cellTapped.withLatestFrom(nowShowingRecipes) { indexPath, recipes in
            recipes[indexPath.row]
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}
