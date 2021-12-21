import UIKit
import SnapKit
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class AddMyOwnCocktailRecipeViewController: UIViewController {
    
    let loadingView = LoadingView()
    
    var alcohol: Cocktail.Alcohol?
    var color: Cocktail.Color?
    var baseDrink: Cocktail.Base?
    var craft: Cocktail.Craft?
    var glass: Cocktail.Glass?
    var ingredients: [Cocktail.Ingredients]?
    var drinkType: Cocktail.DrinkType?
    var myOwnRecipeData: ((Cocktail) -> Void)?
    var cocktailImageData: ((UIImage) -> Void)?
    
    var textFieldArray = [UITextField]()
    
    let addButton = UIButton()
    
    var beforeEditingData: Cocktail?
    
    let addRecipeTableView = UITableView(frame: .zero, style: .plain)
    
    let groupStackView = UIStackView()
    let cocktailImageView = UIImageView(image: UIImage(named: "Martini"))
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    
    let alcoholLabel = UILabel()
    let alcoholChoiceButton = UIButton()
    let alcoholStackView = UIStackView()
    var alcoholSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "high".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("high".localized, for: .normal)
                alcohol = .high }),
            UIAction(title: "mid".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("mid".localized, for: .normal)
                alcohol = .mid }),
            UIAction(title: "low".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("low".localized, for: .normal)
                alcohol = .low })
        ]
    }
    
    var alcoholSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: alcoholSelectMenuItems)
    }
    
    let colorLabel = UILabel()
    let colorChoiceButton = UIButton()
    var colorSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "red".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("red".localized, for: .normal)
                color = .red }),
            UIAction(title: "orange".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("orange".localized, for: .normal)
                color = .orange }),
            UIAction(title: "yellow".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("yellow".localized, for: .normal)
                color = .yellow }),
            UIAction(title: "green".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("green".localized, for: .normal)
                color = .green }),
            UIAction(title: "blue".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("blue".localized, for: .normal)
                color = .blue }),
            UIAction(title: "violet".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("violet".localized, for: .normal)
                color = .violet }),
            UIAction(title: "clear".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("clear".localized, for: .normal)
                color = .clear }),
            UIAction(title: "black".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("black".localized, for: .normal)
                color = .black }),
            UIAction(title: "brown".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("brown".localized, for: .normal)
                color = .brown }),
            UIAction(title: "various".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("various".localized, for: .normal)
                color = .various })
        ]
    }
    
    var colorSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: colorSelectMenuItems)
    }
    
    let baseDrinkLabel = UILabel()
    let baseDrinkChoiceButton = UIButton()
    var baseDrinkSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "rum".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("rum".localized, for: .normal)
                baseDrink = .rum }),
            UIAction(title: "vodka".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("vodka".localized, for: .normal)
                baseDrink = .vodka }),
            UIAction(title: "tequila".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("tequila".localized, for: .normal)
                baseDrink = .tequila }),
            UIAction(title: "brandy".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("brandy".localized, for: .normal)
                baseDrink = .brandy }),
            UIAction(title: "whiskey".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("whiskey".localized, for: .normal)
                baseDrink = .whiskey }),
            UIAction(title: "gin".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("gin".localized, for: .normal)
                baseDrink = .gin }),
            UIAction(title: "liqueur".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("liqueur".localized, for: .normal)
                baseDrink = .liqueur }),
            UIAction(title: "assets".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("assets".localized, for: .normal)
                baseDrink = .assets }),
            UIAction(title: "beverage".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("beverage".localized, for: .normal)
                baseDrink = .beverage})
        ]
    }
    
    var baseSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: baseDrinkSelectMenuItems)
    }
    
    let craftLabel = UILabel()
    let craftChoiceButton = UIButton()
    var craftSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "build".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("build".localized, for: .normal)
                craft = .build }),
            UIAction(title: "shaking".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("shaking".localized, for: .normal)
                craft = .shaking }),
            UIAction(title: "floating".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("floating".localized, for: .normal)
                craft = .floating }),
            UIAction(title: "stir".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("stir".localized, for: .normal)
                craft = .stir }),
            UIAction(title: "blending".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("blending".localized, for: .normal)
                craft = .blending })
        ]
    }
    var craftSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: craftSelectMenuItems)
    }
    
    let glassLabel = UILabel()
    let glassChoiceButton = UIButton()
    var glassSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "highBall".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("highBall".localized, for: .normal)
                glass = .highBall }),
            UIAction(title: "shot".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("shot".localized, for: .normal)
                glass = .shot }),
            UIAction(title: "onTheRock".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("onTheRock".localized, for: .normal)
                glass = .onTheRock }),
            UIAction(title: "saucer".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("saucer".localized, for: .normal)
                glass = .saucer }),
            UIAction(title: "martini".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("martini".localized, for: .normal)
                glass = .martini }),
            UIAction(title: "collins".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("collins".localized, for: .normal)
                glass = .collins }),
            UIAction(title: "margarita".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("margarita".localized, for: .normal)
                glass = .margarita }),
            UIAction(title: "philsner".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("philsner".localized, for: .normal)
                glass = .philsner })
        ]
    }
    var glassSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: glassSelectMenuItems)
    }
    
    let drinkTypeLabel = UILabel()
    let drinkTypeChoiceButton = UIButton()
    var drinkTypeMenuItems: [UIAction] {
        return [
            UIAction(title: "longDrink".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("longDrink".localized, for: .normal)
                drinkType = .longDrink }),
            UIAction(title: "shortDrink".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("shortDrink".localized, for: .normal)
                drinkType = .shortDrink }),
            UIAction(title: "shooter".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("shooter".localized, for: .normal)
                drinkType = .shooter })
        ]
    }
    var drinkTypeMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: drinkTypeMenuItems)
    }
    
    let myTipLabel = UILabel()
    let myTipTextField = UITextView()
    
    let ingredientsLabel = UILabel()
    let ingredientsSelectButton = UIButton()
    
    let leftStackView = UIStackView()
    let centerLine = UIView()
    let rightStackView = UIStackView()
    
    let firstSplitLine = UILabel()
    let selectedIngredientsLabel = UILabel()
    
    let secondSplitLine = UILabel()
    
    let choiceView = ChoiceIngredientsView()
    
    let headerView = UIView()
    
    let recipeLabel = UILabel()
    
    let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        addRecipeTableView.register(AddRecipeCell.self, forCellReuseIdentifier: "addRecipeCell")
        addRecipeTableView.delegate = self
        addRecipeTableView.dataSource = self
        addRecipeTableView.tableHeaderView = headerView
        addRecipeTableView.tableFooterView = footerView
        addRecipeTableView.rowHeight = 50
        attribute()
        layout()
        registerNotifications()
        actions()
        addGestureRecognizer()
    }
    
    func actions() {
        addButton.addAction(UIAction(handler: {[weak self] _ in
            self?.textFieldArray.append(UITextField())
            self?.addRecipeTableView.reloadData()
        }), for: .touchUpInside)
        
        ingredientsSelectButton.addAction(UIAction(handler: {[weak self] _ in
            self?.choiceView.isHidden = false
        }), for: .touchUpInside)
        
        choiceView.saveButton.addAction(UIAction(handler: {[weak self] _ in
            self?.ingredients = self?.choiceView.myIngredients ?? []
            self?.ingredientsSelectButton.setTitle("\(self?.ingredients?.count ?? 0)"+"EA".localized+"Selected".localized, for: .normal)
            if let ingredients = self?.ingredients {
                self?.selectedIngredientsLabel.text = ingredients.map { $0.rawValue.localized }.joined(separator: ", ")
            }
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        choiceView.resetButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.choiceView.cellIsChecked = self.choiceView.cellIsChecked.map {
                $0.map { _ in false}
            }
            self.selectedIngredientsLabel.text = ""
            self.ingredients = []
            self.choiceView.myIngredients = []
            self.choiceView.mainTableview.reloadData()
            self.ingredientsSelectButton.setTitle("Ingredients".localized, for: .normal)
            self.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        choiceView.cancelButton.addAction(UIAction(handler: {[weak self] _ in
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(singleTapGestureRecognizer)
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveRecipe))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func attribute() {
        //사진이미지 비율
        cocktailImageView.contentMode = .scaleAspectFill
        cocktailImageView.clipsToBounds = true
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
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1200)
        addRecipeTableView.backgroundColor = .clear
        
        // 기본 라벨들
        [alcoholLabel, myTipLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, ingredientsLabel, drinkTypeLabel, selectedIngredientsLabel, recipeLabel, alcoholLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
        
        nameTextField.textColor = .black
        nameTextField.font = .systemFont(ofSize: 24, weight: .heavy)
        
        [alcoholChoiceButton ,colorChoiceButton, baseDrinkChoiceButton, drinkTypeChoiceButton, glassChoiceButton, craftChoiceButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.contentHorizontalAlignment = .leading
            $0.titleLabel?.font = .systemFont(ofSize: 14)
        }
        alcoholChoiceButton.setTitleColor(.black, for: .normal)
        alcoholChoiceButton.titleLabel?.font = .systemFont(ofSize: 14)
        
        [leftStackView, rightStackView].forEach {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
        
        [alcoholLabel ,colorLabel, baseDrinkLabel, glassLabel, craftLabel, drinkTypeLabel].forEach {
            $0.textAlignment = .right
        }
        
        ingredientsSelectButton.setTitleColor(.black, for: .normal)
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        footerView.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        nameTextField.textAlignment = .center
        recipeLabel.text = "Recipe".localized
        addButton.setTitleColor(.black, for: .normal)
        
        selectedIngredientsLabel.sizeToFit()
        selectedIngredientsLabel.numberOfLines = 0
        
        recipeLabel.sizeToFit()
        groupStackView.axis = .horizontal
        groupStackView.spacing = 10
        groupStackView.distribution = .fill
        firstSplitLine.backgroundColor = .black
        secondSplitLine.backgroundColor = .black
        centerLine.backgroundColor = .black
        
        choiceView.isHidden = true
        addButton.setTitle("+" + "Add".localized, for: .normal)
        
        self.view.backgroundColor = .white
        
        nameLabel.text = "Name".localized
        alcoholLabel.text = "Alcohol".localized
        colorLabel.text = "Color".localized
        baseDrinkLabel.text = "Base".localized
        glassLabel.text = "Glass".localized
        craftLabel.text = "Craft".localized
        myTipLabel.text = "Tip".localized
        drinkTypeLabel.text = "DrinkType".localized
        ingredientsLabel.text = "Ingredients".localized
        loadingView.isHidden = true
        
        addRecipeTableView.backgroundView?.backgroundColor = .white
    }
    
    func layout() {
        [addRecipeTableView, choiceView, loadingView].forEach {
            view.addSubview($0)
        }
        
        addRecipeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [cocktailImageView, nameTextField, alcoholStackView, myTipTextField, groupStackView, firstSplitLine, ingredientsLabel, ingredientsSelectButton, selectedIngredientsLabel, secondSplitLine, recipeLabel].forEach {
            headerView.addSubview($0)
        }
        
        [leftStackView, centerLine, rightStackView].forEach {
            groupStackView.addArrangedSubview($0)
        }
        
        [alcoholLabel ,colorLabel, baseDrinkLabel, drinkTypeLabel, glassLabel, craftLabel].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [alcoholChoiceButton, colorChoiceButton, baseDrinkChoiceButton, drinkTypeChoiceButton, glassChoiceButton, craftChoiceButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(headerView.snp.width).multipliedBy(0.5)
            $0.height.equalTo(300)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        alcoholStackView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(nameTextField)
        }
        
        myTipTextField.snp.makeConstraints {
            $0.top.equalTo(alcoholStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(100)
        }
        
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(myTipTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view).multipliedBy(0.4)
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
        
        ingredientsLabel.snp.makeConstraints {
            $0.top.equalTo(firstSplitLine.snp.bottom).offset(50)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        ingredientsSelectButton.snp.makeConstraints {
            $0.top.equalTo(ingredientsLabel)
            $0.height.equalTo(40)
            $0.leading.equalTo(ingredientsLabel.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        
        choiceView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.bottom.equalToSuperview().inset(100)
        }
        
        selectedIngredientsLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(50)
            $0.width.equalTo(firstSplitLine)
            $0.centerX.equalToSuperview()
        }
        
        secondSplitLine.snp.makeConstraints {
            $0.top.equalTo(selectedIngredientsLabel.snp.bottom).offset(50)
            $0.width.equalTo(firstSplitLine)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
        }
        
        recipeLabel.snp.makeConstraints {
            $0.top.equalTo(secondSplitLine.snp.bottom).offset(40)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        //위에다 둘지 아래에 둘지 아직 고민중
        //        headerView.addSubview(addButton)
        //        addButton.snp.makeConstraints {
        //            $0.top.equalTo(recipeLabel.snp.bottom).offset(10)
        //            $0.centerX.equalToSuperview()
        //            $0.bottom.equalToSuperview()
        //            $0.width.equalToSuperview().multipliedBy(0.7)
        //        }
        
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
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        addRecipeTableView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        addRecipeTableView.contentInset.bottom = 0
    }
    
    func editing(data: Cocktail) {
        nameTextField.text = data.name
        ingredients = data.ingredients
        myTipTextField.text = data.mytip
        drinkType = data.drinkType
        baseDrink = data.base
        alcohol = data.alcohol
        glass = data.glass
        color = data.color
        craft = data.craft
        selectedIngredientsLabel.text = data.ingredients.map { $0.rawValue.localized }.joined(separator: ", ")
        for order in data.recipe {
            let textfield = UITextField()
            textfield.text = order
            textFieldArray.append(textfield)
        }
    }
    
    @objc func saveRecipe() {
        guard let craft = craft,
              let glass = glass,
              let baseDrink = baseDrink,
              let alcohol = alcohol,
              let color = color,
              let drinkType = drinkType,
              let ingredients = ingredients,
              let image = cocktailImageView.image,
              let myTip = myTipTextField.text,
              let name = nameTextField.text
        else {
            return presentJustAlert(title: "Hold on".localized, message: "선택안한게 있어!")
        }
        
        if name.isEmpty {
            presentJustAlert(title: "Hold on".localized, message: "Write name".localized)
        } else if textFieldArray.isEmpty {
            presentJustAlert(title: "Hold on".localized, message: "Write recipe".localized)
        } else if myTip.isEmpty {
            presentJustAlert(title: "Hold on".localized, message: "Write tips".localized)
        } else {
            if let beforeEditingData = beforeEditingData {
                if let number = FirebaseRecipe.shared.myRecipe.firstIndex(of: beforeEditingData) {
                    FirebaseRecipe.shared.myRecipe.remove(at: number)
                }
            }
            loadingView.explainLabel.text = "저장중"
            loadingView.isHidden = false
            
            guard let convertedImage = image.pngData(),
                  let uid = Auth.auth().currentUser?.uid else { return }
            let storageRef = Storage.storage().reference().child("CustomCocktails").child(uid).child("Recipes").child(nameTextField.text ?? "NoName"  + ".png")
            
            storageRef.putData(convertedImage, metadata: nil) { metaData, error in
                guard error == nil,
                      metaData != nil else { return }
                storageRef.downloadURL {[weak self] url, error in
                    guard let self = self else { return }
                    guard error == nil,
                          let url = url else { return }
                    
                    let recipe = self.textFieldArray.filter {$0.text != "" }.map { $0.text! }
                    
                    let myRecipe = Cocktail(name: name, craft: craft, glass: glass, recipe: recipe, ingredients: ingredients, base: baseDrink, alcohol: alcohol, color: color, mytip: myTip, drinkType: drinkType, myRecipe: true, wishList: false, imageURL: url.absoluteString)
                    FirebaseRecipe.shared.myRecipe.append(myRecipe)
                    FirebaseRecipe.shared.uploadMyRecipe()
                    let cocktailDetailViewController = CocktailDetailViewController()
                    cocktailDetailViewController.setData(data: myRecipe)
                    
                    self.loadingView.isHidden = true
                    self.navigationController?.popToRootViewController(animated: true)
                    self.show(cocktailDetailViewController, sender: nil)
                }
            }
        }
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func presentJustAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension AddMyOwnCocktailRecipeViewController: PHPickerViewControllerDelegate {
    
    func addGestureRecognizer() {
        let tapGestureRecognizer
        = UITapGestureRecognizer(target: self, action: #selector(self.tappedUIImageView(_:)))
        self.cocktailImageView.addGestureRecognizer(tapGestureRecognizer)
        self.cocktailImageView.isUserInteractionEnabled = true
    }
    
    @objc func tappedUIImageView(_ gesture: UITapGestureRecognizer) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.cocktailImageView.image = (image as! UIImage).resize()
                }
            }
        }
    }
}

extension AddMyOwnCocktailRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFieldArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addRecipeCell", for: indexPath) as? AddRecipeCell else { return UITableViewCell()}
        
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.explainTextField = textFieldArray[indexPath.row]
        cell.explainTextField.delegate = self
        return cell
    }
}

extension AddMyOwnCocktailRecipeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
