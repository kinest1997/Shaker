import UIKit
import SnapKit

class ChoiceViewController: UIViewController {
    
    var firstRecipe: [Cocktail] = []
    
    let mainBigStackView = UIStackView()
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()
    
    let ginButton = UIButton()
    let tequilaButton = UIButton()
    let rumButton = UIButton()
    let vodkaButton = UIButton()
    let brandyButton = UIButton()
    let whiskeyButton = UIButton()
    let anyThingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        attribute()
        layout()
    }
    
    func layout() {
        mainBigStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(200)
        }
        anyThingButton.snp.makeConstraints {
            $0.top.equalTo(mainBigStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func attribute() {
        view.addSubview(mainBigStackView)
        view.backgroundColor = .systemBackground
        
        view.addSubview(anyThingButton)
        mainBigStackView.addArrangedSubview(leftStackView)
        mainBigStackView.addArrangedSubview(rightStackView)
        [ginButton, tequilaButton, vodkaButton].forEach {
            leftStackView.addArrangedSubview($0)
        }
        [rumButton, brandyButton, whiskeyButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        mainBigStackView.backgroundColor = .systemBrown
        mainBigStackView.axis = .horizontal
        mainBigStackView.distribution = .fillEqually
        leftStackView.distribution = .fillEqually
        rightStackView.distribution = .fillEqually
        leftStackView.axis = .vertical
        rightStackView.axis = .vertical
        
        ginButton.setTitle("gin".localized, for: .normal)
        tequilaButton.setTitle("tequila".localized, for: .normal)
        rumButton.setTitle("rum".localized, for: .normal)
        vodkaButton.setTitle("vodka".localized, for: .normal)
        whiskeyButton.setTitle("whiskey".localized, for: .normal)
        brandyButton.setTitle("brandy".localized, for: .normal)
        anyThingButton.setTitle("Anything!".localized, for: .normal)
        anyThingButton.backgroundColor = .systemMint
        
        ginButton.addAction(baseDrinkAction(base: "gin".localized), for: .touchUpInside)
        tequilaButton.addAction(baseDrinkAction(base: "tequila".localized), for: .touchUpInside)
        rumButton.addAction(baseDrinkAction(base: "rum".localized), for: .touchUpInside)
        vodkaButton.addAction(baseDrinkAction(base: "vodka".localized), for: .touchUpInside)
        whiskeyButton.addAction(baseDrinkAction(base: "whiskey".localized), for: .touchUpInside)
        brandyButton.addAction(baseDrinkAction(base: "brandy".localized), for: .touchUpInside)
        anyThingButton.addAction(baseDrinkAction(base: "Anything!".localized), for: .touchUpInside)
    }
    
    func baseDrinkAction(base: String) -> UIAction {
        let buttonAction = UIAction { [weak self]_ in
            guard let self = self else { return }
            let cocktailListTableView = CocktailListTableView()
            cocktailListTableView.lastRecipe = self.baseFilter(base: base)
            cocktailListTableView.title = base
            self.show(cocktailListTableView, sender: nil)
        }
        return buttonAction
    }
    
    //FIXME: (보영)이 부분 왜 스트링을 받음? Base를 받는 것이 나음
    func baseFilter(base: String) -> [Cocktail] {
        switch base {
        case "gin".localized:
            return filterSortedRecipe(base: "gin".localized)
        case "tequila".localized:
            return filterSortedRecipe(base: "tequila".localized)
        case "rum".localized:
            return filterSortedRecipe(base: "rum".localized)
        case "vodka".localized:
            return filterSortedRecipe(base: "vodka".localized)
        case "whiskey".localized:
            return filterSortedRecipe(base: "whiskey".localized)
        case "brandy".localized:
            return filterSortedRecipe(base: "brandy".localized)
        default:
            return firstRecipe
        }
    }
    
    //FIXME: 여기도 마찬가지
    func filterSortedRecipe(base: String) -> [Cocktail] {
        let filterdRecipe = firstRecipe.filter {
            $0.base.rawValue == base
        }.sorted { $0.ingredients.count < $1.ingredients.count}
        return filterdRecipe
    }
}

