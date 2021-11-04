import UIKit
import SnapKit

class CocktailDetailViewController: UIViewController {
    
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
    
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()
    
    let colorStackView = UIStackView()
    let baseDrinkStackView = UIStackView()
    let glassStackViewk = UIStackView()
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
        cocktailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        groupStackView.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(50)
        }
    }
    func attribute() {
        [groupStackView, cocktailImageView].forEach {
            view.addSubview($0)
        }
        [nameLabel, alcoholLabel, colorLabel, baseDrinkLabel, glassLabel, craftLabel].forEach {
            rightStackView.addArrangedSubview($0)
        }
        [nameGuideLabel, alcoholGuideLabel, colorGuideLabel, baseDrinkGuideLabel, glassGuideLabel, craftGuideLabel].forEach {
            leftStackView.addArrangedSubview($0)
        }
        groupStackView.addArrangedSubview(leftStackView)
        groupStackView.addArrangedSubview(rightStackView)
        
        leftStackView.axis = .vertical
        rightStackView.axis = .vertical
        leftStackView.alignment = .center
        leftStackView.contentHuggingPriority(for: <#T##NSLayoutConstraint.Axis#>)
        leftStackView.distribution = .fillEqually
        rightStackView.distribution = .fillEqually
        leftStackView.spacing = 10
        rightStackView.spacing = 10
        nameGuideLabel.text = "이름"
        alcoholGuideLabel.text = "도수"
        colorGuideLabel.text = "색깔"
        baseDrinkGuideLabel.text = "기주"
        glassGuideLabel.text = "잔"
        craftGuideLabel.text = "조주방법"
        recipeGuideLabel.text = "레시피"
        myTipGuideLabel.text = "팁"
        
    }

    func setData(data: Cocktail) {
        nameLabel.text = data.name
        alcoholLabel.text = alcoholSelect(data: data.alcohol.rawValue)
        colorLabel.text = data.color.rawValue
        baseDrinkLabel.text = data.base.rawValue
        glassLabel.text = data.glass.rawValue
        craftLabel.text = data.craft.rawValue
        recipeLabel.text = data.recipe
        myTipLabel.text = data.mytip
    }
    
    func alcoholSelect(data: String) -> String {
        switch data {
        case "high":
            return "높음"
        case "mid":
            return "중간"
        default :
            return "낮음"
        }
    }
}
