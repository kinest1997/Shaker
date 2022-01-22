import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxAppState

class CocktailRecipeViewController123: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var unTouchableRecipe: [Cocktail] = []
    var originRecipe: [Cocktail] = []
    var filteredRecipe: [Cocktail] = []
    
    let loadingView = LoadingView()
    
    let filterView = FilteredView()
    
    var likeData: [String:[String: Bool]]?
    
    let mainTableView = UITableView()
    
    var filtertMenuItems: [UIAction] {
        return [
            UIAction(title: "Name".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .name)}),
            UIAction(title: "Alcohol".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .alcohol)}),
            UIAction(title: "Ingredients Count".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .ingredientsCount)})
        ]
    }
    
    var filterMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: filtertMenuItems)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        attribute()
        layout()
        unTouchableRecipe = FirebaseRecipe.shared.recipe
        originRecipe = unTouchableRecipe
        filteredRecipe = originRecipe
        title = "Recipe".localized
        
        
        
        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
        
        navigationItem.hidesSearchBarWhenScrolling = false
        //서치바의 텍스트가 변경되는것을 알려준다.
        searchController.obscuresBackgroundDuringPresentation = false
        // 표시된 뷰를 흐리게 해주는것
        searchController.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.searchTextField.font = .nexonFont(ofSize: 14, weight: .semibold)
        //네비게이션바에 서치바 추가하는것
        definesPresentationContext = true
        //화면 이동시에 서치바가 안남아있게 해줌
        searchController.searchBar.keyboardType = .default

        let filterButton = UIBarButtonItem(title: "Filter".localized, style: .plain, target: self, action: #selector(filtering))
        let leftarrangeButton = UIBarButtonItem(title: "Sorting".localized, image: nil, primaryAction: nil, menu: filterMenu)
        
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.leftBarButtonItem = leftarrangeButton
        
        FirebaseRecipe.shared.getCocktailLikeData {[weak self] data in
            self?.likeData = data
            self?.loadingView.isHidden = true
            self?.mainTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unTouchableRecipe = FirebaseRecipe.shared.recipe
        unTouchableRecipe.sort { $0.name < $1.name }
        mainTableView.reloadData()
    
    }
    
    
    func layout() {
        view.addSubview(mainTableView)
        navigationController?.view.addSubview(filterView)
        view.addSubview(loadingView)
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        filterView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func attribute() {
        filterView.isHidden = true
        mainTableView.backgroundColor = .white
        //저장 버튼의 액션
        filterView.cancleButton.addAction(UIAction(handler: {[weak self] _ in
            self?.filterView.isHidden = true
        }), for: .touchUpInside)
        
        filterView.saveButton.addAction(UIAction(handler: {[unowned self] _ in
            self.filterView.isHidden = true
            let filteredViewRecipe = filterView.sortingRecipes(
                origin: unTouchableRecipe,
                alcohol: filterView.conditionsOfCocktail[0].condition as! [Cocktail.Alcohol],
                base: filterView.conditionsOfCocktail[1].condition as! [Cocktail.Base],
                drinktype: filterView.conditionsOfCocktail[2].condition as! [Cocktail.DrinkType],
                craft: filterView.conditionsOfCocktail[3].condition as! [Cocktail.Craft],
                glass: filterView.conditionsOfCocktail[4].condition as! [Cocktail.Glass],
                color: filterView.conditionsOfCocktail[5].condition as! [Cocktail.Color]
            ).sorted { $0.name < $1.name }
            self.originRecipe = filteredViewRecipe
            mainTableView.reloadData()
        }), for: .touchUpInside)
        //리셋 버튼의 액션
        filterView.resetButton.addAction(UIAction(handler: {[unowned self] _ in
            self.filterView.cellIsChecked = self.filterView.cellIsChecked.map {
                $0.map { _ in false}
            }
            (0...5).forEach {
                self.filterView.conditionsOfCocktail[$0].condition = []
            }
            self.filterView.nowFiltering = false
            self.filterView.isHidden = true
            self.filterView.mainTableView.reloadData()
            self.mainTableView.reloadData()
        }), for: .touchUpInside)
    }
    
    func sorting(standard: SortingStandard) {
        switch standard {
        case .alcohol:
            unTouchableRecipe = unTouchableRecipe.sorted { $0.alcohol.rank < $1.alcohol.rank}
            originRecipe = originRecipe.sorted { $0.alcohol.rank < $1.alcohol.rank}
            filteredRecipe = filteredRecipe.sorted { $0.alcohol.rank < $1.alcohol.rank}
        case .name:
            unTouchableRecipe = unTouchableRecipe.sorted { $0.name < $1.name }
            originRecipe = originRecipe.sorted { $0.name < $1.name }
            filteredRecipe = filteredRecipe.sorted { $0.name < $1.name }
        case .ingredientsCount:
            unTouchableRecipe = unTouchableRecipe.sorted { $0.ingredients.count < $1.ingredients.count}
            originRecipe = originRecipe.sorted { $0.ingredients.count < $1.ingredients.count}
            filteredRecipe = filteredRecipe.sorted { $0.ingredients.count < $1.ingredients.count}
        default:
            return
        }
        mainTableView.reloadData()
    }
    
    @objc func filtering() {
        filterView.nowFiltering = true
        filterView.isHidden = false
        mainTableView.reloadData()
    }
    
    @objc func arrangement() {
        filteredRecipe = filteredRecipe.sorted { $0.name < $1.name}
    }
}


//extension Reactive where Base: UIMenu {
//    var selectedItem: Binder<Int> {
//        return Binder(base) { base, int in
//            base.
//        }
//    }
//}

