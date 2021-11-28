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
        
        ginButton.addAction(baseDrinkAction(base: .gin), for: .touchUpInside)
        tequilaButton.addAction(baseDrinkAction(base: .tequila), for: .touchUpInside)
        rumButton.addAction(baseDrinkAction(base: .rum), for: .touchUpInside)
        vodkaButton.addAction(baseDrinkAction(base: .vodka), for: .touchUpInside)
        whiskeyButton.addAction(baseDrinkAction(base: .whiskey), for: .touchUpInside)
        brandyButton.addAction(baseDrinkAction(base: .brandy), for: .touchUpInside)
        anyThingButton.addAction(baseDrinkAction(base: .beverage), for: .touchUpInside)
    }
    
    func baseDrinkAction(base: Cocktail.Base) -> UIAction {
        let buttonAction = UIAction { [weak self]_ in
            guard let self = self else { return }
            let cocktailListTableView = CocktailListTableView()
            cocktailListTableView.lastRecipe = self.filterSortedRecipe(base: base)
            cocktailListTableView.title = base.rawValue
            self.show(cocktailListTableView, sender: nil)
        }
        return buttonAction
    }
    
    func filterSortedRecipe(base: Cocktail.Base) -> [Cocktail] {
        if base == .beverage {
            return firstRecipe
        }
        
        let filterdRecipe = firstRecipe.filter {
            $0.base == base
        }.sorted { $0.ingredients.count < $1.ingredients.count}
        return filterdRecipe
    }
}

