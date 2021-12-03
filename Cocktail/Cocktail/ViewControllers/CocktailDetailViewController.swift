import UIKit
import SnapKit
import Kingfisher

class CocktailDetailViewController: UIViewController {
    
    var cocktailData: Cocktail?
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let cocktailImageView = UIImageView()
    
    let nameGuideLabel = UILabel()
    let nameLabel = UILabel()
    
    let alcoholGuideLabel = UILabel()
    let alcoholLabel = UILabel()
    
    let colorGuideLabel = UILabel()
    let colorLabel = UILabel()
    
    let baseDrinkGuideLabel = UILabel()
    let baseDrinkLabel = UILabel()
    
    let glassGuideLabel = UILabel()
    let glassLabel = UILabel()
    
    let craftGuideLabel = UILabel()
    let craftLabel = UILabel()
    
    let recipeGuideLabel = UILabel()
    let recipeLabel = UILabel()
    
    let myTipGuideLabel = UILabel()
    let myTipLabel = UILabel()
    
    let ingredientsGuideLabel = UILabel()
    let ingredientsLabel = UILabel()
    
    let nameStackView =  UIStackView()
    let alcoholStackView = UIStackView()
    let colorStackView = UIStackView()
    let baseDrinkStackView = UIStackView()
    let glassStackView = UIStackView()
    let craftStackView = UIStackView()
    let recipeStackView = UIStackView()
    let mytipStackView = UIStackView()
    let ingredientsStackView = UIStackView()
    let groupStackView = UIStackView()
    
    let likeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        let editingButton = UIBarButtonItem(title: "editing".localized, style: .done, target: self, action: #selector(startEditing))
        navigationItem.rightBarButtonItem = editingButton
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        [groupStackView, cocktailImageView, likeButton].forEach {
            mainView.addSubview($0)
        }
        
        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, glassStackView, craftStackView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(30)
            }
        }
        
        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, glassStackView, craftStackView, ingredientsStackView, recipeStackView, mytipStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
        }
        
        [nameGuideLabel, alcoholGuideLabel, colorGuideLabel, baseDrinkGuideLabel, glassGuideLabel, craftGuideLabel, recipeGuideLabel, myTipGuideLabel, ingredientsGuideLabel].forEach {
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
        }
        
        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, recipeLabel, myTipLabel, ingredientsLabel].forEach {
            $0.textAlignment = .left
            $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
            $0.backgroundColor = .blue
            $0.numberOfLines = 0
        }
        
        nameStackView.addArrangedSubview(nameGuideLabel)
        nameStackView.addArrangedSubview(nameLabel)
        
        alcoholStackView.addArrangedSubview(alcoholGuideLabel)
        alcoholStackView.addArrangedSubview(alcoholLabel)
        
        colorStackView.addArrangedSubview(colorGuideLabel)
        colorStackView.addArrangedSubview(colorLabel)
        
        baseDrinkStackView.addArrangedSubview(baseDrinkGuideLabel)
        baseDrinkStackView.addArrangedSubview(baseDrinkLabel)
        
        glassStackView.addArrangedSubview(glassGuideLabel)
        glassStackView.addArrangedSubview(glassLabel)
        
        craftStackView.addArrangedSubview(craftGuideLabel)
        craftStackView.addArrangedSubview(craftLabel)
        
        recipeStackView.addArrangedSubview(recipeGuideLabel)
        recipeStackView.addArrangedSubview(recipeLabel)
        
        mytipStackView.addArrangedSubview(myTipGuideLabel)
        mytipStackView.addArrangedSubview(myTipLabel)
        
        ingredientsStackView.addArrangedSubview(ingredientsGuideLabel)
        ingredientsStackView.addArrangedSubview(ingredientsLabel)
        
        mainScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.bottom.equalTo(groupStackView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(50)
            $0.bottom.equalTo(cocktailImageView.snp.top)
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(30)
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        groupStackView.axis = .vertical
        groupStackView.backgroundColor = .brown
        groupStackView.distribution = .fill
        groupStackView.spacing = 20
        nameGuideLabel.text = "Name".localized
        alcoholGuideLabel.text = "Alcohol".localized
        colorGuideLabel.text = "Color".localized
        baseDrinkGuideLabel.text = "Base".localized
        glassGuideLabel.text = "Glass".localized
        craftGuideLabel.text = "Craft".localized
        recipeGuideLabel.text = "Recipe".localized
        myTipGuideLabel.text = "Tip".localized
        ingredientsGuideLabel.text = "Ingredients".localized
        
        likeButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self,
                  let bindedCocktailData = self.cocktailData else { return }
            if FirebaseRecipe.shared.wishList.contains(bindedCocktailData) {
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                guard let number = FirebaseRecipe.shared.wishList.firstIndex(of: bindedCocktailData) else { return }
                FirebaseRecipe.shared.wishList.remove(at: number)
                self.cocktailData?.wishList = false
            } else {
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                var data = bindedCocktailData
                data.wishList = true
                FirebaseRecipe.shared.wishList.append(data)
                self.cocktailData?.wishList = true
            }
            FirebaseRecipe.shared.uploadWishList()
        }), for: .touchUpInside)
    }
    
    @objc func startEditing() {
        guard let cocktailData = cocktailData else { return }
        let addMyOwnCocktailRecipeViewController = AddMyOwnCocktailRecipeViewController()
        addMyOwnCocktailRecipeViewController.editing(data: cocktailData)
        addMyOwnCocktailRecipeViewController.beforeEditingData = cocktailData
        addMyOwnCocktailRecipeViewController.choiceView.myIngredients = cocktailData.ingredients
        addMyOwnCocktailRecipeViewController.cocktailImageView.image = cocktailImageView.image
        addMyOwnCocktailRecipeViewController.choiceView.havePresetData = true
        show(addMyOwnCocktailRecipeViewController, sender: nil)
    }
    
    func setData(data: Cocktail) {
        nameLabel.text = data.name.localized
        alcoholLabel.text = data.alcohol.rawValue.localized
        colorLabel.text = data.color.rawValue.localized
        baseDrinkLabel.text = data.base.rawValue.localized
        glassLabel.text = data.glass.rawValue.localized
        craftLabel.text = data.craft.rawValue.localized
        recipeLabel.text = data.recipe.localized
        myTipLabel.text = data.mytip.localized
        ingredientsLabel.text = data.ingredients.map {$0.rawValue.localized}.joined(separator: ", ")
        
        cocktailImageView.kf.setImage(with: URL(string: data.imageURL ?? ""), placeholder: UIImage(systemName: "heart"))
        
        var justRecipe = data
        justRecipe.wishList = true
        
        var wishListData = FirebaseRecipe.shared.wishList
        wishListData.indices.forEach { wishListData[$0].wishList = true }
        
        if wishListData.contains(justRecipe) {
            self.cocktailData = justRecipe
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.cocktailData = data
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
