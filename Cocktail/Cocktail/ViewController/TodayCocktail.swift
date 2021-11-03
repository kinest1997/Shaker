import UIKit
import SnapKit

class TodayCocktailViewController: UIViewController {
    
    var rawRecipes: [Cocktail] = []
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let firstButton = UIButton()
    let secondButton = UIButton()
    let thirdButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe()
        attribute()
        layout()
        navigationController?.navigationBar.isHidden = true
    }
    
    func attribute() {
        let beginner = UIAction { [weak self] _ in
            guard let self = self else { return }
            print("초보자용")
            let choiceViewController = ChoiceViewController()
            choiceViewController.firstRecipe = self.bigChoice(alcohol: "low")
            choiceViewController.firstRecipe.append(contentsOf: self.bigChoice(alcohol: "mid"))
            self.show(choiceViewController, sender: nil)
        }
        
        //위아래를 뭔가 함수로 만들어서 간단하게 하고싶은데 일단 보류
        
        let expert = UIAction { [weak self]_ in
            guard let self = self else { return }
            let choiceViewController = ChoiceViewController()
            choiceViewController.firstRecipe = self.bigChoice(alcohol: "high")
            self.show(choiceViewController, sender: nil)
        }
        
        firstButton.addAction(beginner, for: .touchUpInside)
        secondButton.addAction(expert, for: .touchUpInside)
        mainScrollView.backgroundColor = .systemGray
        firstButton.backgroundColor = .systemBlue
        firstButton.setTitle("초보추천", for: .normal)
        secondButton.setTitle("고도수추천", for: .normal)
        secondButton.backgroundColor = .systemRed
        thirdButton.setTitle("내추천", for: .normal)
        thirdButton.backgroundColor = .systemPink
    }
    
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        [firstButton, secondButton, thirdButton].forEach {
            mainView.addSubview($0)
        }
        mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.height.equalToSuperview()
        }
        mainScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        firstButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(150)
            $0.centerX.equalToSuperview()
        }
        secondButton.snp.makeConstraints {
            $0.top.equalTo(firstButton.snp.bottom).offset(50)
            $0.width.equalTo(300)
            $0.height.equalTo(150)
            $0.centerX.equalToSuperview()
        }
        thirdButton.snp.makeConstraints {
            $0.top.equalTo(secondButton.snp.bottom).offset(50)
            $0.width.equalTo(300)
            $0.height.equalTo(150)
            $0.centerX.equalToSuperview()
        }
    }
    
    func bigChoice(alcohol: String) -> [Cocktail] {
        switch alcohol {
        case "high":
            let filtered = rawRecipes.filter {
                $0.alcohol.rawValue == "high"
            }
            return filtered
        case "mid":
            let filtered = rawRecipes.filter {
                $0.alcohol.rawValue == "mid"
            }
            return filtered
        default:
            let filtered = rawRecipes.filter {
                $0.alcohol.rawValue == "low"
            }
            return filtered
        }
    }
    
    func getRecipe() {
        guard let cocktailURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist"), let cocktailData = FileManager.default.contents(atPath: cocktailURL.path) else { return }
        do {
            rawRecipes = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData)
        } catch let error{
            print("머선129",error.localizedDescription)
        }
    }
}
