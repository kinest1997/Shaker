import UIKit
import SnapKit
import Kingfisher

class CocktailDetailViewController: UIViewController {
    
    var cocktailData: Cocktail?
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let likeButton = UIButton()
    
    let cocktailImageView = UIImageView()
    
    let nameLabel = UILabel()
    
    let alcoholGuideLabel = UILabel()
    let alcoholStackView = UIStackView()
    let lowAlcoholLabel = UIImageView(image: UIImage(systemName: "heart"))
    let midAlcoholLabel = UIImageView(image: UIImage(systemName: "heart"))
    let highAlcoholLabel = UIImageView(image: UIImage(systemName: "heart"))
    let alcoholLabel = UILabel()
    
    let leftStackView = UIStackView()
    let centerLine = UIView()
    let rightStackView = UIStackView()
    let groupStackView = UIStackView()
    
    let colorGuideLabel = UILabel()
    let colorLabel = UILabel()
    
    let baseDrinkGuideLabel = UILabel()
    let baseDrinkLabel = UILabel()
    
    let glassGuideLabel = UILabel()
    let glassLabel = UILabel()
    
    let craftGuideLabel = UILabel()
    let craftLabel = UILabel()
    
    let drinkTypeLabel = UILabel()
    let drinkTypeGuideLabel = UILabel()
    
    let myTipLabel = UILabel()
    
    let firstSplitLine = UILabel()
    let ingredientsGuideLabel = UILabel()
    let ingredientsLabel = UILabel()
    
    let secondSplitLine = UILabel()
    let recipeGuideLabel = UILabel()
    let recipeLabel = UILabel()
    
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
        
        [nameLabel, alcoholLabel, alcoholGuideLabel, alcoholStackView, ingredientsLabel, ingredientsGuideLabel, firstSplitLine, secondSplitLine, recipeLabel, recipeGuideLabel, myTipLabel].forEach { mainView.addSubview($0) }
        
        [groupStackView, cocktailImageView, likeButton].forEach { mainView.addSubview($0) }
        
        [leftStackView, centerLine, rightStackView].forEach{ groupStackView.addArrangedSubview($0) }
        
        [colorGuideLabel, baseDrinkGuideLabel, drinkTypeGuideLabel, glassGuideLabel, craftGuideLabel].forEach { leftStackView.addArrangedSubview($0) }
        
        [colorLabel, baseDrinkLabel, drinkTypeLabel, glassLabel, craftLabel].forEach { rightStackView.addArrangedSubview($0) }
        
        [lowAlcoholLabel, midAlcoholLabel, highAlcoholLabel].forEach { alcoholStackView.addArrangedSubview($0) }
        
        //위에서부터 아래로 쭉 순서대로 찾으면 됨
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
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalToSuperview()
        }
        
        alcoholStackView.snp.makeConstraints {
            $0.height.equalTo(nameLabel)
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
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
            $0.leading.equalTo(alcoholStackView.snp.trailing)
        }
        
        myTipLabel.snp.makeConstraints {
            $0.top.equalTo(alcoholStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(myTipLabel.snp.bottom).offset(30)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.centerX.equalToSuperview()
        }
        
        centerLine.snp.makeConstraints {
            $0.width.equalTo(1)
        }
        
        firstSplitLine.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(groupStackView.snp.bottom).offset(50)
        }
        
        ingredientsGuideLabel.snp.makeConstraints {
            $0.top.equalTo(firstSplitLine.snp.bottom).offset(50)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        ingredientsLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientsGuideLabel.snp.bottom).offset(50)
            $0.width.equalTo(firstSplitLine)
            $0.centerX.equalToSuperview()
        }
        
        secondSplitLine.snp.makeConstraints {
            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(50)
            $0.width.equalTo(firstSplitLine)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
        }
        
        recipeGuideLabel.snp.makeConstraints {
            $0.top.equalTo(secondSplitLine.snp.bottom).offset(50)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        recipeLabel.snp.makeConstraints {
            $0.top.equalTo(recipeGuideLabel.snp.bottom).offset(30)
            $0.width.equalTo(secondSplitLine)
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
        }
 
        mainScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.bottom.equalTo(recipeLabel.snp.bottom)
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        mainView.backgroundColor = .white
        
        //구분선의 색상 설정
        [centerLine, firstSplitLine, secondSplitLine].forEach {
            $0.backgroundColor = .black
        }
        
        //내용 설정하는곳
        [alcoholLabel, alcoholGuideLabel, myTipLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, ingredientsLabel, recipeLabel, drinkTypeLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        //제목 설정하는곳
        [colorGuideLabel, baseDrinkGuideLabel, glassGuideLabel, craftGuideLabel, drinkTypeGuideLabel, ingredientsGuideLabel, recipeGuideLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        //제일 두꺼운 칵테일 이름 설정
        [nameLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 24, weight: .heavy)
        }
        
        [alcoholLabel, alcoholGuideLabel, myTipLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        [colorLabel, baseDrinkLabel, glassLabel, craftLabel, drinkTypeLabel].forEach {
            $0.textAlignment = .left
        }
        
        [colorGuideLabel, baseDrinkGuideLabel, glassGuideLabel, craftGuideLabel, drinkTypeGuideLabel].forEach {
            $0.textAlignment = .right
        }
        
        [myTipLabel, recipeLabel, ingredientsLabel].forEach {
            $0.sizeToFit()
            $0.numberOfLines = 0
        }
        
        [leftStackView, rightStackView].forEach {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
        
        cocktailImageView.contentMode = .scaleAspectFill
        
        alcoholStackView.distribution = .fillEqually
        alcoholStackView.alignment = .center
        alcoholStackView.spacing = 20
        
        groupStackView.axis = .horizontal
        groupStackView.spacing = 10
        groupStackView.distribution = .fillProportionally
        
        alcoholGuideLabel.text = "Alcohol".localized
        colorGuideLabel.text = "Color".localized
        baseDrinkGuideLabel.text = "Base".localized
        drinkTypeGuideLabel.text = "DrinkType".localized
        glassGuideLabel.text = "Glass".localized
        craftGuideLabel.text = "Craft".localized
        recipeGuideLabel.text = "Recipe".localized
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
        alcoholLabel.text = data.alcohol.rawValue.localized
        colorLabel.text = data.color.rawValue.localized
        baseDrinkLabel.text = data.base.rawValue.localized
        drinkTypeLabel.text = data.drinkType.rawValue.localized
        glassLabel.text = data.glass.rawValue.localized
        craftLabel.text = data.craft.rawValue.localized
        myTipLabel.text = data.mytip.localized
        recipeLabel.text = makeRecipeText(recipe: data.recipe)
        ingredientsLabel.text = makeIngredientsText(ingredients: data.ingredients)
        cocktailImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(systemName: "heart"))
        
        switch data.alcohol {
        case .high:
            highAlcoholLabel.image = UIImage(systemName: "heart.fill")
        case .mid:
            midAlcoholLabel.image = UIImage(systemName: "heart.fill")
        case .low:
            lowAlcoholLabel.image = UIImage(systemName: "heart.fill")
        case .extreme:
            break
        }
        
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
