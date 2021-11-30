import UIKit
import SnapKit

class AssistantViewController: UIViewController {
    
    let myRecipeButton = UIButton()
    let myBarButton = UIButton()
    let wishListButton = UIButton()
    let mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        myRecipeButton.addAction(UIAction(handler: {[weak self] _ in
            let myOwnCocktailRecipeViewController = MyOwnCocktailRecipeViewController()
            self?.show(myOwnCocktailRecipeViewController, sender: nil)
        }), for: .touchUpInside)
        
        myBarButton.addAction(UIAction(handler: {[weak self] _ in
            let homeBarViewController = MyDrinksViewController()
            self?.show(homeBarViewController, sender: nil)
        }), for: .touchUpInside)
        wishListButton.addAction(UIAction(handler: {[weak self] _ in
            let wishListCocktailListTableView = WishListCocktailListTableView()
            var recipe: [Cocktail] = []
            recipe = getRecipe()
            wishListCocktailListTableView.wishListRecipe = recipe.filter { $0.wishList == true }
            self?.show(wishListCocktailListTableView, sender: nil)
        }), for: .touchUpInside)
        
        myRecipeButton.backgroundColor = .blue
        myRecipeButton.setTitle("My Recipes".localized, for: .normal)
        myBarButton.backgroundColor = .red
        myBarButton.setTitle("My Drinks".localized, for: .normal)
        wishListButton.setTitle("Bookmark".localized, for: .normal)
        wishListButton.backgroundColor = .systemPink
    }
    
    func layout() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(myRecipeButton)
        mainStackView.addArrangedSubview(myBarButton)
        mainStackView.addArrangedSubview(wishListButton)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(300)
        }
    }
}
