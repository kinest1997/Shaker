import UIKit
import SnapKit

class CocktailRecipeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var unTouchableRecipe: [Cocktail] = []
    
    var originRecipe: [Cocktail] = []
    
    var filteredRecipe: [Cocktail] = []
    
    lazy var filterView = FilteredView()
    
    let saveButton = UIButton()

    let resetButton = UIButton()
    
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
        view.backgroundColor = .systemCyan
        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        //서치바의 텍스트가 변경되는것을 알려준다. 델리게이트 선언같은것 같음
        searchController.obscuresBackgroundDuringPresentation = false
        // 표시된 뷰를 흐리게 해주는것
        searchController.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
        //뭐 그냥 플레이스홀더지뭐
        navigationItem.searchController = searchController
        //네비게이션바에 서치바 추가하는것
        definesPresentationContext = true
        //화면 이동시에 서치바가 안남아있게 해준대
        searchController.searchBar.keyboardType = .default
        //필터 버튼 추가하고싶은데..
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
        saveButton.snp.makeConstraints {
            $0.top.equalTo(filterView.mainTableView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(filterView)
        }
        resetButton.snp.makeConstraints {
            $0.leading.top.equalTo(filterView)
            $0.bottom.equalTo(filterView.mainTableView.snp.top)
            $0.width.equalTo(100)
        }
    }
    
    func attribute() {
        view.addSubview(mainTableView)
        navigationController?.view.addSubview(filterView)
        filterView.addSubview(saveButton)
        filterView.addSubview(resetButton)
        filterView.isHidden = true
        saveButton.addAction(UIAction(handler: {[unowned self]_ in
            self.filterView.isHidden = true
            let filteredViewRecipe = filterView.sortingRecipes(origin: unTouchableRecipe, base: filterView.baseCondition, alcohol: filterView.alcoholCondition, drinktype: filterView.drinkTypeCondition, craft: filterView.craftConditon, glass: filterView.glassCondition, color: filterView.colorCondition).sorted { $0.name < $1.name }
            self.originRecipe = filteredViewRecipe
            mainTableView.reloadData()
        }), for: .touchUpInside)
        saveButton.setTitle("Save".localized, for: .normal)
        resetButton.setTitle("Reset".localized, for: .normal)
        resetButton.addAction(UIAction(handler: { [unowned self]_ in
            self.filterView.cellIsChecked = self.filterView.cellIsChecked.map {
                $0.map { _ in false}
            }
            self.filterView.nowFiltering = false
            self.filterView.isHidden = true
            print(self.filterView.cellIsChecked)
            self.filterView.mainTableView.reloadData()
            self.mainTableView.reloadData()
        }), for: .touchUpInside)
    }
    
    @objc func filtering() {
        filterView.nowFiltering = true
        filterView.isHidden = false
        mainTableView.reloadData()
        print("눌림")
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
        if (isFiltering() && filterView.nowFiltering) || isFiltering(){
            cell.configure(data: filteredRecipe[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            return cell
        } else if filterView.nowFiltering {
            cell.configure(data: originRecipe[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            cell.configure(data: unTouchableRecipe[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isFiltering() && filterView.nowFiltering) || isFiltering() {
            let cocktailData = filteredRecipe[indexPath.row]
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: cocktailData)
            self.show(cocktailDetailViewController, sender: nil)
        } else if filterView.nowFiltering {
            let cocktailData = originRecipe[indexPath.row]
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: cocktailData)
            self.show(cocktailDetailViewController, sender: nil)
        }
        else {
            let cocktailData = unTouchableRecipe[indexPath.row]
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: cocktailData)
            self.show(cocktailDetailViewController, sender: nil)
        }
    }
}

extension CocktailRecipeViewController: UISearchResultsUpdating {
    //서치바에 관한것
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func isFiltering() -> Bool {
        return (searchController.isActive && !searchBarIsEmpty())
        //서치바가 활성화 되어있는지, 그리고 서치바가 비어있지않은지
    }
    
    func searchBarIsEmpty() -> Bool {
        //서치바가 비어있는지 확인하는것
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //만약 넘겨주는 데이터에 아무것도없다면 아래의 코드대로 작동하게 하기.일단 보류
        let filterRecipe = originRecipe
        filteredRecipe = filterRecipe.filter({
            return $0.name.contains(searchText) || $0.mytip.contains(searchText) || $0.ingredients.map({ baby in
                baby.rawValue
            })[0...].contains(searchText) || $0.glass.rawValue.contains(searchText) || $0.color.rawValue.contains(searchText) || $0.recipe.contains(searchText)
        })
        mainTableView.reloadData()
    }
}
