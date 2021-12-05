import UIKit
import SnapKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class MyOwnCocktailRecipeViewController: UIViewController {
    
    var myOwnRecipe: [Cocktail] = []
    
    lazy var addMyOwnCocktailRecipeViewController = AddMyOwnCocktailRecipeViewController()
    
    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myOwnRecipe = FirebaseRecipe.shared.myRecipe
        
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
            FirebaseRecipe.shared.myRecipe.append(data)
            FirebaseRecipe.shared.uploadMyRecipe()
            self.mainTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myOwnRecipe = FirebaseRecipe.shared.myRecipe
        mainTableView.reloadData()
    }
    
    @objc func showAddView() {
        addMyOwnCocktailRecipeViewController.choiceView.havePresetData = false
        addMyOwnCocktailRecipeViewController.textFieldArray.append(UITextField())
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktailData = myOwnRecipe[indexPath.row]
        let cocktailDetailViewController = CocktailDetailViewController()
        cocktailDetailViewController.setData(data: cocktailData)
        self.show(cocktailDetailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let number = FirebaseRecipe.shared.myRecipe.firstIndex(of: myOwnRecipe[indexPath.row]) else { return }
            
            //내가 가진 레시피가 wishlist에도 추가되어있다면 myrecipe를 삭제할때도 wishlist에서도 동시에 삭제되도록 해주는코드
            var recipeData = myOwnRecipe[indexPath.row]
            recipeData.wishList = true
            if FirebaseRecipe.shared.wishList.contains(recipeData) {
                guard let wishNumber = FirebaseRecipe.shared.wishList.firstIndex(of: recipeData) else { return }
                FirebaseRecipe.shared.wishList.remove(at: wishNumber)
                FirebaseRecipe.shared.uploadWishList()
            }
            
            //나의 레시피가 가진 주소값을 이용하여 Storage 의 데이터를 삭제하는 코드
            let storage = Storage.storage()
            guard let url = myOwnRecipe[indexPath.row].imageURL else { return }
            let storageRef = storage.reference(forURL: url)
            
            storageRef.delete { error in
                if let error = error{
                    print(error)
                }
            }
            
            FirebaseRecipe.shared.myRecipe.remove(at: number)
            FirebaseRecipe.shared.uploadMyRecipe()
            myOwnRecipe = FirebaseRecipe.shared.myRecipe
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
