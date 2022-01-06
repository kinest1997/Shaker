import UIKit
import SnapKit

class FilteredView: UIView {
    
    var nowFiltering: Bool = false
    
    let mainView = UIView()
    let mainTableView = UITableView()
    let resetButton = UIButton()
    let cancleButton = UIButton()
    let centerLabel = UILabel()
    let saveButton = UIButton()
    
    let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
    
    var cellIsChecked: [[Bool]] = []
    
    typealias FilterData = (condition: [CocktailCondition], section: [CocktailCondition])
    var conditionsOfCocktail = [FilterData]()
    
    let componentsOfCocktail: [[String]] = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        saveButton.setTitle("Save".localized, for: .normal)
        resetButton.setTitle("Reset".localized, for: .normal)
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        self.conditionsOfCocktail = [
            (condition: [Cocktail.Alcohol](), section: Cocktail.Alcohol.allCases),
            (condition: [Cocktail.Base](), section: Cocktail.Base.allCases),
            (condition: [Cocktail.DrinkType](), section: Cocktail.DrinkType.allCases),
            (condition: [Cocktail.Craft](), section: Cocktail.Craft.allCases),
            (condition: [Cocktail.Glass](), section: Cocktail.Glass.allCases),
            (condition: [Cocktail.Color](), section: Cocktail.Color.allCases)
        ]
        
        self.cellIsChecked = componentsOfCocktail.map {
            $0.map { _ in false }
        }
        self.addSubview(mainView)
        [mainTableView, saveButton, cancleButton, resetButton].forEach {
            mainView.addSubview($0)
        }
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(FilterViewCell.self, forCellReuseIdentifier: "filterCell")
        
        cancleButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancleButton.tintColor = .black
        
        [resetButton, saveButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel!.font = .nexonFont(ofSize: 18, weight: .semibold)
            $0.setTitleColor(.mainGray, for: .normal)
        }
        
        saveButton.backgroundColor = .tappedOrange
        saveButton.layer.cornerRadius = 15
        saveButton.clipsToBounds = true
        
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
        
        self.resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        saveButton.setTitle("Save".localized, for: .normal)
        resetButton.setTitle("Reset".localized, for: .normal)
        
        cancleButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(mainTableView.snp.top)
            $0.width.equalTo(cancleButton.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //걸러내는 함수
    func sortingRecipes(origin: [Cocktail], alcohol: [Cocktail.Alcohol], base: [Cocktail.Base], drinktype: [Cocktail.DrinkType], craft: [Cocktail.Craft], glass: [Cocktail.Glass], color: [Cocktail.Color]) -> [Cocktail] {
        var alcoholSorted = [Cocktail]()
        var baseSorted = [Cocktail]()
        var drinktypeSorted = [Cocktail]()
        var craftSorted = [Cocktail]()
        var glassSorted = [Cocktail]()
        var colorSorted = [Cocktail]()
        
        if alcohol.isEmpty {
            alcoholSorted = origin
        } else {
            for i in alcohol {
                let alcoholSortedRecipe = origin.filter {
                    $0.alcohol == i
                }
                alcoholSorted.append(contentsOf: alcoholSortedRecipe)
            }
        }
        
        if base.isEmpty {
            baseSorted = origin
        } else {
            for i in base {
                let baseSortedRecipe = origin.filter {
                    $0.base == i
                }
                baseSorted.append(contentsOf: baseSortedRecipe)
            }
        }
        
        if drinktype.isEmpty {
            drinktypeSorted = origin
        } else {
            for i in drinktype {
                let sorted = origin.filter {
                    $0.drinkType == i
                }
                drinktypeSorted.append(contentsOf: sorted)
            }
        }
        
        if craft.isEmpty {
            craftSorted = origin
        } else {
            for i in craft {
                let sorted = origin.filter {
                    $0.craft == i
                }
                craftSorted.append(contentsOf: sorted)
            }
        }
        
        if glass.isEmpty {
            glassSorted = origin
        } else {
            for i in glass {
                let sorted = origin.filter {
                    $0.glass == i
                }
                glassSorted.append(contentsOf: sorted)
            }
        }
        
        if color.isEmpty {
            colorSorted = origin
        } else {
            for i in color {
                let sorted = origin.filter {
                    $0.color == i
                }
                colorSorted.append(contentsOf: sorted)
            }
        }
        let final = Set(baseSorted).intersection(Set(alcoholSorted))
            .intersection(Set(drinktypeSorted)).intersection(Set(craftSorted)).intersection(Set(glassSorted)).intersection(Set(colorSorted))
        return Array(final)
    }
}

extension FilteredView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filterSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section].localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        componentsOfCocktail[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterViewCell else { return UITableViewCell()}
        
        cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
        cell.nameLabel.text = componentsOfCocktail[indexPath.section][indexPath.row].localized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterViewCell else { return }
        
        if cellIsChecked[indexPath.section][indexPath.row] == true {
            cellIsChecked[indexPath.section][indexPath.row] = false
            cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
            let conditions = conditionsOfCocktail[indexPath.section].condition
            let section = conditionsOfCocktail[indexPath.section].section
            guard let number = conditions.firstIndex(where: { $0.rawValue == section[indexPath.row].rawValue}) else { return }
            conditionsOfCocktail[indexPath.section].condition.remove(at: number)
        } else {
            cellIsChecked[indexPath.section][indexPath.row] = true
            let section = conditionsOfCocktail[indexPath.section].section
            conditionsOfCocktail[indexPath.section].condition.append(section[indexPath.row])
            cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
        }
    }
}
