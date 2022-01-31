import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources
import RxAppState

protocol FilterViewBindable {
    
    //view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var closeButtonTapped: PublishRelay<Void> { get }
    var saveButtonTapped: PublishRelay<Void> { get }
    var resetButton: PublishRelay<Void> { get }
    
    //viewModel ->view
    var cellData: Driver<[SectionOfFilterCell]> { get }
    
    //superViewModel -> ViewModel
    var viewWillAppear: PublishRelay<Void> { get }
    
    //viewModel -> superView
    var conditionsOfCocktail: Observable<[FilteredView.FilterData]> { get }
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
    
    typealias FilterData = (condition: [CocktailCondition], section: [CocktailCondition])
    
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
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfFilterCell> { dataSource, tb, index, data in
            let cell = tb.dequeueReusableCell(withIdentifier: "filterCell", for: index) as! FilterViewCell
            cell.nameLabel.text = data.name.localized
            cell.isChecked = data.selected
            cell.selectionStyle = .none
            return cell
        }
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        viewModel.cellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        tableView.register(FilterViewCell.self, forCellReuseIdentifier: "filterCell")
        
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
