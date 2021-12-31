import UIKit
import SnapKit
import FirebaseAuth

class AssistantViewController: UIViewController {
    
    let myRecipeButton = UIButton()
    let myBarButton = UIButton()
    let wishListButton = UIButton()
    let mainStackView = UIStackView()
    let mainImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(named: "miniButtonGray")
        attribute()
        layout()
    }
    
    func attribute() {
        myRecipeButton.addAction(UIAction(handler: {[weak self] _ in
            if Auth.auth().currentUser?.uid == nil {
                self?.pleaseLoginAlert()
            } else {
                let myOwnCocktailRecipeViewController = MyOwnCocktailRecipeViewController()
                self?.show(myOwnCocktailRecipeViewController, sender: nil)
            }
        }), for: .touchUpInside)
        
        myBarButton.addAction(UIAction(handler: {[weak self] _ in
            let homeBarViewController = MyDrinksViewController()
            self?.show(homeBarViewController, sender: nil)
        }), for: .touchUpInside)
        wishListButton.addAction(UIAction(handler: {[weak self] _ in
            if Auth.auth().currentUser?.uid == nil {
                self?.pleaseLoginAlert()
            } else {
                let wishListCocktailListTableView = WishListCocktailListViewController()
                self?.show(wishListCocktailListTableView, sender: nil)
            }
            
        }), for: .touchUpInside)
        myRecipeButton.setTitle("My Recipes".localized, for: .normal)
        myBarButton.setTitle("My Drinks".localized, for: .normal)
        wishListButton.setTitle("Bookmark".localized, for: .normal)
        view.backgroundColor = .white
        myRecipeButton.setTitleColor(.black, for: .normal)
        myBarButton.setTitleColor(.black, for: .normal)
        wishListButton.setTitleColor(.black, for: .normal)
        [myRecipeButton, myBarButton, wishListButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
            $0.backgroundColor = .systemGray
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        
        mainImageView.image = UIImage(named: "mybar")
    }
    
    func layout() {
        view.addSubview(mainStackView)
        view.addSubview(mainImageView)
        mainStackView.addArrangedSubview(myRecipeButton)
        mainStackView.addArrangedSubview(myBarButton)
        mainStackView.addArrangedSubview(wishListButton)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 20
        mainStackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(mainImageView.snp.bottom)
        }
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(250)
        }
    }
    
    func pleaseLoginAlert() {
        let alert = UIAlertController(title: "로그인시에 사용가능합니다".localized, message: "로그인은 설정에서 할수있습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
