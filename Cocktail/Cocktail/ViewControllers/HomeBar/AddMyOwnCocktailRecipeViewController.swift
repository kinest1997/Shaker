import UIKit
import SnapKit
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class AddMyOwnCocktailRecipeViewController: UIViewController {
    
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
    
    let addRecipeTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let groupStackView = UIStackView()
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let cocktailImageView = UIImageView(image: UIImage(named: "Martini"))
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStackView = UIStackView()
    
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
    let colorStackView = UIStackView()
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
    let craftStackView = UIStackView()
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
    let glassStackView = UIStackView()
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
    let drinkTypeStackView = UIStackView()
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
    let myTipTextField = UITextField()
    let myTipStackView = UIStackView()
    
    let ingredientsLabel = UILabel()
    let ingredientsSelectButton = UIButton()
    let ingredientsStackView = UIStackView()
    
    let choiceView = ChoiceIngredientsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [nameTextField, myTipTextField].forEach {
            $0.delegate = self
        }
        addRecipeTableView.register(AddRecipeCell.self, forCellReuseIdentifier: "addRecipeCell")
        addRecipeTableView.delegate = self
        addRecipeTableView.dataSource = self
        
        alcoholChoiceButton.backgroundColor = .red
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
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        choiceView.resetButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.choiceView.cellIsChecked = self.choiceView.cellIsChecked.map {
                $0.map { _ in false}
            }
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
        mainScrollView.addGestureRecognizer(singleTapGestureRecognizer)
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveRecipe))
        navigationItem.rightBarButtonItem = saveButton
    }
    
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
        addButton.backgroundColor = .brown
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.cyan, for: .normal)
        
        
        self.view.backgroundColor = .white
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
        myTipLabel.text = "Tip".localized
        drinkTypeLabel.text = "DrinkType".localized
        ingredientsLabel.text = "Ingredients".localized
        nameTextField.placeholder = "Your own name".localized
        myTipTextField.placeholder = "Your own tip".localized
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        view.addSubview(choiceView)
        mainScrollView.addSubview(mainView)
        
        [groupStackView, cocktailImageView, addRecipeTableView, addButton].forEach {
            mainView.addSubview($0)
        }
        
        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, drinkTypeStackView, glassStackView, craftStackView, ingredientsStackView, myTipStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
        }
        
        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, myTipLabel, drinkTypeLabel, ingredientsLabel].forEach {
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
            $0.bottom.equalTo(addButton.snp.bottom)
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
        //레이아웃을 이제 슬슬 꾸며야한다..
        addRecipeTableView.snp.makeConstraints {
            $0.top.equalTo(groupStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(addRecipeTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    
     private func registerNotifications() {
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
     
     @objc private func keyboardWillShow(notification: NSNotification){
     guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
     mainScrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
     }
     
     @objc private func keyboardWillHide(notification: NSNotification){
     mainScrollView.contentInset.bottom = 0
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
            
            let loadingView = LoadingView()
            loadingView.modalPresentationStyle = .overCurrentContext
            loadingView.modalTransitionStyle = .crossDissolve
            loadingView.explainLabel.text = "저장중"
            self.present(loadingView, animated: true)
            
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
                    
                    loadingView.dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
