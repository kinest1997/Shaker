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
    //    let filterSections: [Any] = [Cocktail.Alcohol.allCases, Cocktail.Base.allCases, Cocktail.DrinkType.allCases, Cocktail.Craft.allCases, Cocktail.Glass.allCases, Cocktail.Color.allCases]
    let alcoholSection = Cocktail.Alcohol.allCases
    let baseSection = Cocktail.Base.allCases
    let drinkTypeSection = Cocktail.DrinkType.allCases
    let craftSection = Cocktail.Craft.allCases
    let glassSection = Cocktail.Glass.allCases
    let colorSection = Cocktail.Color.allCases
    
    let mainTableView = UITableView()
    var isOn: Bool = false
    
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
    
    //        view.backgroundColor = .systemGray2
    //        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = alcoholCondition.firstIndex(of: alcoholSection[indexPath.row]) else { return }
                alcoholCondition.remove(at: number)
            } else {
                alcoholCondition.append(alcoholSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
        case 1:
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = baseCondition.firstIndex(of: baseSection[indexPath.row]) else { return }
                baseCondition.remove(at: number)
            } else {
                baseCondition.append(baseSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
        case 2:
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = drinkTypeCondition.firstIndex(of: drinkTypeSection[indexPath.row]) else { return }
                drinkTypeCondition.remove(at: number)
            } else {
                drinkTypeCondition.append(drinkTypeSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
        case 3:
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = craftConditon.firstIndex(of: craftSection[indexPath.row]) else { return }
                craftConditon.remove(at: number)
            } else {
                craftConditon.append(craftSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
        case 4:
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = glassCondition.firstIndex(of: glassSection[indexPath.row]) else { return }
                glassCondition.remove(at: number)
            } else {
                glassCondition.append(glassSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
        case 5:
            if cell.isChecked == true {
                cell.isChecked = false
                cell.imageApply()
                guard let number = colorCondition.firstIndex(of: colorSection[indexPath.row]) else { return }
                colorCondition.remove(at: number)
            } else {
                colorCondition.append(colorSection[indexPath.row])
                cell.isChecked = true
                cell.imageApply()
            }
            //이 말도안되는 중복코드를 간단하게 적을 함수를 만들수있을까.. 제네릭을 이때 사용하는건가? 일단 보류
        default:
            break
        }
    }
}
// 다른 화면에서도 재활용?
