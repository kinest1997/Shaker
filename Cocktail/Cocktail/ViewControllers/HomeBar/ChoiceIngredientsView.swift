import UIKit
import SnapKit

class ChoiceIngredientsView: UIView {
    
    let mainTableview = UITableView()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let resetButton = UIButton()
    
    var cellIsChecked: [[Bool]] = []
    
    var myIngredients: [Cocktail.Ingredients] = []
    
    let ingredientsData: [[Cocktail.Ingredients]] = [Cocktail.Base.rum.list, Cocktail.Base.vodka.list, Cocktail.Base.tequila.list, Cocktail.Base.brandy.list, Cocktail.Base.whiskey.list, Cocktail.Base.gin.list, Cocktail.Base.liqueur.list, Cocktail.Base.assets.list, Cocktail.Base.beverage.list]
    //이것이 누나가말한 데이터 주는법이구만
    
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
        self.addSubview(mainTableview)
        self.addSubview(saveButton)
        self.addSubview(cancelButton)
        self.addSubview(resetButton)
        mainTableview.register(FilterViewCell.self, forCellReuseIdentifier: "Ingredients")
        mainTableview.delegate = self
        mainTableview.dataSource = self
        mainTableview.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cancelButton.snp.bottom)
            $0.bottom.equalTo(saveButton.snp.top)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        cancelButton.setTitle("Cancel".localized, for: .normal)
        cancelButton.backgroundColor = .cyan
        saveButton.setTitle("Save".localized, for: .normal)
        saveButton.backgroundColor = .darkGray
        resetButton.setTitle("Reset".localized, for: .normal)
        resetButton.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChoiceIngredientsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredientsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Cocktail.Base.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsData[section].count
    }
    
//    if myIngredients == [] {
//        ingredientsData
//    }
    
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
            guard let number = myIngredients.firstIndex(of: ingredientsData[indexPath.section][indexPath.row]) else { return }
            myIngredients.remove(at: number)
            print(cellIsChecked)
        } else {
            cellIsChecked[indexPath.section][indexPath.row] = true
            cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
            myIngredients.append(ingredientsData[indexPath.section][indexPath.row])
        }
    }
}
