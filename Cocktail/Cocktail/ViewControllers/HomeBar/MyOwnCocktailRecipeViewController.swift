import UIKit
import SnapKit

class MyOwnCocktailRecipeViewController: UIViewController {
    let touches = UITouch()
    
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
            UIAction(title: "High".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "Mid".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "Low".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in })
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
            UIAction(title: "red".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { [unowned self]_ in self.colorChoiceButton.setTitle("red".localized, for: .normal)}),
            UIAction(title: "orange".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "yellow".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "green".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "blue".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "violet".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "clear".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "white".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "black".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "brown".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in })
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
            UIAction(title: "rum".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "vodka".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "tequila".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "brandy".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "whiskey".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "gin".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "liqueur".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "assets".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "beverage".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in })
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
            UIAction(title: "build".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "shaking".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "floating".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "stir".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "blending".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in })
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
            UIAction(title: "highBall".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "shot".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "onTheRock".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "cocktail".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "martini".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "collins".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "margarita".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in }),
            UIAction(title: "philsner".localized, image: UIImage(systemName: "bolt.fill"),state: .off, handler: { _ in })
        ]
    }
    var glassSelectMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: glassSelectMenuItems)
    }
    
    let recipeLabel = UILabel()
    let recipeTextField = UITextField()
    let recipeStackView = UIStackView()
    
    let myTipLabel = UILabel()
    let myTipTextField = UITextField()
    let myTipStackView = UIStackView()
    
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
        nameTextField.placeholder = "여기엔 이름"
        recipeTextField.placeholder = "여기엔 레시피"
        myTipTextField.placeholder = "여기엔 당신의 팁"
    }

    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)

        [groupStackView, cocktailImageView].forEach {
            mainView.addSubview($0)
        }

        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, glassStackView, craftStackView, recipeStackView, myTipStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
        }

        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, recipeLabel, myTipLabel].forEach {
            $0.textAlignment = .center
            $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
            $0.backgroundColor = .blue
            $0.numberOfLines = 0
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
        }
        
        [alcoholChoiceButton, colorChoiceButton, baseDrinkChoiceButton, glassChoiceButton, craftChoiceButton].forEach {
            $0.setTitle("선택", for: .normal)
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
    }
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
}

extension MyOwnCocktailRecipeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        [nameTextField, recipeTextField, myTipTextField].forEach {
            $0.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //이거 왜 안됨? 개빡치네
        //일단 다른방법 찾음 스크롤뷰는 스크롤해야해서 한번의 터치는 원래 씹는다네
    }
    
}
