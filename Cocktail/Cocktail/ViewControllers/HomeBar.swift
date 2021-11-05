import UIKit

class HomeBarViewController: UIViewController {
    
    var myDrink: Set<String> = ["럼", "보드카", "탄산수", "설탕", "라임주스", "콜라", "레몬즙", "진저에일","진","토닉워터"]
    var originRecipe: [Cocktail] = []
    
    var lastRecipe: [Cocktail] = []
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    
    let leftStackView = UIStackView()
    let midStackView = UIStackView()
    let rightStackView = UIStackView()
    let groupStackView = UIStackView()
    
    let ginButton = BadgeButton()
    let tequilaButton = UIButton()
    let vodkaButton = UIButton()
    let liquorButton = UIButton()
    let whiskeyButton = UIButton()
    let brandyButton = UIButton()
    let rumButton = UIButton()
    let syrupAlcohol = UIButton()
    let pantryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(data: &originRecipe)
    }
}

//originRecipe.forEach {
//    let someSet = Set($0.ingredients)
//    if someSet.subtracting(myDrink).isEmpty {
//        lastRecipe.append($0)
//    }
//}
