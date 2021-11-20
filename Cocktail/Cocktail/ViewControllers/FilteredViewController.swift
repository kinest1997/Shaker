import UIKit
import SnapKit

class FilteredViewController: UIViewController {
    
    var nowOn: Bool = false
    
    var baseCondition: (([Cocktail.Base]) -> Void)?
    var alcoholCondition: (([Cocktail.Alcohol]) -> Void)?
    var drinkTypeCondition: (([Cocktail.DrinkType]) -> Void)?
    var craftConditon: (([Cocktail.Craft]) -> Void)?
    var glassCondition: (([Cocktail.Glass]) -> Void)?
    var colorCondition: (([Cocktail.Color]) -> Void)?
    
    var totalCondition: [Any] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemGray2
//        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.backgroundColor = .clear
        view.alpha = 0.5
        view.addSubview(mainView)
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
        self.view.addSubview(topStackView)
    }

}

extension FilteredViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.accessoryType = .checkmark
        
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
        
        switch indexPath.section {
        case 0:
            if totalCondition.contains(where: alcoholSection[indexPath.row] as Any) {
                
            }
            totalCondition.append(alcoholSection[indexPath.row])
        case 1:
            totalCondition.append(baseSection[indexPath.row])
        case 2:
            totalCondition.append(drinkTypeSection[indexPath.row])
        case 3:
            totalCondition.append(craftSection[indexPath.row])
        case 4:
            totalCondition.append(glassSection[indexPath.row])
        case 5:
            totalCondition.append(colorSection[indexPath.row])
        default:
            break
        }
        
    }
}
// 다른 화면에서도 재활용?
