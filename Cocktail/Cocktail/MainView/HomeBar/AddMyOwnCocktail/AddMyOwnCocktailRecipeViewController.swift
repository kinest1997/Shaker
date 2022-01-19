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
    
    let addRecipeTableView = UITableView(frame: .zero, style: .plain )
    
    let groupStackView = UIStackView()
    let cocktailImageView = UIImageView()
    
    let nameTextField = UITextField()
    
    let alcoholLabel = UILabel()
    let alcoholChoiceButton = UIButton()
    let alcoholStackView = UIStackView()
    var alcoholSelectMenuItems: [UIAction] {
        return [
            UIAction(title: "High".localized, state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("High".localized, for: .normal)
                alcohol = .high }),
            UIAction(title: "Mid".localized, state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("Mid".localized, for: .normal)
                alcohol = .mid }),
            UIAction(title: "Low".localized, state: .off, handler: {[unowned self] _ in self.alcoholChoiceButton.setTitle("Low".localized, for: .normal)
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
            UIAction(title: "red".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("red".localized, for: .normal)
                color = .red }),
            UIAction(title: "orange".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("orange".localized, for: .normal)
                color = .orange }),
            UIAction(title: "yellow".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("yellow".localized, for: .normal)
                color = .yellow }),
            UIAction(title: "green".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("green".localized, for: .normal)
                color = .green }),
            UIAction(title: "blue".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("blue".localized, for: .normal)
                color = .blue }),
            UIAction(title: "violet".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("violet".localized, for: .normal)
                color = .violet }),
            UIAction(title: "clear".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("clear".localized, for: .normal)
                color = .clear }),
            UIAction(title: "black".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("black".localized, for: .normal)
                color = .black }),
            UIAction(title: "brown".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("brown".localized, for: .normal)
                color = .brown }),
            UIAction(title: "various".localized, state: .off, handler: {[unowned self] _ in self.colorChoiceButton.setTitle("various".localized, for: .normal)
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
            UIAction(title: "rum".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("rum".localized, for: .normal)
                baseDrink = .rum }),
            UIAction(title: "vodka".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("vodka".localized, for: .normal)
                baseDrink = .vodka }),
            UIAction(title: "tequila".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("tequila".localized, for: .normal)
                baseDrink = .tequila }),
            UIAction(title: "brandy".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("brandy".localized, for: .normal)
                baseDrink = .brandy }),
            UIAction(title: "whiskey".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("whiskey".localized, for: .normal)
                baseDrink = .whiskey }),
            UIAction(title: "gin".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("gin".localized, for: .normal)
                baseDrink = .gin }),
            UIAction(title: "liqueur".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("liqueur".localized, for: .normal)
                baseDrink = .liqueur }),
            UIAction(title: "assets".localized, state: .off, handler: {[unowned self] _ in
                self.baseDrinkChoiceButton.setTitle("assets".localized, for: .normal)
                baseDrink = .assets }),
            UIAction(title: "beverage".localized, state: .off, handler: {[unowned self] _ in
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
            UIAction(title: "build".localized, state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("build".localized, for: .normal)
                craft = .build }),
            UIAction(title: "shaking".localized, state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("shaking".localized, for: .normal)
                craft = .shaking }),
            UIAction(title: "floating".localized, state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("floating".localized, for: .normal)
                craft = .floating }),
            UIAction(title: "stir".localized, state: .off, handler: {[unowned self] _ in
                self.craftChoiceButton.setTitle("stir".localized, for: .normal)
                craft = .stir }),
            UIAction(title: "blending".localized, state: .off, handler: {[unowned self] _ in
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
            UIAction(title: "highBall".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("highBall".localized, for: .normal)
                glass = .highBall }),
            UIAction(title: "shot".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("shot".localized, for: .normal)
                glass = .shot }),
            UIAction(title: "onTheRock".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("onTheRock".localized, for: .normal)
                glass = .onTheRock }),
            UIAction(title: "saucer".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("saucer".localized, for: .normal)
                glass = .saucer }),
            UIAction(title: "martini".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("martini".localized, for: .normal)
                glass = .martini }),
            UIAction(title: "collins".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("collins".localized, for: .normal)
                glass = .collins }),
            UIAction(title: "margarita".localized, state: .off, handler: {[unowned self] _ in
                self.glassChoiceButton.setTitle("margarita".localized, for: .normal)
                glass = .margarita }),
            UIAction(title: "philsner".localized, state: .off, handler: {[unowned self] _ in
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
            UIAction(title: "longDrink".localized, state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("longDrink".localized, for: .normal)
                drinkType = .longDrink }),
            UIAction(title: "shortDrink".localized, state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("shortDrink".localized, for: .normal)
                drinkType = .shortDrink }),
            UIAction(title: "shooter".localized, state: .off, handler: {[unowned self] _ in
                self.drinkTypeChoiceButton.setTitle("shooter".localized, for: .normal)
                drinkType = .shooter })
        ]
    }
    var drinkTypeMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: drinkTypeMenuItems)
    }
    
    let myTipLabel = UILabel()
    let myTipTextView = UITextView()
    
    let ingredientsLabel = UILabel()
    let ingredientsSelectButton = UIButton()
    
    let leftStackView = UIStackView()
    let centerLine = UIView()
    let rightStackView = UIStackView()
    
    let choiceView = ChoiceIngredientsView()
    
    let headerView = UIView()
    
    let footerView = UIView()
    
    let cameraImage = UIImageView(image: UIImage(systemName: "camera.circle"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        addRecipeTableView.register(AddRecipeCell.self, forCellReuseIdentifier: "addRecipeCell")
        addRecipeTableView.register(IngredientsCell.self, forCellReuseIdentifier: "ingredientsCell")
        addRecipeTableView.register(AddTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "AddTableViewHeaderView")
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
        
        choiceView.saveButton.addAction(UIAction(handler: {[weak self] _ in
            self?.ingredients = self?.choiceView.myIngredients ?? []
            self?.choiceView.isHidden = true
            self?.addRecipeTableView.reloadData()
        }), for: .touchUpInside)
        
        choiceView.resetButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.choiceView.cellIsChecked = self.choiceView.cellIsChecked.map {
                $0.map { _ in false}
            }
            self.ingredients = []
            self.choiceView.myIngredients = []
            self.choiceView.isHidden = true
            self.addRecipeTableView.reloadData()
            self.choiceView.mainTableView.reloadData()
        }), for: .touchUpInside)
        
        choiceView.cancleButton.addAction(UIAction(handler: {[weak self] _ in
            self?.choiceView.isHidden = true
        }), for: .touchUpInside)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(singleTapGestureRecognizer)
        let saveButton = UIBarButtonItem(title: "Save".localized, style: .plain, target: self, action: #selector(saveRecipe))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func attribute() {
        nameTextField.backgroundColor = .splitLineGray
        myTipTextView.backgroundColor = .splitLineGray
        myTipTextView.font = .nexonFont(ofSize: 14, weight: .semibold)
        
        addRecipeTableView.separatorStyle = .none
        //사진이미지 비율
        cocktailImageView.contentMode = .scaleAspectFit
        cocktailImageView.layer.cornerRadius = 15
        cocktailImageView.clipsToBounds = true
        cocktailImageView.layer.borderWidth = 1
        cocktailImageView.layer.borderColor = UIColor.borderGray.cgColor
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
        
        addRecipeTableView.backgroundColor = .clear
        
        // 기본 라벨들
        [alcoholLabel, myTipLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, ingredientsLabel, drinkTypeLabel, alcoholLabel].forEach {
            $0.textColor = .mainGray
            $0.font = .nexonFont(ofSize: 14, weight: .bold)
        }
        
        [nameTextField, myTipTextView].forEach {
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        nameTextField.placeholder = "Name".localized
        nameTextField.textColor = .black
        nameTextField.font = .nexonFont(ofSize: 24, weight: .heavy)
        
        [alcoholChoiceButton ,colorChoiceButton, baseDrinkChoiceButton, drinkTypeChoiceButton, glassChoiceButton, craftChoiceButton, addButton].forEach {
            $0.setTitleColor(.mainGray, for: .normal)
            $0.contentHorizontalAlignment = .fill
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = .nexonFont(ofSize: 14, weight: .semibold)
            $0.backgroundColor = .splitLineGray
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        
        [leftStackView, rightStackView].forEach {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 15
        }
        
        [alcoholLabel ,colorLabel, baseDrinkLabel, glassLabel, craftLabel, drinkTypeLabel].forEach {
            $0.textAlignment = .right
        }
        
        nameTextField.textAlignment = .center
        
        groupStackView.axis = .horizontal
        groupStackView.spacing = 10
        groupStackView.distribution = .fill
        centerLine.backgroundColor = .black
        
        choiceView.isHidden = true
        addButton.setTitle("+" + "Add".localized, for: .normal)
        
        self.view.backgroundColor = .white
        
        alcoholLabel.text = "Alcohol".localized
        colorLabel.text = "Color".localized
        baseDrinkLabel.text = "Base".localized
        glassLabel.text = "Glass".localized
        craftLabel.text = "Craft".localized
        myTipLabel.text = "Tip".localized
        drinkTypeLabel.text = "DrinkType".localized
        ingredientsLabel.text = "Ingredients".localized
        loadingView.isHidden = true
        cameraImage.tintColor = .black
        centerLine.backgroundColor = .splitLineGray
        addRecipeTableView.backgroundView?.backgroundColor = .white
    }
    
    func layout() {
        [addRecipeTableView, choiceView, loadingView].forEach {
            view.addSubview($0)
        }
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 850)
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        footerView.addSubview(addButton)
        
        addRecipeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [cocktailImageView, nameTextField, alcoholStackView, myTipTextView, ingredientsLabel, ingredientsSelectButton, cameraImage, centerLine, leftStackView, rightStackView].forEach {
            headerView.addSubview($0)
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
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.7)
        }

        cameraImage.snp.makeConstraints {
            $0.trailing.bottom.equalTo(cocktailImageView)
            $0.width.height.equalTo(30)
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
        
        myTipTextView.snp.makeConstraints {
            $0.top.equalTo(alcoholStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(30)
            $0.height.equalTo(100)
        }

        leftStackView.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.leading.equalTo(myTipTextView)
            $0.top.equalTo(myTipTextView.snp.bottom).offset(30)
        }

        rightStackView.snp.makeConstraints {
            $0.leading.equalTo(leftStackView.snp.trailing).offset(10)
            $0.trailing.equalTo(myTipTextView)
            $0.top.bottom.equalTo(leftStackView)
        }

        choiceView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        
        if let cocktailData = beforeEditingData {
            alcoholChoiceButton.setTitle(cocktailData.alcohol.rawValue.localized, for: .normal)
            colorChoiceButton.setTitle(cocktailData.color.rawValue.localized, for: .normal)
            baseDrinkChoiceButton.setTitle(cocktailData.base.rawValue.localized, for: .normal)
            glassChoiceButton.setTitle(cocktailData.glass.rawValue.localized, for: .normal)
            craftChoiceButton.setTitle(cocktailData.craft.rawValue.localized, for: .normal)
            drinkTypeChoiceButton.setTitle(cocktailData.drinkType.rawValue.localized, for: .normal)
            self.choiceView.myIngredients = cocktailData.ingredients
        } else {
            [alcoholChoiceButton, colorChoiceButton, baseDrinkChoiceButton, glassChoiceButton, craftChoiceButton, drinkTypeChoiceButton].forEach {
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
        myTipTextView.text = data.mytip
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
              let myTip = myTipTextView.text,
              let name = nameTextField.text
        else {
            return presentJustAlert(title: "Hold on".localized, message: "There's something I didn't choose".localized)
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
            self.loadingView.explainLabel.text = "Saving it in my recipe".localized
            self.loadingView.isHidden = false
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddTableViewHeaderView") as! AddTableViewHeaderView
        switch section {
        case 0:
            header.isIngredients = true
            header.titleLabel.text = "Ingredients".localized
            header.showButton.addAction(UIAction(handler: {[weak self] _ in
                self?.choiceView.isHidden = false
            }), for: .touchUpInside)
            return header
        case 1:
            header.titleLabel.text = "Recipe".localized
            header.isIngredients = false
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ingredients?.count ?? 0
        case 1:
            return textFieldArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addRecipeCell", for: indexPath) as? AddRecipeCell,
              let normalCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? IngredientsCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        normalCell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            normalCell.mainLabel.text = ingredients?[indexPath.row].rawValue.localized
            
            return normalCell
        case 1:
            cell.numberLabel.text = String(indexPath.row + 1)
            cell.explainTextField = textFieldArray[indexPath.row]
            cell.explainTextField.delegate = self
            
            return cell
        default:
            return UITableViewCell()
        }
        
        
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
