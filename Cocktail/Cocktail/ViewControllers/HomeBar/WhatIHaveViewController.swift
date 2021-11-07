import UIKit
import SnapKit

class WhatIHaveViewController: UIViewController {
    

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

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if nowIngredients[indexPath.row]
//    }
    
}
