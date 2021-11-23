import UIKit
import SnapKit

class MyOwnCocktailRecipeViewController: UIViewController {
    
    var myOwnRecipe: [Cocktail] = []
    
    var originRecipe: [Cocktail] = []
    
    lazy var addMyOwnCocktailRecipeViewController = AddMyOwnCocktailRecipeViewController()
    
    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(data: &originRecipe)
        myOwnRecipe = originRecipe.filter {
            $0.myRecipe == true
        }
        
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "CocktailListCell")
        mainTableView.dataSource = self
        mainTableView.delegate = self
        let rightAddButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(showAddView))
        navigationItem.rightBarButtonItem = rightAddButton
        
        addMyOwnCocktailRecipeViewController.myOwnRecipeData = { data in
            self.originRecipe.append(data)
            self.upload(recipe: self.originRecipe)
            self.mainTableView.reloadData()
            print("xxxx")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipe(data: &originRecipe)
        myOwnRecipe = originRecipe.filter {
            $0.myRecipe == true
        }
        mainTableView.reloadData()
    }
    
    func upload(recipe: [Cocktail]) {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
        do {
            let data = try PropertyListEncoder().encode(recipe)
            try data.write(to: documentURL)
            print(data)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
    
    @objc func showAddView() {
        show(addMyOwnCocktailRecipeViewController, sender: nil)
    }
}

extension MyOwnCocktailRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myOwnRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailListCell") as? CocktailListCell else { return UITableViewCell() }
        cell.configure(data: myOwnRecipe[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cocktailData = myOwnRecipe[indexPath.row]
        let cocktailDetailViewController = CocktailDetailViewController()
        cocktailDetailViewController.setData(data: cocktailData)
        cocktailDetailViewController.cocktailData = cocktailData
        self.show(cocktailDetailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let number = originRecipe.firstIndex(of: myOwnRecipe[indexPath.row]) else { return }
            print(myOwnRecipe.count, "지우기전")
            originRecipe.remove(at: number)
            upload(recipe: originRecipe)
            myOwnRecipe = originRecipe.filter {
                $0.myRecipe == true
            }
            print(myOwnRecipe.count, "현재 갯수")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
}
