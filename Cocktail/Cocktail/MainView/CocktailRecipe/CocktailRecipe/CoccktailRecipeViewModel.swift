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

    // view -> viewModel
    let cellTapped = PublishRelay<IndexPath>()

    let filterButtonTapped = PublishRelay<Void>()

    let arrangeButtonTapped = PublishRelay<Void>()

    let filterRecipe = PublishRelay<SortingStandard>()

    let viewDidAppear = PublishRelay<Void>()

    // viewModel - > view

    let showDetailview: Signal<Cocktail>

    let filterViewIsHidden: Signal<Bool>

    let dismissLoadingView: Signal<Bool>

    let sortedRecipe: Driver<[Cocktail]>

    let filterviewModel = FilterViewModel()

    let searchViewModel = SearchViewModel()

    // only here
    private let nowShowingRecipes = PublishSubject<[Cocktail]>()

    private let disposeBag = DisposeBag()

    init(model: CocktailRecipeModel = CocktailRecipeModel()) {

        let firstRecipe = viewDidAppear
            .flatMapLatest(model.getRecipeRx)

        viewDidAppear
            .bind(to: filterviewModel.viewWillAppear)
            .disposed(by: disposeBag)

        // 텍스트 아웃풋을 가져오고 초기값을 줌
        let textOutput = searchViewModel.outPuts
            .asObservable()
            .startWith("")

        // 맨처음에 이름기준으로 정렬
        let filterOptionTapped = filterRecipe
            .startWith(.name)

        // 최종적으로 검색, 필터링, 정렬을 종합해서 레시피 목록
        let finalResultRecipes = Observable
            .combineLatest(firstRecipe,
                           filterviewModel.conditionsOfCocktail,
                           textOutput,
                           filterOptionTapped
            ) { recipe, conditions, searchText, sortingStandard -> [Cocktail] in

                let filteredRecipe = model.filteredRecipe(conditions: conditions, recipe: recipe)

                if searchText != "" {
                    let searchedRecipe =  model.serchedRecipe(filteredRecipe: filteredRecipe, searchText: searchText)
                    return model.sorting(standard: sortingStandard, recipe: searchedRecipe)
                } else {
                    return model.sorting(standard: sortingStandard, recipe: filteredRecipe)
                }
            }
        // 시작하자마자 맨처음에 기본적으로 레시피를 보여주고, 필터링된 레시피를 이후에 보여줌
        let nowRecipe = Observable.merge(finalResultRecipes, firstRecipe)

        nowRecipe
            .bind(to: nowShowingRecipes)
            .disposed(by: disposeBag)

        sortedRecipe = nowRecipe
            .asDriver(onErrorDriveWith: .empty())

        // 필터뷰를 숨겨줌
        let dismissFilterView = filterviewModel.dismissFilterView
            .asObservable()

        // 필터뷰를 보여줌
        let showFilterView = filterButtonTapped
            .asObservable()

        filterViewIsHidden = Observable.merge(
            dismissFilterView.map {_ in true },
            showFilterView.map {_ in false }
        )
            .asSignal(onErrorSignalWith: .empty())

        // 첫 레시피 로딩다하면 로딩뷰 사라지게해줌
        dismissLoadingView = firstRecipe
            .map { _ in true }
            .asSignal(onErrorSignalWith: .empty())

        showDetailview = cellTapped.withLatestFrom(nowShowingRecipes) { indexPath, recipes in
            recipes[indexPath.row]
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}
