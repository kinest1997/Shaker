import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class WishListCocktailListViewController: UITableViewController {
    
    var wishListRecipe: [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmark".localized
        view.backgroundColor = .white
        tableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wishListRecipe = FirebaseRecipe.shared.wishList.sorted { $0.name < $1.name}
        if wishListRecipe.isEmpty {
            let emptyView = EmptyView()
            emptyView.firstLabel.text = "There's no cocktail added".localized
            emptyView.secondLabel.text = "Please add some cocktails".localized
            tableView.tableHeaderView = emptyView
        } else {
            tableView.tableHeaderView = nil
        }
        
        tableView.reloadData()
    }
}

extension WishListCocktailListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListRecipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath) as? CocktailListCell else { return UITableViewCell()}
        cell.configure(data: wishListRecipe[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktailData = wishListRecipe[indexPath.row]
        let cocktailDetailViewController = CocktailDetailViewController()
        cocktailDetailViewController.setData(data: cocktailData)
        self.show(cocktailDetailViewController, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let number = FirebaseRecipe.shared.wishList.firstIndex(of: wishListRecipe[indexPath.row]) else { return }
            FirebaseRecipe.shared.wishList.remove(at: number)
            
            FirebaseRecipe.shared.uploadWishList()
            wishListRecipe = FirebaseRecipe.shared.wishList
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if wishListRecipe.isEmpty {
                let emptyView = EmptyView()
                emptyView.firstLabel.text = "There's no cocktail added".localized
                emptyView.secondLabel.text = "Please add some cocktails".localized
                tableView.tableHeaderView = emptyView
            } else {
                tableView.tableHeaderView = nil
            }
        }
    }
}
