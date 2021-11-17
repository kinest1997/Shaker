import UIKit
import SnapKit

class HomeBarViewController: UIViewController {
    
    var myDrink: Set<String> = []
    
    var originRecipe: [Cocktail] = []

//    var baseCount: Dictionary<String, Int> = [:]
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
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.object(forKey: "firstData") as? [String] {
            myDrink = Set(data)
        }
        updateWhatICanMakeButton(data: myDrink, button: whatICanMakeButton)
    }
    
    func updateIngredientsBadge(button: BadgeButton) {
        
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
        //여기있는 lastrecipe가 만들수있는 칵테일의 목록, 이걸 내가 만들수있는 칵테일 버튼을 누를때 이것을 데이터로 전달해줘야한다. 
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
            //넘겨주면서 변수값 정해주면 그 뷰컨의 데이터 정해주기
            $0.setImage(UIImage(named: "Martini"), for: .normal)
            $0.badge = "0"
            //버튼이 눌리는 시점의 버튼의 이름라벨의 텍스트값을 넣어주고싶다 아직 고민중
        }
        [tequilaButton, whiskeyButton, beverageButton].forEach {
            midStackView.addArrangedSubview($0)
            $0.setImage(UIImage(named: "Martini"), for: .normal)
            $0.badge = "22"
        }
        [brandyButton, rumButton, assetsButton].forEach {
            rightStackView.addArrangedSubview($0)
            $0.setImage(UIImage(named: "longone"), for: .normal)
            $0.badge = "4"
        }
        groupStackView.axis = .horizontal
        groupStackView.distribution = .fillEqually
        groupStackView.spacing = 10
        groupStackView.backgroundColor = .systemCyan
        whatICanMakeButton.backgroundColor = .systemBlue
        whatICanMakeButton.setTitle("만들수있는것", for: .normal)
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
            updateIngredientsBadge(button: $0)
        }
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
}

// 데이터를 저장할때, 버튼을 누를때마다 realm 에 저장되게 하고. 맨처음에 이 화면을불러올때도 realm 에서 불러오고. 버튼을 누르고 나갈때 realm 저장소에 넣고 빼고 하도록. set 형태에 먼저 넣고 그걸 array 로 감싸고


