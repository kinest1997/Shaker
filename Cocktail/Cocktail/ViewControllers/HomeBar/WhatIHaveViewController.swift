import UIKit
import SnapKit
import RealmSwift

let myDi = Ingredients.vodka.base


class WhatIHaveViewController: UIViewController {
    
//    let realm = try! Realm()
//
//    var myDrinkList: Results<MyDrinks>?
    
    var myOwnDrink: [String] = []

    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
                                              
    var nowIngredients: [String] = []
    
    var whatIPicked: String? {
        didSet {
            switch whatIPicked {
            case "진":
               nowIngredients = ["진"]
            case "보드카":
                nowIngredients = ["보드카"]
            case "위스키":
                nowIngredients = ["스카치위스키", "버번위스키", "라이위스키", "위스키", "잭다니엘"]
            case "데킬라":
                nowIngredients = ["데킬라"]
            case "리큐르":
                nowIngredients = ["베일리스", "멜론리큐르", "화이트카카오리큐르", "스위트베르무트" , "피치트리", "자몽리큐르", "카카오리큐르", "크렘드카시스", "그린민트리큐르", "캄파리", "깔루아", "블루큐라소", "말리부", "바나나리큐르", "아마레또", "트리플섹", "버터스카치리큐르", "드라이베르무트" ]
            case "브랜디":
                nowIngredients = ["브랜디"]
            case "음료":
                nowIngredients = ["콜라", "토닉워터", "우유", "오렌지주스", "크렌베리주스", "탄산수", "자몽주스", "파인애플주스", "진저에일", "스윗앤사워믹스", "사과주스", "사이다", "레몬주스"]
            case "럼":
                nowIngredients = ["오버프루프럼", "화이트럼", "다크럼"]
            default:
                nowIngredients = ["라임", "라임즙", "레몬", "애플민트", "휘핑크림", "꿀", "올리브", "레몬즙", "올리브주스", "설탕시럽", "휘핑크림", "설탕", "생크림", "라임시럽", "그레나딘시럽"]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.addSubview(mainCollectionView)
        mainCollectionView.register(WhatIHaveCollectionViewCell.self, forCellWithReuseIdentifier: "key")
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }   
    }
}

extension WhatIHaveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "key", for: indexPath) as? WhatIHaveCollectionViewCell else { return UICollectionViewCell() }
        cell.nameLabel.text = nowIngredients[indexPath.row]
        cell.mainImageView.image = UIImage(named: nowIngredients[indexPath.row])
        //asset에 이름과 같은 이미지를 다 넣고 그걸 불러오는형식으로 하는게 좋을듯?
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 120, height: 120)
       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if myOwnDrink.contains(nowIngredients[indexPath.row]) {
            guard let state = myOwnDrink.firstIndex(of: nowIngredients[indexPath.row]) else { return }
            myOwnDrink.remove(at: state)
            print(myOwnDrink)
        } else {
            myOwnDrink.append(nowIngredients[indexPath.row])
            print(myOwnDrink)
        }
    }
}


//렘으로 바꾸기, 뒤의 뷰로 돌아갈때 뷰디드로드 안에다가 whatICanMake 함수로 현재 가진 재료들로 만들수있는 칵테일의 종류를 갱신하고, 가진 술의 갯수를 갱신한다.

//enum으로만들었을때, 만약 이넘의 base 라는 var 를 만들어서 접근할때 switch로 재료에 따라 base 를 뱉는게 다르도록,
// 저쪽에서 뷰디드로드에서 화면의 뱃지를 새로고침할떄 내가 가진 재료의 배열을 받아오는데. 그배열로 만들수있는 술의 갯수는 차집함 개념으로 만들어주고.내가 가진 술의 목록은 enum의 var를 이용해서 필터링을 해서 .count로 갯수를 적어준다. 만약 내가 가진 재료중 switch ~~ .base == gin 일경우 이름이 ~인 버튼의 뱃지는 .count 가 되는것으로. 

