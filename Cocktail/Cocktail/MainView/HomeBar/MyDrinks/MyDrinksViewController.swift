import UIKit
import SnapKit

class MyDrinksViewController: UIViewController {
    
    var myDrink: Set<String> = []
    
    var originRecipe: [Cocktail] = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let topNameLabel = UILabel()
    let topExplainLabel = UILabel()
    
    let whatICanMakeButton = MainButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originRecipe = FirebaseRecipe.shared.recipe
        collectionView.register(MyDrinkCell.self, forCellWithReuseIdentifier: "MyDrinkCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.object(forKey: "whatIHave") as? [String] {
            myDrink = Set(data)
        }
        collectionView.reloadData()
        updateWhatICanMakeButton(data: myDrink, button: whatICanMakeButton)
    }
    
    func layout() {
        topNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        topExplainLabel.snp.makeConstraints {
            $0.top.equalTo(topNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topNameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topExplainLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(collectionView.snp.width)
        }
        
        whatICanMakeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(whatICanMakeButton)
        view.addSubview(topNameLabel)
        view.addSubview(topExplainLabel)
        
        topNameLabel.textColor = .black
        topExplainLabel.textColor = .mainGray
        topNameLabel.text = "My Drinks".localized
        topNameLabel.font = .nexonFont(ofSize: 30, weight: .bold)
        topExplainLabel.font = .nexonFont(ofSize: 15, weight: .semibold)
        topExplainLabel.text = "Find out the recipes that you can make with the ingredients you have!".localized
        topExplainLabel.numberOfLines = 0
        
        whatICanMakeButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let whatICanMakeViewController = CocktailListViewController()
            whatICanMakeViewController.lastRecipe = self.checkWhatICanMake(myIngredients: self.myDrink)
            self.show(whatICanMakeViewController, sender: nil)
        }), for: .touchUpInside)
    }
    
    func updateIngredientsBadge(base: Cocktail.Base) -> Int {
        let origin = Set(base.list.map {
            $0.rawValue })
        let subtracted = origin.subtracting(myDrink)
        let originCount = origin.count - subtracted.count
        return originCount
    }
    
    func updateWhatICanMakeButton(data: Set<String>, button: UIButton) {
        let sortedData = checkWhatICanMake(myIngredients: data)
        if sortedData.count != 0 {
             button.backgroundColor = .tappedOrange
            button.setTitle("\(sortedData.count)" + " " + "EA".localized + " " + "making".localized, for: .normal)
        } else {
            button.backgroundColor = .white
            button.setTitle("Choose more ingredients!".localized, for: .normal)
        }
    }
    
    func checkWhatICanMake(myIngredients: Set<String>) -> [Cocktail] {
        var lastRecipe = [Cocktail]()
        originRecipe.forEach {
            let someSet = Set($0.ingredients.map({ baby in
                baby.rawValue
            }))
            if someSet.subtracting(myIngredients).isEmpty {
                lastRecipe.append($0)
            }
        }
        return lastRecipe
    }
}

extension MyDrinksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let whatIHaveViewController = WhatIHaveViewController()
        whatIHaveViewController.refreshList = Cocktail.Base.allCases[indexPath.row]
        self.show(whatIHaveViewController, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Cocktail.Base.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyDrinkCell", for: indexPath) as? MyDrinkCell else { return UICollectionViewCell() }
        cell.nameTextLabel.text = Cocktail.Base.allCases[indexPath.row].rawValue.localized
        cell.mainImage.image = UIImage(named: Cocktail.Base.allCases[indexPath.row].rawValue)
        cell.badgecount.text = String(updateIngredientsBadge(base: Cocktail.Base.allCases[indexPath.row]))
        
        return cell
    }
}
