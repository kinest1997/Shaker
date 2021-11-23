import UIKit
import SnapKit

class AddMyOwnCocktailRecipeViewController: UIViewController {
    
    var alcohol: Cocktail.Alcohol = .high
    var color: Cocktail.Color = .red
    var baseDrink: Cocktail.Base = .assets
    var craft: Cocktail.Craft = .blending
    var glass: Cocktail.Glass = .highBall
    var ingredients: [Cocktail.Ingredients] = []
    var drinkType: Cocktail.DrinkType = .longDrink
    var myOwnRecipeData: ((Cocktail) -> Void)?
    
    var beforeEditingData: Cocktail?
    
    let groupStackView = UIStackView()
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let cocktailImageView = UIImageView()
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStackView = UIStackView()
    
    let alcoholLabel = UILabel()
    let alcoholChoiceButton = UIButton()
    let alcoholStackView = UIStackView()
    var alcoholSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "high".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.alcoholChoiceButton.setTitle("high".localized, for: .normal)
                alcohol = .high }),
            UIAction(title: "mid".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.alcoholChoiceButton.setTitle("mid".localized, for: .normal)
                alcohol = .mid }),
            UIAction(title: "low".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.alcoholChoiceButton.setTitle("low".localized, for: .normal)
                alcohol = .low })
        ]
    }
    
    var alcoholSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: alcoholSelectMenuItems)
    }
    
    let colorLabel = UILabel()
    let colorChoiceButton = UIButton()
    let colorStackView = UIStackView()
    var colorSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "red".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("red".localized, for: .normal)
                color = .red }),
            UIAction(title: "orange".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("orange".localized, for: .normal)
                color = .orange }),
            UIAction(title: "yellow".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("yellow".localized, for: .normal)
                color = .yellow }),
            UIAction(title: "green".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("green".localized, for: .normal)
                color = .green }),
            UIAction(title: "blue".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("blue".localized, for: .normal)
                color = .blue }),
            UIAction(title: "violet".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("violet".localized, for: .normal)
                color = .violet }),
            UIAction(title: "clear".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("clear".localized, for: .normal)
                color = .clear }),
            UIAction(title: "white".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("white".localized, for: .normal)
                color = .white }),
            UIAction(title: "black".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("black".localized, for: .normal)
                color = .black }),
            UIAction(title: "brown".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("brown".localized, for: .normal)
                color = .brown })
        ]
    }
    
    var colorSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: colorSelectMenuItems)
    }
    
    let baseDrinkLabel = UILabel()
    let baseDrinkChoiceButton = UIButton()
    let baseDrinkStackView = UIStackView()
    var baseDrinkSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "rum".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("rum".localized, for: .normal)
                baseDrink = .rum }),
            UIAction(title: "vodka".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("vodka".localized, for: .normal)
                baseDrink = .vodka }),
            UIAction(title: "tequila".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("tequila".localized, for: .normal)
                baseDrink = .tequila }),
            UIAction(title: "brandy".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("brandy".localized, for: .normal)
                baseDrink = .brandy }),
            UIAction(title: "whiskey".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("whiskey".localized, for: .normal)
                baseDrink = .whiskey }),
            UIAction(title: "gin".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("gin".localized, for: .normal)
                baseDrink = .gin }),
            UIAction(title: "liqueur".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("liqueur".localized, for: .normal)
                baseDrink = .liqueur }),
            UIAction(title: "assets".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("assets".localized, for: .normal)
                baseDrink = .assets }),
            UIAction(title: "beverage".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.baseDrinkChoiceButton.setTitle("beverage".localized, for: .normal)
                baseDrink = .beverage})
        ]
    }
    
    var baseSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: baseDrinkSelectMenuItems)
    }
    
    let craftLabel = UILabel()
    let craftChoiceButton = UIButton()
    let craftStackView = UIStackView()
    var craftSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "build".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.craftChoiceButton.setTitle("build".localized, for: .normal)
                craft = .build }),
            UIAction(title: "shaking".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.craftChoiceButton.setTitle("shaking".localized, for: .normal)
                craft = .shaking }),
            UIAction(title: "floating".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.craftChoiceButton.setTitle("floating".localized, for: .normal)
                craft = .floating }),
            UIAction(title: "stir".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.craftChoiceButton.setTitle("stir".localized, for: .normal)
                craft = .stir }),
            UIAction(title: "blending".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.craftChoiceButton.setTitle("blending".localized, for: .normal)
                craft = .blending })
        ]
    }
    var craftSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: craftSelectMenuItems)
    }
    
    let glassLabel = UILabel()
    let glassChoiceButton = UIButton()
    let glassStackView = UIStackView()
    var glassSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "highBall".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("highBall".localized, for: .normal)
                glass = .highBall }),
            UIAction(title: "shot".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("shot".localized, for: .normal)
                glass = .shot }),
            UIAction(title: "onTheRock".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("onTheRock".localized, for: .normal)
                glass = .onTheRock }),
            UIAction(title: "cocktail".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("cocktail".localized, for: .normal)
                glass = .cocktail }),
            UIAction(title: "martini".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("martini".localized, for: .normal)
                glass = .martini }),
            UIAction(title: "collins".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("collins".localized, for: .normal)
                glass = .collins }),
            UIAction(title: "margarita".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("margarita".localized, for: .normal)
                glass = .margarita }),
            UIAction(title: "philsner".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.glassChoiceButton.setTitle("philsner".localized, for: .normal)
                glass = .philsner })
        ]
    }
    var glassSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: glassSelectMenuItems)
    }
    
    let drinkTypeLabel = UILabel()
    let drinkTypeChoiceButton = UIButton()
    let drinkTypeStackView = UIStackView()
    var drinkTypeMenuItems: [UIAction] {
        return [
            UIAction(title: "longDrink".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.drinkTypeChoiceButton.setTitle("longDrink".localized, for: .normal)
                drinkType = .longDrink }),
            UIAction(title: "shortDrink".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.drinkTypeChoiceButton.setTitle("shortDrink".localized, for: .normal)
                drinkType = .shortDrink }),
            UIAction(title: "shooter".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in
                self.drinkTypeChoiceButton.setTitle("shooter".localized, for: .normal)
                drinkType = .shooter })
        ]
    }
    var drinkTypeMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: drinkTypeMenuItems)
    }
    
    let recipeLabel = UILabel()
    let recipeTextField = UITextField()
    let recipeStackView = UIStackView()
    
    let myTipLabel = UILabel()
    let myTipTextField = UITextField()
    let myTipStackView = UIStackView()
    
    let ingredientsLabel = UILabel()
    let ingredientsSelectButton = UIButton()
    let ingredientsStackView = UIStackView()
    
    let choiceView = ChoiceIngredientsView()
    
    
    func attribute() {
        alcoholChoiceButton.menu = alcoholSelectMenu
        alcoholChoiceButton.showsMenuAsPrimaryAction = true
        colorChoiceButton.menu = colorSelectMenu
        colorChoiceButton.showsMenuAsPrimaryAction = true
        baseDrinkChoiceButton.menu = baseSelectMenu
        baseDrinkChoiceButton.showsMenuAsPrimaryAction = true
        glassChoiceButton.menu = glassSelectMenu
        glassChoiceButton.showsMenuAsPrimaryAction = true
        craftChoiceButton.menu = craftSelectMenu
        craftChoiceButton.showsMenuAsPrimaryAction = true
        drinkTypeChoiceButton.menu = drinkTypeMenu
        drinkTypeChoiceButton.showsMenuAsPrimaryAction = true
        
        choiceView.isHidden = true
        ingredientsSelectButton.addAction(UIAction(handler: { [weak self]_ in
            self?.choiceView.isHidden = false
        }), for: .touchUpInside)
        choiceView.saveButton.addAction(UIAction(handler: { [weak self]_ in
            self?.ingredients = self?.choiceView.myIngredients ?? []
            self?.ingredientsSelectButton.setTitle("\(self?.ingredients.count ?? 0)"+"EA".localized+"Selected".localized, for: .normal)
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        choiceView.resetButton.addAction(UIAction(handler: { [weak self]_ in
            guard let self = self else { return }
            self.choiceView.cellIsChecked = self.choiceView.cellIsChecked.map {
                $0.map { _ in false}
            }
            self.ingredients = []
            self.choiceView.myIngredients = []
            self.choiceView.mainTableview.reloadData()
            self.ingredientsSelectButton.setTitle("Ingredients".localized, for: .normal)
            self.choiceView.isHidden = true
            //과연 리셋을 눌렀을때 창이 사라지는게 맞을까 그냥 선택 상태만 초기화 시키는게 맞을까
        }), for: .touchUpInside)
        choiceView.cancelButton.addAction(UIAction(handler: { [weak self]_ in
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        cocktailImageView.image = UIImage(named: "Martini")
        groupStackView.axis = .vertical
        groupStackView.backgroundColor = .brown
        groupStackView.distribution = .fillEqually
        groupStackView.spacing = 20
        
        nameLabel.text = "Name".localized
        alcoholLabel.text = "Alcohol".localized
        colorLabel.text = "Color".localized
        baseDrinkLabel.text = "Base".localized
        glassLabel.text = "Glass".localized
        craftLabel.text = "Craft".localized
        recipeLabel.text = "Recipe".localized
        myTipLabel.text = "Tip".localized
        drinkTypeLabel.text = "DrinkType".localized
        ingredientsLabel.text = "Ingredients".localized
        nameTextField.placeholder = "Your own name".localized
        recipeTextField.placeholder = "Your own recipe".localized
        myTipTextField.placeholder = "Your own tip".localized
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        view.addSubview(choiceView)
        
        [groupStackView, cocktailImageView].forEach {
            mainView.addSubview($0)
        }
        
        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, drinkTypeStackView, glassStackView, craftStackView, ingredientsStackView, recipeStackView, myTipStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
        }
        
        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, recipeLabel, myTipLabel, drinkTypeLabel, ingredientsLabel].forEach {
            $0.textAlignment = .center
            $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
            $0.backgroundColor = .blue
            $0.numberOfLines = 0
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
        }
        
        if let cocktailData = beforeEditingData {
            alcoholChoiceButton.setTitle(cocktailData.alcohol.rawValue.localized, for: .normal)
            colorChoiceButton.setTitle(cocktailData.color.rawValue.localized, for: .normal)
            baseDrinkChoiceButton.setTitle(cocktailData.base.rawValue.localized, for: .normal)
            glassChoiceButton.setTitle(cocktailData.glass.rawValue.localized, for: .normal)
            craftChoiceButton.setTitle(cocktailData.craft.rawValue.localized, for: .normal)
            drinkTypeChoiceButton.setTitle(cocktailData.drinkType.rawValue.localized, for: .normal)
            ingredientsSelectButton.setTitle("\(cocktailData.ingredients.count)"+"EA".localized+"Selected".localized, for: .normal)
            self.choiceView.myIngredients = cocktailData.ingredients
        } else {
            [alcoholChoiceButton, colorChoiceButton, baseDrinkChoiceButton, glassChoiceButton, craftChoiceButton, drinkTypeChoiceButton, ingredientsSelectButton].forEach {
                $0.setTitle("Choice".localized, for: .normal)
            }
        }
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        alcoholStackView.addArrangedSubview(alcoholLabel)
        alcoholStackView.addArrangedSubview(alcoholChoiceButton)
        
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(colorChoiceButton)
        
        baseDrinkStackView.addArrangedSubview(baseDrinkLabel)
        baseDrinkStackView.addArrangedSubview(baseDrinkChoiceButton)
        
        glassStackView.addArrangedSubview(glassLabel)
        glassStackView.addArrangedSubview(glassChoiceButton)
        
        craftStackView.addArrangedSubview(craftLabel)
        craftStackView.addArrangedSubview(craftChoiceButton)
        
        recipeStackView.addArrangedSubview(recipeLabel)
        recipeStackView.addArrangedSubview(recipeTextField)
        
        myTipStackView.addArrangedSubview(myTipLabel)
        myTipStackView.addArrangedSubview(myTipTextField)
        
        drinkTypeStackView.addArrangedSubview(drinkTypeLabel)
        drinkTypeStackView.addArrangedSubview(drinkTypeChoiceButton)
        
        ingredientsStackView.addArrangedSubview(ingredientsLabel)
        ingredientsStackView.addArrangedSubview(ingredientsSelectButton)
        
        mainScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.bottom.equalTo(groupStackView.snp.bottom)
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
        
        choiceView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.bottom.equalToSuperview().inset(100)
        }
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(
            keyboardNotificationHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardNotificationHandler(_ notification: Notification) {
        if recipeTextField.isEditing || myTipTextField.isEditing {
            switch notification.name {
            case UIResponder.keyboardWillShowNotification:
                let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                self.view.frame.origin.y = 50 - keyboardSize.height
            case UIResponder.keyboardWillHideNotification:
                self.view.frame.origin.y = 0
            default:
                return
            }
        }
    }
    
    func editing(data: Cocktail) {
        nameTextField.text = data.name
        recipeTextField.text = data.recipe
        ingredients = data.ingredients
        myTipTextField.text = data.mytip
        drinkType = data.drinkType
        baseDrink = data.base
        alcohol = data.alcohol
        glass = data.glass
        color = data.color
        craft = data.craft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [nameTextField, recipeTextField, myTipTextField].forEach {
            $0.delegate = self
        }
        alcoholChoiceButton.backgroundColor = .red
        attribute()
        layout()
        registerKeyboardNotification()
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        mainScrollView.addGestureRecognizer(singleTapGestureRecognizer)
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveRecipe))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveRecipe() {
        print("눌림")
        let myRecipe = Cocktail(name: nameTextField.text ?? "", craft: craft, glass: glass, recipe: recipeTextField.text ?? "", ingredients: ingredients, base: baseDrink, alcohol: alcohol, color: color, mytip: myTipTextField.text ?? "", drinkType: drinkType, myRecipe: true)
        if nameTextField.text?.isEmpty ?? true  {
            presentAlert(message: "이름적어!")
        } else if recipeTextField.text?.isEmpty ?? true {
            presentAlert(message: "레시피는 적어야지")
        } else if myTipTextField.text?.isEmpty ?? true {
            presentAlert(message: "팁도 좀적어")
        } else {
            myOwnRecipeData?(myRecipe)
            print("성공")
            navigationController?.popViewController(animated: true)
        } 
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Hold on".localized, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension AddMyOwnCocktailRecipeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //이거 왜 안됨? 개빡치네
        //일단 다른방법 찾음 스크롤뷰는 스크롤해야해서 한번의 터치는 원래 씹는다네
    }
}