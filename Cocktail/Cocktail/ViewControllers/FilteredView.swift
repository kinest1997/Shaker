import UIKit
import SnapKit

class FilteredView: UIView {
    
    var nowFiltering: Bool = false
    
    var baseCondition: [Cocktail.Base] = []
    var alcoholCondition: [Cocktail.Alcohol] = []
    var drinkTypeCondition: [Cocktail.DrinkType] = []
    var craftConditon: [Cocktail.Craft] = []
    var glassCondition: [Cocktail.Glass] = []
    var colorCondition: [Cocktail.Color] = []
    
    let mainView = UIView()
    
    let topStackView = UIStackView()
    let leftCancelButton = UIButton()
    let rightSaveButton = UIButton()
    let centerLabel = UILabel()
        
    let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
    
    var cellIsChecked: [[Bool]] = []
    
    let alcoholSection = Cocktail.Alcohol.allCases
    let baseSection = Cocktail.Base.allCases
    let drinkTypeSection = Cocktail.DrinkType.allCases
    let craftSection = Cocktail.Craft.allCases
    let glassSection = Cocktail.Glass.allCases
    let colorSection = Cocktail.Color.allCases
    
    let mainTableView = UITableView()
    
    func sortingRecipes(origin: [Cocktail], base: [Cocktail.Base], alcohol: [Cocktail.Alcohol], drinktype: [Cocktail.DrinkType], craft: [Cocktail.Craft], glass: [Cocktail.Glass], color: [Cocktail.Color]) -> [Cocktail] {
        var baseSorted = [Cocktail]()
        var alcoholSorted = [Cocktail]()
        var drinktypeSorted = [Cocktail]()
        var craftSorted = [Cocktail]()
        var glassSorted = [Cocktail]()
        var colorSorted = [Cocktail]()
        
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellIsChecked = (0...5).map {
            switch $0 {
            case 0:
                return alcoholSection.map { _ in false }
            case 1:
                return baseSection.map { _ in false }
            case 2:
                return drinkTypeSection.map { _ in false }
            case 3:
                return craftSection.map { _ in false }
            case 4:
                return glassSection.map { _ in false }
            case 5:
                return colorSection.map { _ in false }
            default:
                return []
            }
        }
        self.addSubview(mainView)
        self.addSubview(topStackView)
        mainView.addSubview(mainTableView)
        mainView.addSubview(topStackView)
        topStackView.addArrangedSubview(leftCancelButton)
        topStackView.addArrangedSubview(centerLabel)
        topStackView.addArrangedSubview(rightSaveButton)
        topStackView.backgroundColor = .red
        mainView.backgroundColor = .blue
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(FilterViewCell.self, forCellReuseIdentifier: "filterCell")
        self.mainTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview()
        }
        self.mainView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(600)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilteredView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filterSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return alcoholSection.count
        case 1:
            return baseSection.count
        case 2:
            return drinkTypeSection.count
        case 3:
            return craftSection.count
        case 4:
            return glassSection.count
        case 5:
            return colorSection.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterViewCell else { return UITableViewCell()}
        
        cell.isChecked = cellIsChecked[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            cell.nameLabel.text = alcoholSection[indexPath.row].rawValue
        case 1:
            cell.nameLabel.text =
            baseSection[indexPath.row].rawValue
        case 2:
            cell.nameLabel.text =
            drinkTypeSection[indexPath.row].rawValue
        case 3:
            cell.nameLabel.text =
            craftSection[indexPath.row].rawValue
        case 4:
            cell.nameLabel.text =
            glassSection[indexPath.row].rawValue
        case 5:
            cell.nameLabel.text =
            colorSection[indexPath.row].rawValue
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterViewCell else { return }
        
        switch indexPath.section {
        case 0:
            if cellIsChecked[0][indexPath.row] == true {
                cellIsChecked[0][indexPath.row] = false
                cell.isChecked = cellIsChecked[0][indexPath.row]
                guard let number = alcoholCondition.firstIndex(of: alcoholSection[indexPath.row]) else { return }
                alcoholCondition.remove(at: number)
            } else {
                cellIsChecked[0][indexPath.row] = true
                print(cellIsChecked)
                alcoholCondition.append(alcoholSection[indexPath.row])
                cell.isChecked = cellIsChecked[0][indexPath.row]
            }
        case 1:
            if cellIsChecked[1][indexPath.row] == true {
                cellIsChecked[1][indexPath.row] = false
                cell.isChecked = cellIsChecked[1][indexPath.row]
                guard let number = baseCondition.firstIndex(of: baseSection[indexPath.row]) else { return }
                baseCondition.remove(at: number)
            } else {
                cellIsChecked[1][indexPath.row] = true
                cell.isChecked = cellIsChecked[1][indexPath.row]
                baseCondition.append(baseSection[indexPath.row])
            }
        case 2:
            if cellIsChecked[2][indexPath.row] == true {
                cellIsChecked[2][indexPath.row] = false
                cell.isChecked = cellIsChecked[2][indexPath.row]
                guard let number = drinkTypeCondition.firstIndex(of: drinkTypeSection[indexPath.row]) else { return }
                drinkTypeCondition.remove(at: number)
            } else {
                cellIsChecked[2][indexPath.row] = true
                cell.isChecked = cellIsChecked[2][indexPath.row]
                drinkTypeCondition.append(drinkTypeSection[indexPath.row])
            }
        case 3:
            if cellIsChecked[3][indexPath.row] == true {
                cellIsChecked[3][indexPath.row] = false
                cell.isChecked = cellIsChecked[3][indexPath.row]
                guard let number = craftConditon.firstIndex(of: craftSection[indexPath.row]) else { return }
                craftConditon.remove(at: number)
            } else {
                cellIsChecked[3][indexPath.row] = true
                cell.isChecked = cellIsChecked[3][indexPath.row]
                craftConditon.append(craftSection[indexPath.row])
            }
        case 4:
            if cellIsChecked[4][indexPath.row] == true {
                cellIsChecked[4][indexPath.row] = false
                cell.isChecked = cellIsChecked[4][indexPath.row]
                guard let number = glassCondition.firstIndex(of: glassSection[indexPath.row]) else { return }
                glassCondition.remove(at: number)
            } else {
                cellIsChecked[4][indexPath.row] = true
                glassCondition.append(glassSection[indexPath.row])
                cell.isChecked = cellIsChecked[4][indexPath.row]
            }
        case 5:
            if cellIsChecked[5][indexPath.row] == true {
                cellIsChecked[5][indexPath.row] = false
                cell.isChecked = cellIsChecked[5][indexPath.row]
                guard let number = colorCondition.firstIndex(of: colorSection[indexPath.row]) else { return }
                colorCondition.remove(at: number)
            } else {
                cellIsChecked[5][indexPath.row] = true
                colorCondition.append(colorSection[indexPath.row])
                cell.isChecked = cellIsChecked[5][indexPath.row]
            }
        default:
            break
        }
    }
}
