import UIKit
import SnapKit

class MyDrinksViewController: UIViewController {
    
    var myDrink: Set<String> = []
    
    var originRecipe: [Cocktail] = []

    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let leftStackView = UIStackView()
    let midStackView = UIStackView()
    let rightStackView = UIStackView()
    let groupStackView = UIStackView()
    
    let ginButton = BadgeButton()
    let vodkaButton = BadgeButton()
    let rumButton = BadgeButton()
    let tequilaButton = BadgeButton()
    let whiskeyButton = BadgeButton()
    let liqueurButton = BadgeButton()
    let brandyButton = BadgeButton()
    let beverageButton = BadgeButton()
    let assetsButton = BadgeButton()
    
    let whatICanMakeButton = BadgeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(data: &originRecipe)
        attribute()
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] {
            myDrink = Set(data)
        }
        updateWhatICanMakeButton(data: myDrink, button: whatICanMakeButton)
        [vodkaButton, ginButton, whiskeyButton, tequilaButton, liqueurButton, brandyButton, beverageButton, rumButton, assetsButton].forEach {
            updateIngredientsBadge(button: $0)
        }
    }
    
   
    func layout() {
        mainScrollView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(170)
        }
        mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.height.equalToSuperview()
        }
        groupStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        whatICanMakeButton.snp.makeConstraints {
            $0.top.equalTo(mainScrollView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func attribute() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(groupStackView)
        view.addSubview(whatICanMakeButton)
        [leftStackView, midStackView, rightStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
            $0.backgroundColor = .green
        }
        
        [vodkaButton, ginButton, liqueurButton].forEach {
            leftStackView.addArrangedSubview($0)
            $0.setImage(UIImage(named: "Martini"), for: .normal)
        }
        [tequilaButton, whiskeyButton, beverageButton].forEach {
            midStackView.addArrangedSubview($0)
            $0.setImage(UIImage(named: "Martini"), for: .normal)
        }
        [brandyButton, rumButton, assetsButton].forEach {
            rightStackView.addArrangedSubview($0)
            $0.setImage(UIImage(named: "Martini"), for: .normal)
        }
        groupStackView.axis = .horizontal
        groupStackView.distribution = .fillEqually
        groupStackView.spacing = 10
        groupStackView.backgroundColor = .systemCyan
        whatICanMakeButton.backgroundColor = .systemBlue
        whatICanMakeButton.setTitle("What I Can Make".localized, for: .normal)
        whatICanMakeButton.badgeBackgroundColor = .systemBlue
        vodkaButton.base = .vodka
        whiskeyButton.base = .whiskey
        tequilaButton.base = .tequila
        ginButton.base = .gin
        liqueurButton.base = .liqueur
        brandyButton.base = .brandy
        beverageButton.base = .beverage
        rumButton.base = .rum
        assetsButton.base = .assets
        [vodkaButton, ginButton, whiskeyButton, tequilaButton, liqueurButton, brandyButton, beverageButton, rumButton, assetsButton].forEach {
            setButtonAction(buttonName: $0)
        }
        
        whatICanMakeButton.addAction(UIAction(handler: { [weak self]_ in
            guard let self = self else { return }
            let whatICanMakeViewController = CocktailListTableView()
            whatICanMakeViewController.lastRecipe = self.checkWhatICanMake(myIngredients: self.myDrink)
            self.show(whatICanMakeViewController, sender: nil)
        }), for: .touchUpInside)
    }
    
    func setButtonAction(buttonName: BadgeButton) {
        buttonName.addAction(UIAction(handler: { [weak self]_ in
            guard let self = self else { return }
            let whatIHaveViewController = WhatIHaveViewController()
//            whatIHaveViewController.whatIPicked = buttonName.base
            whatIHaveViewController.refreshList = buttonName.base
            self.show(whatIHaveViewController, sender: nil)
        }), for: .touchUpInside)
    }
    
    func updateIngredientsBadge(button: BadgeButton) {
        let origin = Set(button.base.list.map {
            $0.rawValue })
        let subtracted = origin.subtracting(myDrink)
        let originCount = origin.count - subtracted.count
        button.badge = "\(originCount)"
        }
    
    func updateWhatICanMakeButton(data: Set<String>, button: BadgeButton) {
        button.badge = "\(checkWhatICanMake(myIngredients: data).count)"
    }
    
    func checkWhatICanMake(myIngredients: Set<String>) -> [Cocktail] {
        var lastRecipe = [Cocktail]()
        originRecipe.forEach {
            let someSet = Set($0.ingredients.map({ baby in
                baby.rawValue
            }))
            if someSet.subtracting(myIngredients).isEmpty {
                lastRecipe.append($0)
            }
        }
        return lastRecipe
    }
}


