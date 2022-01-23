//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//import RxAppState
//
//class CocktailRecipeViewController123: UIViewController {
//    
//    let searchController = UISearchController(searchResultsController: nil)
//    var unTouchableRecipe: [Cocktail] = []
//    var originRecipe: [Cocktail] = []
//    var filteredRecipe: [Cocktail] = []
//    
//    let loadingView = LoadingView()
//    
//    let filterView = FilteredView()
//    
//    var likeData: [String:[String: Bool]]?
//    
//    let mainTableView = UITableView()
//    
//    var filtertMenuItems: [UIAction] {
//        return [
//            UIAction(title: "Name".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .name)}),
//            UIAction(title: "Alcohol".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .alcohol)}),
//            UIAction(title: "Ingredients Count".localized, state: .off, handler: {[unowned self] _ in sorting(standard: .ingredientsCount)})
//        ]
//    }
//    
//    var filterMenu: UIMenu {
//        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: filtertMenuItems)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadingView.isHidden = false
//        attribute()
//        layout()
//        unTouchableRecipe = FirebaseRecipe.shared.recipe
//        originRecipe = unTouchableRecipe
//        filteredRecipe = originRecipe
//        title = "Recipe".localized
//        
//        
//        
//        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
//        
//        navigationItem.hidesSearchBarWhenScrolling = false
//        //서치바의 텍스트가 변경되는것을 알려준다.
//        searchController.obscuresBackgroundDuringPresentation = false
//        // 표시된 뷰를 흐리게 해주는것
//        searchController.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
//        
//        navigationItem.searchController = searchController
//        
//        searchController.searchBar.searchTextField.font = .nexonFont(ofSize: 14, weight: .semibold)
//        //네비게이션바에 서치바 추가하는것
//        definesPresentationContext = true
//        //화면 이동시에 서치바가 안남아있게 해줌
//        searchController.searchBar.keyboardType = .default
//
//        let filterButton = UIBarButtonItem(title: "Filter".localized, style: .plain, target: nil, action: nil)
//        let leftarrangeButton = UIBarButtonItem(title: "Sorting".localized, image: nil, primaryAction: nil, menu: filterMenu)
//        
//        navigationItem.rightBarButtonItem = filterButton
//        navigationItem.leftBarButtonItem = leftarrangeButton
//        
//        FirebaseRecipe.shared.getCocktailLikeData {[weak self] data in
//            self?.likeData = data
//            self?.loadingView.isHidden = true
//            self?.mainTableView.reloadData()
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        unTouchableRecipe = FirebaseRecipe.shared.recipe
//        unTouchableRecipe.sort { $0.name < $1.name }
//        mainTableView.reloadData()
//    
//    }
//    
//    
//    func layout() {
//        view.addSubview(mainTableView)
//        navigationController?.view.addSubview(filterView)
//        view.addSubview(loadingView)
//        mainTableView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        loadingView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        filterView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//    
//    func attribute() {
//        filterView.isHidden = true
//        mainTableView.backgroundColor = .white
//    }
//}
//
//
////extension Reactive where Base: UIMenu {
////    var selectedItem: Binder<Int> {
////        return Binder(base) { base, int in
////            base.
////        }
////    }
////}
//
