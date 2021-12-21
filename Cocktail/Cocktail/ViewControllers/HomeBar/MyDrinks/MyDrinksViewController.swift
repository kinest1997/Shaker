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
    let topNameLabel = UILabel()
    let topExplainLabel = UILabel()
    
    let ginButton = BadgeButton()
    let vodkaButton = BadgeButton()
    let rumButton = BadgeButton()
    let tequilaButton = BadgeButton()
    let whiskeyButton = BadgeButton()
    let liqueurButton = BadgeButton()
    let brandyButton = BadgeButton()
    let beverageButton = BadgeButton()
    let assetsButton = BadgeButton()
    
    let whatICanMakeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originRecipe = FirebaseRecipe.shared.recipe
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
        topNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        topExplainLabel.snp.makeConstraints {
            $0.top.equalTo(topNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topNameLabel)
            $0.height.equalTo(20)
        }
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(topExplainLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(groupStackView.snp.width)
        }
        whatICanMakeButton.snp.makeConstraints {
            $0.top.equalTo(groupStackView.snp.bottom).offset(40)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70)
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        view.addSubview(groupStackView)
        view.addSubview(whatICanMakeButton)
        view.addSubview(topNameLabel)
        view.addSubview(topExplainLabel)
        
//        topExplainLabel.sizeToFit()
//        topNameLabel.sizeToFit()
        [leftStackView, midStackView, rightStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
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
        
        topNameLabel.textColor = .black
        topExplainLabel.textColor = .black
        topNameLabel.text = "내 술장"
        topNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topExplainLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        topExplainLabel.text = "내가 가지고 있는 재료로 만들 수 있는 레시피를 알아봐요!"
        groupStackView.axis = .horizontal
        groupStackView.distribution = .fillEqually
        groupStackView.spacing = 10
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
        whatICanMakeButton.layer.cornerRadius = 15
        whatICanMakeButton.clipsToBounds = true
        whatICanMakeButton.backgroundColor = .brown
        whatICanMakeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        whatICanMakeButton.setTitleColor(.black, for: .normal)
        whatICanMakeButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let whatICanMakeViewController = CocktailListTableView()
            whatICanMakeViewController.lastRecipe = self.checkWhatICanMake(myIngredients: self.myDrink)
            self.show(whatICanMakeViewController, sender: nil)
        }), for: .touchUpInside)
    }
    
    func setButtonAction(buttonName: BadgeButton) {
        buttonName.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let whatIHaveViewController = WhatIHaveViewController()
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
    
    func updateWhatICanMakeButton(data: Set<String>, button: UIButton) {
        button.setTitle("\(checkWhatICanMake(myIngredients: data).count)" + " " + "EA".localized + " " + "making".localized, for: .normal)
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
