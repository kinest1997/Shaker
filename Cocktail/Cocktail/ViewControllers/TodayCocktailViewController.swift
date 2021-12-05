import UIKit
import SnapKit

class TodayCocktailViewController: UIViewController {
    
    var originRecipes: [Cocktail] = []
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let firstButton = UIButton()
    let secondButton = UIButton()
    let thirdButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originRecipes = FirebaseRecipe.shared.recipe
        attribute()
        layout()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "firstLogin") == true {
            UserDefaults.standard.set(false, forKey: "firstLogin")
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .overFullScreen
            self.show(loginViewController, sender: nil)
        }
    }
    
    func attribute() {
        let beginner = UIAction {[weak self] _ in
            guard let self = self else { return }
            let choiceViewController = ChoiceViewController()
            choiceViewController.firstRecipe = self.bigChoice(alcohol: .low)
            choiceViewController.firstRecipe.append(contentsOf: self.bigChoice(alcohol: .mid))
            self.show(choiceViewController, sender: nil)
        }
        
        let expert = UIAction {[weak self] _ in
            guard let self = self else { return }
            let choiceViewController = ChoiceViewController()
            choiceViewController.firstRecipe = self.bigChoice(alcohol: .high)
            self.show(choiceViewController, sender: nil)
        }
        
        firstButton.addAction(beginner, for: .touchUpInside)
        secondButton.addAction(expert, for: .touchUpInside)
        mainScrollView.backgroundColor = .systemGray
        firstButton.backgroundColor = .systemBlue
        firstButton.setTitle("Beginner".localized, for: .normal)
        secondButton.setTitle("High Proof".localized, for: .normal)
        secondButton.backgroundColor = .systemRed
        thirdButton.setTitle("My Own".localized, for: .normal)
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
    
    func bigChoice(alcohol: Cocktail.Alcohol) -> [Cocktail] {
        let filtered = originRecipes.filter {
            $0.alcohol == alcohol
        }
        return filtered
    }
}
