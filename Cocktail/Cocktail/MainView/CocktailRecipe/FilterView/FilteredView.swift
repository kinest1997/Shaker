import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources


protocol FilterViewBindable {
    
    //view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var closeButtonTapped: PublishRelay<Void> { get }
    var saveButtonTapped: PublishRelay<Void> { get }
    var resetButton: PublishRelay<Void> { get }
    
//        viewModel ->view
    var conditionsOfCocktail: Observable<[FilteredView.FilterData]> { get }
    var updateCell: Signal<(index: IndexPath, checked: [[Bool]])> { get }
}

class FilteredView: UIView {
    
    let disposeBag = DisposeBag()
    
    let mainView = UIView()
    let tableView = UITableView()
    let resetButton = UIButton()
    let cancleButton = UIButton()
    let centerLabel = UILabel()
    let saveButton = UIButton()
    
    let filterSections = ["Alcohol".localized, "Base".localized, "DrinkType".localized, "Craft".localized, "Glass".localized, "Color".localized ]
    
    typealias FilterData = (condition: [CocktailCondition], section: [CocktailCondition])
    
    let componentsOfCocktail: [[String]] = [Cocktail.Alcohol.allCases.map {$0.rawValue}, Cocktail.Base.allCases.map {$0.rawValue}, Cocktail.DrinkType.allCases.map {$0.rawValue}, Cocktail.Craft.allCases.map {$0.rawValue}, Cocktail.Glass.allCases.map {$0.rawValue}, Cocktail.Color.allCases.map {$0.rawValue} ]
    
    
    func bind(_ viewModel: FilterViewBindable) {
        self.tableView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)
        
        self.cancleButton.rx.tap
            .bind(to: viewModel.closeButtonTapped)
            .disposed(by: disposeBag)
        
        self.saveButton.rx.tap
            .bind(to: viewModel.saveButtonTapped)
            .disposed(by: disposeBag)
        
        self.resetButton.rx.tap
            .bind(to: viewModel.resetButton)
            .disposed(by: disposeBag)
        
        let sections = [
            SectionOfFilterCell(header: filterSections[0], items: componentsOfCocktail[0]),
            SectionOfFilterCell(header: filterSections[1], items: componentsOfCocktail[1]),
            SectionOfFilterCell(header: filterSections[2], items: componentsOfCocktail[2]),
            SectionOfFilterCell(header: filterSections[3], items: componentsOfCocktail[3]),
            SectionOfFilterCell(header: filterSections[4], items: componentsOfCocktail[4]),
            SectionOfFilterCell(header: filterSections[5], items: componentsOfCocktail[5]),
        ]
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfFilterCell> { dataSource, tb, index, data in
            let cell = tb.dequeueReusableCell(withIdentifier: "filterCell", for: index) as! FilterViewCell
            cell.nameLabel.text = data
            return cell
        }
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        saveButton.setTitle("Save".localized, for: .normal)
        resetButton.setTitle("Reset".localized, for: .normal)
        self.backgroundColor = .gray.withAlphaComponent(0.5)

        self.addSubview(mainView)
        [tableView, saveButton, cancleButton, resetButton].forEach {
            mainView.addSubview($0)
        }
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true

        tableView.register(FilterViewCell.self, forCellReuseIdentifier: "filterCell")
        
        tableView.rowHeight = 45
        
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
        
        self.tableView.snp.makeConstraints {
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
            $0.bottom.equalTo(tableView.snp.top)
            $0.width.equalTo(cancleButton.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


