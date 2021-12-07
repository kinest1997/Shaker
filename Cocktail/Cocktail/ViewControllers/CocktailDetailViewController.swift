import UIKit
import SnapKit
import Kingfisher

class CocktailDetailViewController: UIViewController {
    
    var cocktailData: Cocktail?
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let cocktailImageView = UIImageView()
    
    let englishNameLabel = UILabel()
    let nameLabel = UILabel()
    
    let alcoholGuideLabel = UILabel()
    let lowAlcoholLabel = UILabel()
    let midAlcoholLabel = UILabel()
    let highAlcoholLabel = UILabel()
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
        navigationController?.navigationBar.isHidden = false
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        mainView.addSubview(nameLabel)
        mainView.addSubview(englishNameLabel)
        
        mainView.addSubview(alcoholLabel)
        mainView.addSubview(alcoholGuideLabel)
        mainView.addSubview(alcoholStackView)
        
        [groupStackView, cocktailImageView, likeButton].forEach {
            mainView.addSubview($0)
        }
        
        alcoholStackView.addArrangedSubview(lowAlcoholLabel)
        alcoholStackView.addArrangedSubview(midAlcoholLabel)
        alcoholStackView.addArrangedSubview(highAlcoholLabel)
        
        alcoholStackView.distribution = .fillEqually
        alcoholStackView.alignment = .center
        alcoholStackView.spacing = 20
        
        [lowAlcoholLabel ,midAlcoholLabel, highAlcoholLabel].forEach {
            $0.backgroundColor = .brown
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        
        alcoholStackView.snp.makeConstraints {
            $0.height.equalTo(nameLabel)
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(englishNameLabel.snp.bottom).offset(5)
        }
        
        alcoholGuideLabel.snp.makeConstraints {
            $0.centerY.equalTo(alcoholStackView)
            $0.height.equalTo(alcoholStackView)
            $0.width.equalTo(50)
            $0.trailing.equalTo(alcoholStackView.snp.leading).offset(5)
        }
        
        alcoholLabel.snp.makeConstraints {
            $0.centerY.equalTo(alcoholStackView)
            $0.height.equalTo(alcoholStackView)
            $0.width.equalTo(50)
            $0.leading.equalTo(alcoholStackView.snp.trailing).offset(5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalToSuperview()
        }
        
        englishNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalToSuperview()
        }
        
        mainScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            //나중에 스택뷰 추가하면 이 높이 고정시킨거 해제하기
            $0.height.equalTo(1000)
//            $0.bottom.equalTo(groupStackView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(likeButton.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(300)
        }
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        
        nameLabel.textAlignment = .center
        englishNameLabel.textAlignment = .center
        
        groupStackView.axis = .vertical
        groupStackView.backgroundColor = .brown
        groupStackView.distribution = .fill
        groupStackView.spacing = 20
        
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
                self.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                guard let number = FirebaseRecipe.shared.wishList.firstIndex(of: bindedCocktailData) else { return }
                FirebaseRecipe.shared.wishList.remove(at: number)
                self.cocktailData?.wishList = false
            } else {
                self.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
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
        englishNameLabel.text = data.name
        alcoholLabel.text = data.alcohol.rawValue.localized
        colorLabel.text = data.color.rawValue.localized
        baseDrinkLabel.text = data.base.rawValue.localized
        glassLabel.text = data.glass.rawValue.localized
        craftLabel.text = data.craft.rawValue.localized
        myTipLabel.text = data.mytip.localized
        recipeLabel.text = makeRecipeText(recipe: data.recipe)
        ingredientsLabel.text = makeIngredientsText(ingredients: data.ingredients)
        cocktailImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(systemName: "heart"))
        
        var justRecipe = data
        justRecipe.wishList = true
        
        var wishListData = FirebaseRecipe.shared.wishList
        wishListData.indices.forEach { wishListData[$0].wishList = true }
        
        if wishListData.contains(justRecipe) {
            self.cocktailData = justRecipe
            likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.cocktailData = data
            likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func makeRecipeText(recipe: [String]) -> String {

        let spaceStrings = recipe.enumerated().map {
            """
            
            step\($0.offset + 1)
            \($0.element.localized)
            
            """
        }
        
        let fullString = spaceStrings.reduce("") { $0 + $1 }
        return fullString
    }
    
    func makeIngredientsText(ingredients: [Cocktail.Ingredients]) -> String {

        let spaceStrings = ingredients.enumerated().map {
            """
            
            \($0.offset + 1)  \($0.element.rawValue.localized)
            
            
            """
        }
        
        let fullString = spaceStrings.reduce("") { $0 + $1 }
        return fullString
    }
}
