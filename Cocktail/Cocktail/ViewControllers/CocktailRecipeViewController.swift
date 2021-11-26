import UIKit
import SnapKit

class CocktailRecipeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)

    var unTouchableRecipe: [Cocktail] = []
    var originRecipe: [Cocktail] = []
    var filteredRecipe: [Cocktail] = []

    lazy var filterView = FilteredView()

    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        getRecipe(data: &unTouchableRecipe)
        originRecipe = unTouchableRecipe
        filteredRecipe = originRecipe
        mainTableView.delegate = self
        mainTableView.dataSource = self
        title = "Recipe".localized
        
        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        //서치바의 텍스트가 변경되는것을 알려준다.
        searchController.obscuresBackgroundDuringPresentation = false
        // 표시된 뷰를 흐리게 해주는것
        searchController.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
        navigationItem.searchController = searchController
        //네비게이션바에 서치바 추가하는것
        definesPresentationContext = true
        //화면 이동시에 서치바가 안남아있게 해줌
        searchController.searchBar.keyboardType = .default
        let filterButton = UIBarButtonItem(title: "Filter".localized, style: .plain, target: self, action: #selector(filtering))
        navigationItem.rightBarButtonItem = filterButton
        let leftarrangeButton = UIBarButtonItem(title: "Sort".localized, style: .plain, target: self, action: #selector(arrangement))
        navigationItem.leftBarButtonItem = leftarrangeButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipe(data: &unTouchableRecipe)
        mainTableView.reloadData()
    }
    
    func layout() {
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        filterView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(100)
        }
    }
    
    func attribute() {
        view.addSubview(mainTableView)
        navigationController?.view.addSubview(filterView)
        filterView.isHidden = true
        filterView.saveButton.setTitle("Save".localized, for: .normal)
        filterView.resetButton.setTitle("Reset".localized, for: .normal)
        
        //저장 버튼의 액션
        filterView.saveButton.addAction(UIAction(handler: {[unowned self]_ in
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
        filterView.resetButton.addAction(UIAction(handler: { [unowned self]_ in
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
    
    @objc func filtering() {
        filterView.nowFiltering = true
        filterView.isHidden = false
        mainTableView.reloadData()
    }
    
    @objc func arrangement() {
        filteredRecipe = filteredRecipe.sorted { $0.name < $1.name}
    }
}

extension CocktailRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    //테이블뷰에 관한것
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isFiltering() && filterView.nowFiltering) || isFiltering() {
            return filteredRecipe.count
        } else if filterView.nowFiltering {
            return originRecipe.count
        }
        return unTouchableRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath) as? CocktailListCell else { return UITableViewCell() }
        
        cell.accessoryType = .disclosureIndicator
        
        if (isFiltering() && filterView.nowFiltering) || isFiltering(){
            cell.configure(data: filteredRecipe[indexPath.row])
            return cell
        } else if filterView.nowFiltering {
            cell.configure(data: originRecipe[indexPath.row])
            return cell
        } else {
            cell.configure(data: unTouchableRecipe[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isFiltering() && filterView.nowFiltering) || isFiltering() {
            sendData(recipe: filteredRecipe[indexPath.row])
        } else if filterView.nowFiltering {
            sendData(recipe: originRecipe[indexPath.row])
        }
        else {
            sendData(recipe: unTouchableRecipe[indexPath.row])
        }
    }
    
    func sendData(recipe: Cocktail) {
        let cocktailData = recipe
        let cocktailDetailViewController = CocktailDetailViewController()
        cocktailDetailViewController.setData(data: cocktailData)
        cocktailDetailViewController.cocktailData = cocktailData
        self.show(cocktailDetailViewController, sender: nil)
    }
}

extension CocktailRecipeViewController: UISearchResultsUpdating {
    //서치바에 관한것
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func isFiltering() -> Bool {
        return (searchController.isActive && !searchBarIsEmpty())
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let filterRecipe = originRecipe
        filteredRecipe = filterRecipe.filter({
            return $0.name.contains(searchText) || $0.mytip.contains(searchText) || $0.ingredients.map({ baby in
                baby.rawValue
            })[0...].contains(searchText) || $0.glass.rawValue.contains(searchText) || $0.color.rawValue.contains(searchText) || $0.recipe.contains(searchText)
        })
        mainTableView.reloadData()
    }
}
