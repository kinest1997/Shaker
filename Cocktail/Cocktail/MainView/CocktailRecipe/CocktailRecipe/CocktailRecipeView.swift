//
//  RxCocktailRecipeView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import UIKit
import RxAppState
import RxCocoa
import RxSwift
import SnapKit
import RxDataSources

protocol CocktailRecpeViewBindable {
    //    view -> ViewModel
    var filterButtonTapped: PublishRelay<Void> { get }
    var arrangeButtonTapped: PublishRelay<Void> { get }
    var filterRecipe: PublishRelay<SortingStandard> { get }
    var viewDidAppear: PublishRelay<Void> { get }
    var cellTapped: PublishRelay<IndexPath> { get }

    //    viewModel -> view
    var sortedRecipe: Driver<[Cocktail]> { get }
    var dismissLoadingView: Signal<Bool> { get }
    var showDetailview: Signal<Cocktail> { get }
    var filterViewIsHidden: Signal<Bool> { get }

    // viewModel
    var filterviewModel: FilterViewModel { get }
    var searchViewModel: SearchViewModel { get }
}

class CocktailRecipeViewController: UIViewController {

    let loadingView = LoadingView()

    var filterView = FilteredView()

    let searchBar = SearchController(nibName: nil, bundle: nil)

    let tableView = UITableView()

    let filterButton = UIBarButtonItem(title: "Filter".localized, style: .plain, target: nil, action: nil)

    var leftarrangeButton: UIBarButtonItem { UIBarButtonItem(title: "Sorting".localized, image: nil, primaryAction: nil, menu: filterMenu) }

    var filterMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: filtertMenuItems)
    }

    let disposeBag = DisposeBag()

    var filterOption = PublishSubject<SortingStandard>()

    var filtertMenuItems: [UIAction] {
        return [
            UIAction(title: "Name".localized, state: .on, handler: {[weak self] _ in
                guard let self = self else { return }
                self.filterOption.onNext(SortingStandard.name)
            }),
            UIAction(title: "Alcohol".localized, state: .off, handler: {[weak self] _ in
                guard let self = self else { return }
                self.filterOption.onNext(SortingStandard.alcohol)
            }),
            UIAction(title: "Ingredients".localized, state: .off, handler: {[weak self] _ in
                guard let self = self else { return }
                self.filterOption.onNext(SortingStandard.ingredientsCount)
            })
        ]
    }

    // 메뉴를 선택할때마다 특정값을 바꾼다. 그값을 옵저빙 하는것을 넘겨준다.

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }

    func bind(_ viewModel: CocktailRecpeViewBindable) {
        self.searchBar.bind(viewModel.searchViewModel)
        self.filterView.bind(viewModel.filterviewModel)

        self.filterButton.rx.tap
            .bind(to: viewModel.filterButtonTapped)
            .disposed(by: disposeBag)

        self.leftarrangeButton.rx.tap
            .bind(to: viewModel.arrangeButtonTapped)
            .disposed(by: disposeBag)

        self.rx.viewDidLoad
            .map { _ in Void() }
            .bind(to: viewModel.viewDidAppear)
            .disposed(by: disposeBag)

        self.filterOption
            .bind(to: viewModel.filterRecipe)
            .disposed(by: disposeBag)

        self.tableView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)

        viewModel.showDetailview
            .emit(to: self.rx.showDetailView)
            .disposed(by: disposeBag)

        viewModel.filterViewIsHidden
            .emit(to: self.filterView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.dismissLoadingView
            .emit(to: self.loadingView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.sortedRecipe
            .drive(self.tableView.rx.items(cellIdentifier: "CocktailListCell", cellType: CocktailListCell.self)) { _, cocktail, cell in
                cell.configure(data: cocktail)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }

    func layout() {
        navigationController?.view.addSubview(filterView)
        [tableView, loadingView].forEach { view.addSubview($0) }
        [tableView, loadingView, filterView].forEach { $0.snp.makeConstraints { $0.edges.equalToSuperview()} }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        filterView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func attribute() {
        title = "Recipe".localized
        filterView.isHidden = true

        navigationItem.do {
            $0.hidesSearchBarWhenScrolling = false
            $0.rightBarButtonItem = filterButton
            $0.leftBarButtonItem = leftarrangeButton
            $0.searchController = searchBar
        }

        tableView.do {
            $0.backgroundColor = .white
            $0.rowHeight = 100
            $0.register(CocktailListCell.self, forCellReuseIdentifier: "CocktailListCell")
        }

        loadingView.do {
            $0.isHidden = false
            $0.explainLabel.text = "로딩중"
        }
    }
}