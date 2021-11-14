import UIKit
import SnapKit

class WhatIHaveViewController: UIViewController {
    
    var ingredientsWhatIhave: [String] = []
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var allIngredients: [Cocktail.Ingredients] = []
    
    
    var whatIPicked: String? {
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


//렘으로 바꾸기, 뒤의 뷰로 돌아갈때 뷰디드로드 안에다가 whatICanMake 함수로 현재 가진 재료들로 만들수있는 칵테일의 종류를 갱신하고, 가진 술의 갯수를 갱신한다.

//enum으로만들었을때, 만약 이넘의 base 라는 var 를 만들어서 접근할때 switch로 재료에 따라 base 를 뱉는게 다르도록,
// 저쪽에서 뷰디드로드에서 화면의 뱃지를 새로고침할떄 내가 가진 재료의 배열을 받아오는데. 그배열로 만들수있는 술의 갯수는 차집함 개념으로 만들어주고.내가 가진 술의 목록은 enum의 var를 이용해서 필터링을 해서 .count로 갯수를 적어준다. 만약 내가 가진 재료중 switch ~~ .base == gin 일경우 이름이 ~인 버튼의 뱃지는 .count 가 되는것으로. 

