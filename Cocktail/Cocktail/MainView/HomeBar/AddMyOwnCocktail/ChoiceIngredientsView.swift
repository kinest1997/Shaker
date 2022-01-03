import UIKit
import SnapKit

class ChoiceIngredientsView: UIView {
    
    let mainView = UIView()
    
    let mainTableView = UITableView()
    let saveButton = UIButton()
    let cancleButton = UIButton()
    let resetButton = UIButton()
    
    var cellIsChecked: [[Bool]] = []
    
    var myIngredients: [Cocktail.Ingredients]?
    
    ///새로 만드는 레시피인지, 기존의 레시피를 수정하여 만드는것인지에 따른 차이
    var havePresetData: Bool? {
        didSet {
            if havePresetData == true {
                if myIngredients != nil {
                    let preCheckedArray = findPlace()
                    preCheckedArray.forEach {
                        cellIsChecked[$0.0][$0.1] = true
                    }
                }
            } else {
                myIngredients = []
            }
        }
    }
    
    let ingredientsData: [[Cocktail.Ingredients]] = [Cocktail.Base.rum.list, Cocktail.Base.vodka.list, Cocktail.Base.tequila.list, Cocktail.Base.brandy.list, Cocktail.Base.whiskey.list, Cocktail.Base.gin.list, Cocktail.Base.liqueur.list, Cocktail.Base.assets.list, Cocktail.Base.beverage.list]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellIsChecked = (0...8).map {
            switch $0 {
            case 0:
                return Cocktail.Base.rum.list.map { _ in false }
            case 1:
                return Cocktail.Base.vodka.list.map { _ in false }
            case 2:
                return Cocktail.Base.tequila.list.map { _ in false }
            case 3:
                return Cocktail.Base.brandy.list.map { _ in false }
            case 4:
                return Cocktail.Base.whiskey.list.map { _ in false }
            case 5:
                return Cocktail.Base.gin.list.map { _ in false }
            case 6:
                return Cocktail.Base.liqueur.list.map { _ in false }
            case 7:
                return Cocktail.Base.assets.list.map { _ in false }
            case 8:
                return Cocktail.Base.beverage.list.map { _ in false }
            default:
                return []
            }
        }
        
        self.addSubview(mainView)
        [mainTableView, saveButton, cancleButton, resetButton].forEach {
            mainView.addSubview($0)
        }
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        mainTableView.register(FilterViewCell.self, forCellReuseIdentifier: "Ingredients")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.mainTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview()
        }
        self.mainView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        self.saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        cancleButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(mainTableView.snp.top)
            $0.width.equalTo(cancleButton.snp.height)
        }
        
        self.resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        mainView.backgroundColor = .white
        mainView.cornerRadius = 10
        mainView.clipsToBounds = true
        cancleButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancleButton.tintColor = .black
        
        [resetButton, saveButton].forEach {
            $0.titleLabel!.font = .nexonFont(ofSize: 18, weight: .semibold)
            $0.setTitleColor(.mainGray, for: .normal)
        }
        
        saveButton.backgroundColor = .tappedOrange
        saveButton.cornerRadius = 15
        saveButton.clipsToBounds = true
        
        saveButton.setTitle("Save".localized, for: .normal)
        
        resetButton.setTitle("Reset".localized, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func findPlace() -> [(Int, Int)] {
        guard let myIngredients = myIngredients else { return [] }
        let coordinate = myIngredients.map { ingredients -> (Int, Int) in
            var section = 0
            var row = 0
            ingredientsData.forEach { array in
                for i in array {
                    if i == ingredients {
                        guard let firstRow = array.firstIndex(of: i), let firstSection = ingredientsData.firstIndex(of: array) else { return }
                        row = firstRow
                        section = firstSection
                    }
                }
            }
            return (section, row)
        }
        return coordinate
    }
}

extension ChoiceIngredientsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredientsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Cocktail.Base.allCases[section].rawValue.localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredients") as? FilterViewCell else { return UITableViewCell()}
        
        cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
        cell.nameLabel.text = ingredientsData[indexPath.section][indexPath.row].rawValue.localized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterViewCell else { return }
        
        if cellIsChecked[indexPath.section][indexPath.row] == true {
            cellIsChecked[indexPath.section][indexPath.row] = false
            cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
            guard let number = myIngredients?.firstIndex(of: ingredientsData[indexPath.section][indexPath.row]) else { return }
            myIngredients?.remove(at: number)
        } else {
            cellIsChecked[indexPath.section][indexPath.row] = true
            cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
            myIngredients?.append(ingredientsData[indexPath.section][indexPath.row])
        }
    }
}
