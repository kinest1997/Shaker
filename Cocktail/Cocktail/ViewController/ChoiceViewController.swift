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
        
        ginButton.setTitle("진", for: .normal)
        tequilaButton.setTitle("데킬라", for: .normal)
        rumButton.setTitle("럼", for: .normal)
        vodkaButton.setTitle("보드카", for: .normal)
        whiskeyButton.setTitle("위스키", for: .normal)
        brandyButton.setTitle("브랜디", for: .normal)
        anyThingButton.setTitle("다좋아!", for: .normal)
        anyThingButton.backgroundColor = .systemMint
        
        ginButton.addAction(baseDrinkAction(base: "진"), for: .touchUpInside)
        tequilaButton.addAction(baseDrinkAction(base: "데킬라"), for: .touchUpInside)
        rumButton.addAction(baseDrinkAction(base: "럼"), for: .touchUpInside)
        vodkaButton.addAction(baseDrinkAction(base: "보드카"), for: .touchUpInside)
        whiskeyButton.addAction(baseDrinkAction(base: "위스키"), for: .touchUpInside)
        brandyButton.addAction(baseDrinkAction(base: "브랜디"), for: .touchUpInside)
        anyThingButton.addAction(baseDrinkAction(base: "다좋아!"), for: .touchUpInside)
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
    
    func baseFilter(base: String) -> [Cocktail] {
        switch base {
        case "진":
            return filterSortedRecipe(base: "진")
        case "데킬라":
            return filterSortedRecipe(base: "데킬라")
        case "럼":
            return filterSortedRecipe(base: "럼")
        case "보드카":
            return filterSortedRecipe(base: "보드카")
        case "위스키":
            return filterSortedRecipe(base: "위스키")
        case "브랜디":
            return filterSortedRecipe(base: "브랜디")
        default:
            return firstRecipe
        }
    }
    
    func filterSortedRecipe(base: String) -> [Cocktail] {
        let filterdRecipe = firstRecipe.filter {
            $0.base.rawValue == base
        }.sorted { $0.ingredients.count < $1.ingredients.count}
        return filterdRecipe
    }
}

