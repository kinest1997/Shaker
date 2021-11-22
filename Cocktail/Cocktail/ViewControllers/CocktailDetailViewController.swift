import UIKit
import SnapKit

class CocktailDetailViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let cocktailImageView = UIImageView()
    
    let nameGuideLabel = UILabel()
    let nameLabel = UILabel()
    
    let alcoholGuideLabel = UILabel()
    let alcoholLabel = UILabel()
    
    let colorGuideLabel = UILabel()
    let colorLabel = UILabel()
    
    let baseDrinkGuideLabel = UILabel()
    let baseDrinkLabel = UILabel()
    
    let glassGuideLabel = UILabel()
    let glassLabel = UILabel()
    
    let craftGuideLabel = UILabel()
    let craftLabel = UILabel()
    
    let recipeGuideLabel = UILabel()
    let recipeLabel = UILabel()
    
    let myTipGuideLabel = UILabel()
    let myTipLabel = UILabel()
    
    let nameStackView =  UIStackView()
    let alcoholStackView = UIStackView()
    let colorStackView = UIStackView()
    let baseDrinkStackView = UIStackView()
    let glassStackView = UIStackView()
    let craftStackView = UIStackView()
    let recipeStackView = UIStackView()
    let mytipStackView = UIStackView()
    let groupStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        [groupStackView, cocktailImageView].forEach {
            mainView.addSubview($0)
        }
        
        [nameStackView, alcoholStackView, colorStackView, baseDrinkStackView, glassStackView, craftStackView, recipeStackView, mytipStackView].forEach {
            groupStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
        }
        [nameGuideLabel, alcoholGuideLabel, colorGuideLabel, baseDrinkGuideLabel, glassGuideLabel, craftGuideLabel, recipeGuideLabel, myTipGuideLabel].forEach {
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
        }
        
        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel, recipeLabel, myTipLabel].forEach {
            $0.textAlignment = .left
            $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
            $0.backgroundColor = .blue
            $0.numberOfLines = 0
        }
        
        nameStackView.addArrangedSubview(nameGuideLabel)
        nameStackView.addArrangedSubview(nameLabel)
        
        alcoholStackView.addArrangedSubview(alcoholGuideLabel)
        alcoholStackView.addArrangedSubview(alcoholLabel)
        
        colorStackView.addArrangedSubview(colorGuideLabel)
        colorStackView.addArrangedSubview(colorLabel)
        
        baseDrinkStackView.addArrangedSubview(baseDrinkGuideLabel)
        baseDrinkStackView.addArrangedSubview(baseDrinkLabel)
        
        glassStackView.addArrangedSubview(glassGuideLabel)
        glassStackView.addArrangedSubview(glassLabel)
        
        craftStackView.addArrangedSubview(craftGuideLabel)
        craftStackView.addArrangedSubview(craftLabel)
        
        recipeStackView.addArrangedSubview(recipeGuideLabel)
        recipeStackView.addArrangedSubview(recipeLabel)
        
        mytipStackView.addArrangedSubview(myTipGuideLabel)
        mytipStackView.addArrangedSubview(myTipLabel)

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
    
    func attribute() {
        cocktailImageView.image = UIImage(named: "Martini")
        groupStackView.axis = .vertical
        groupStackView.backgroundColor = .brown
        groupStackView.distribution = .fillEqually
        groupStackView.spacing = 20
        nameGuideLabel.text = "Name".localized
        alcoholGuideLabel.text = "Alcohol".localized
        colorGuideLabel.text = "Color".localized
        baseDrinkGuideLabel.text = "Base".localized
        glassGuideLabel.text = "Glass".localized
        craftGuideLabel.text = "Craft".localized
        recipeGuideLabel.text = "Recipe".localized
        myTipGuideLabel.text = "Tip".localized
    }

    func setData(data: Cocktail) {
        nameLabel.text = data.name
        alcoholLabel.text = data.alcohol.rawValue
        colorLabel.text = data.color.rawValue
        baseDrinkLabel.text = data.base.rawValue
        glassLabel.text = data.glass.rawValue
        craftLabel.text = data.craft.rawValue
        recipeLabel.text = data.recipe
        myTipLabel.text = data.mytip
    }
    
//    func alcoholSelect(data: String) -> String {
//        switch data {
//        case "high":
//            return "high".localized
//        case "mid":
//            return "mid".localized
//        default :
//            return "low".localized
//        }
//    }
}
