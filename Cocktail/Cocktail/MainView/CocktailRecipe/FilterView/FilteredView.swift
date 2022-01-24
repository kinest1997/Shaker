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
    var resetimages: Signal<[[Bool]]> { get }
    
    //view -> superView
    var dismissFilterView: Signal<Void> { get }
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
        
        viewModel.resetimages
            .emit(to: self.rx.resetCellData)
            .disposed(by: disposeBag)
        
        viewModel.updateCell
            .emit(to: self.rx.updateCellData)
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
        tableView.register(FilterViewCell.self, forCellReuseIdentifier: "filterCell")
        layout()
        attribute()
    }
    
    func layout() {
        
        addSubview(mainView)
        [tableView, saveButton, cancleButton, resetButton].forEach {
            mainView.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        cancleButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(tableView.snp.top)
            $0.width.equalTo(cancleButton.snp.height)
        }
    }
    
    func attribute() {
        tableView.rowHeight = 45
        resetButton.setTitle("Reset".localized, for: .normal)
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        
        [resetButton, saveButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel!.font = .nexonFont(ofSize: 18, weight: .semibold)
            $0.setTitleColor(.mainGray, for: .normal)
        }
        
        mainView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        cancleButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
        }
        
        saveButton.do {
            $0.setTitle("Save".localized, for: .normal)
            $0.backgroundColor = .tappedOrange
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
            $0.setTitle("Save".localized, for: .normal)
        }
        
        resetButton.setTitle("Reset".localized, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: FilteredView {
    var updateCellData: Binder<(index: IndexPath, checked: [[Bool]])> {
        return Binder(base) { base, data in
            let cell = base.tableView.cellForRow(at: data.index) as! FilterViewCell
            cell.isChecked = data.checked[data.index.section][data.index.row]
        }
    }
    
    var resetCellData: Binder<[[Bool]]> {
        return Binder(base) { base, data in
            for i in data.enumerated() {
                for j in i.element.enumerated() {
                    
                    let cell = base.tableView.cellForRow(at: IndexPath(row: j.offset, section: i.offset)) as! FilterViewCell
                    cell.isChecked = false
                }
            }
            
        }
    }
}
