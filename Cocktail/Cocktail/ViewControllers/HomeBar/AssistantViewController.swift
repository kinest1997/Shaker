import UIKit
import SnapKit

class AssistantViewController: UIViewController {
    
    let myRecipeButton = UIButton()
    let myBarButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        myRecipeButton.addAction(UIAction(handler: { [weak self]_ in
            let myOwnCocktailRecipeViewController = MyOwnCocktailRecipeViewController()
            self?.show(myOwnCocktailRecipeViewController, sender: nil)
        }), for: .touchUpInside)
        
        myBarButton.addAction(UIAction(handler: { [weak self]_ in
            let homeBarViewController = MyDrinksViewController()
            self?.show(homeBarViewController, sender: nil)
        }), for: .touchUpInside)
        
        myRecipeButton.backgroundColor = .blue
        myRecipeButton.setTitle("나의 레시피", for: .normal)
        myBarButton.backgroundColor = .red
    }
    
    func layout() {
        view.addSubview(myRecipeButton)
        view.addSubview(myBarButton)
        myRecipeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(150)
            $0.centerX.equalToSuperview()
        }
        myBarButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
}
