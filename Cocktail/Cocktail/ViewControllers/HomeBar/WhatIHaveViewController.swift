import UIKit
import SnapKit

class WhatIHaveViewController: UIViewController {
    
    var ingredientsWhatIhave: [String] = []
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var allIngredients: [Cocktail.Ingredients] = []
    
    var whatIPicked: String! {
        didSet {
            let baseList = Cocktail.Base.allCases.map { $0.rawValue
            }
            switch whatIPicked {
            case baseList[0]:
                allIngredients = Cocktail.Base.rum.list
            case baseList[1]:
                allIngredients = Cocktail.Base.vodka.list
            case baseList[2]:
                allIngredients = Cocktail.Base.tequila.list
            case baseList[3]:
                allIngredients = Cocktail.Base.brandy.list
            case baseList[4]:
                allIngredients = Cocktail.Base.whiskey.list
            case baseList[5]:
                allIngredients = Cocktail.Base.gin.list
            case baseList[6]:
                allIngredients = Cocktail.Base.liqueur.list
            case baseList[7]:
                allIngredients = Cocktail.Base.assets.list
            case baseList[8]:
                allIngredients = Cocktail.Base.beverage.list
            default:
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.addSubview(mainCollectionView)
        mainCollectionView.register(WhatIHaveCollectionViewCell.self, forCellWithReuseIdentifier: "key")
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        guard let data = UserDefaults.standard.object(forKey: "firstData") as? [Cocktail.Ingredients.RawValue] else { return }
        ingredientsWhatIhave = data
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(ingredientsWhatIhave, forKey: "firstData")
    }
}
// 해야하는것 일단은 뱃지 숫자 갱신되게 하는것. 뱃지 숫자 갱신 시키려면 내가 가진 술 배열을 받아와서 그 갯수의 카운트로 넣어준다. 근데 내가 선택했는지 안했는지는 알수가없으니까 새로운 자료 구조를 이용해서하자.
// 만약 재료의 불값이 true라면 셀의 이미지에 보이는걸 다르게 보여주고, 만약 true라면 또 바꿔주고. 셀을 누를때 그 재료의 bool값이 true라면 false로 바꿔주고 내가 가진 재료 array에서 제거하고, plist에서도 제거. 그리고 반대의 경우에는 추가해주고 plist에도 추가. 내가 가진 재료로 만들수있는 칵테일을 알고싶을때, map을 이용해서 myDrinks struct의 ingredients 로 바꿔주고 그 배열을 이제 set을 이용해서 subtract를 사용하여 다시 정렬. 일단 제일먼저 myDrinks 자료 만들기, 그리고 내가 만들수있는 칵테일을 알게 되었을떄 띄울 뷰

extension WhatIHaveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "key", for: indexPath) as? WhatIHaveCollectionViewCell else { return UICollectionViewCell() }
        cell.nameLabel.text = allIngredients[indexPath.row].rawValue
        cell.mainImageView.image = UIImage(named: allIngredients[indexPath.row].rawValue)
        //asset에 이름과 같은 이미지를 다 넣고 그걸 불러오는형식으로 하는게 좋을듯?
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ingredientsWhatIhave.contains(allIngredients[indexPath.row].rawValue) {
            guard let index = ingredientsWhatIhave.firstIndex(of: allIngredients[indexPath.row].rawValue) else { return }
            ingredientsWhatIhave.remove(at: index)
            print(ingredientsWhatIhave)
        } else {
            ingredientsWhatIhave.append(allIngredients[indexPath.row].rawValue)
            print(ingredientsWhatIhave)
        }
    }
}
