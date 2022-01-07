import UIKit
import SnapKit
import FirebaseAuth

class AssistantViewController: UIViewController {
    
    enum Assist: Int, CaseIterable {
        case myDrink
        case myOwnCocktail
        case wishList
        
        var title: String {
            switch self {
            case .myDrink:
                return "내 술장"
            case .myOwnCocktail:
                return "나의 레시피"
            case .wishList:
                return "즐겨찾기"
            }
        }
        
        var explain: String {
            switch self {
            case .myDrink:
                return "내가 가지고 있는 재료로 만들수 있는 레시피를 알아봐요"
            case .myOwnCocktail:
                return "내가 만든 레시피를 보러가요"
            case .wishList:
                return "내가 즐겨찾기에 추가한 레시피를 보러가요"
            }
        }
    }
    
    let mainTableView = UITableView()
    let topTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.register(AssistantCell.self, forCellReuseIdentifier: "AssistantCell")
        mainTableView.isScrollEnabled = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        attribute()
        layout()
    }
    
    func attribute() {
        mainTableView.separatorStyle = .none
        topTitleLabel.text = "마이페이지".localized
        topTitleLabel.font = .nexonFont(ofSize: 24, weight: .bold)
        topTitleLabel.textAlignment = .center
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(mainTableView)
        view.addSubview(topTitleLabel)
        topTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(100)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AssistantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Assist.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let homeBarViewController = MyDrinksViewController()
            self.show(homeBarViewController, sender: nil)
        case 1:
            if Auth.auth().currentUser?.uid == nil {
                self.pleaseLoginAlert()
            } else {
                let myOwnCocktailRecipeViewController = MyOwnCocktailRecipeViewController()
                self.show(myOwnCocktailRecipeViewController, sender: nil)
            }
        case 2:
            if Auth.auth().currentUser?.uid == nil {
                self.pleaseLoginAlert()
            } else {
                let wishListCocktailListTableView = WishListCocktailListViewController()
                self.show(wishListCocktailListTableView, sender: nil)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AssistantCell", for: indexPath) as? AssistantCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.titleLabel.text = Assist(rawValue: indexPath.row)?.title
        cell.explainLabel.text = Assist(rawValue: indexPath.row)?.explain
        cell.mainImageView.image = UIImage(named: Assist(rawValue: indexPath.row)?.title ?? "")?.resize()
        return cell
    }
}
