import UIKit
import SnapKit

class WhatIHaveViewController: UIViewController {
    
    var ingredientsWhatIhave: [String] = []
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var allIngredients: [Cocktail.Ingredients] = []
    
    var refreshList: Cocktail.Base = .vodka {
        didSet {
            allIngredients = refreshList.list
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] {
            ingredientsWhatIhave = data
        }
        navigationController?.isNavigationBarHidden = false
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.addSubview(mainCollectionView)
        mainCollectionView.register(WhatIHaveCollectionViewCell.self, forCellWithReuseIdentifier: "key")
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(ingredientsWhatIhave, forKey: "whatIHave")
    }
}

extension WhatIHaveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "key", for: indexPath) as? WhatIHaveCollectionViewCell else { return UICollectionViewCell() }
        
        if ingredientsWhatIhave.contains(allIngredients[indexPath.row].rawValue) {
            cell.nameLabel.text = allIngredients[indexPath.row].rawValue.localized
            cell.mainImageView.image = UIImage(named: allIngredients[indexPath.row].rawValue)
            cell.checkBoxImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            cell.nameLabel.text = allIngredients[indexPath.row].rawValue.localized
            cell.mainImageView.image = UIImage(named: allIngredients[indexPath.row].rawValue)
            cell.checkBoxImage.image = UIImage(systemName: "checkmark.circle")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.1
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WhatIHaveCollectionViewCell else { return }
        if ingredientsWhatIhave.contains(allIngredients[indexPath.row].rawValue) {
            guard let index = ingredientsWhatIhave.firstIndex(of: allIngredients[indexPath.row].rawValue) else { return }
            ingredientsWhatIhave.remove(at: index)
            cell.checkBoxImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            ingredientsWhatIhave.append(allIngredients[indexPath.row].rawValue)
            cell.checkBoxImage.image = UIImage(systemName: "checkmark.circle.fill")
        }
    }
}
