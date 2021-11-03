import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    
    func layout() {
        
    }
    func attribute() {
        
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
            return "높아요"
        case "mid":
            return "먹을만해요"
        default :
            return "음료수같아요"
        }
    }
}
