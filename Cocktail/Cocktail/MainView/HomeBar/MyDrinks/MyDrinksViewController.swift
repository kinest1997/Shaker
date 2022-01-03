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
    
    let whatICanMakeButton = MainButton()
    
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
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.splitLineGray.cgColor
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
            $0.trailing.equalToSuperview().offset(-20)
        }
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(topExplainLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(groupStackView.snp.width)
        }
        whatICanMakeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
            
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        view.addSubview(groupStackView)
        view.addSubview(whatICanMakeButton)
        view.addSubview(topNameLabel)
        view.addSubview(topExplainLabel)

        [leftStackView, midStackView, rightStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
        
        [vodkaButton, ginButton, liqueurButton].forEach {
            leftStackView.addArrangedSubview($0)
        }
        [tequilaButton, whiskeyButton, beverageButton].forEach {
            midStackView.addArrangedSubview($0)
        }
        [brandyButton, rumButton, assetsButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        vodkaButton.setImage(UIImage(named: "vodka"), for: .normal)
        ginButton.setImage(UIImage(named: "gin"), for: .normal)
        liqueurButton.setImage(UIImage(named: "liqueur"), for: .normal)
        tequilaButton.setImage(UIImage(named: "tequila"), for: .normal)
        whiskeyButton.setImage(UIImage(named: "whiskey"), for: .normal)
        
        beverageButton.setImage(UIImage(named: "coke"), for: .normal)
        brandyButton.setImage(UIImage(named: "brandy"), for: .normal)
        rumButton.setImage(UIImage(named: "rum"), for: .normal)
        assetsButton.setImage(UIImage(named: "sugarSyrup"), for: .normal)
        
        topNameLabel.textColor = .mainGray
        topExplainLabel.textColor = .mainGray
        topNameLabel.text = "내 술장"
        topNameLabel.font = .nexonFont(ofSize: 30, weight: .bold)
        topExplainLabel.font = .nexonFont(ofSize: 15, weight: .semibold)
        topExplainLabel.text = "내가 가지고 있는 재료로 만들 수 있는 레시피를 알아봐요!"
        topExplainLabel.numberOfLines = 0
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
        whatICanMakeButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let whatICanMakeViewController = CocktailListViewController()
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
        let sortedData = checkWhatICanMake(myIngredients: data)

        if sortedData.count != 0 {
             button.backgroundColor = .tappedOrange
            button.setTitle("\(sortedData.count)" + " " + "EA".localized + " " + "making".localized, for: .normal)
        } else {
            button.backgroundColor = .white
            button.setTitle("재료를 더 선택해주세요!", for: .normal)
        }
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
