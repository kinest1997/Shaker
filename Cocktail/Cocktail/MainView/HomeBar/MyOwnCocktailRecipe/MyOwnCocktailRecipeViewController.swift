import UIKit
import SnapKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import RxSwift
import RxCocoa
import RxAppState

protocol MyOwnCocktailRecipeViewBindable {
    //view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var cellDeleted: PublishRelay<IndexPath> { get }
    var viewWillappear: PublishSubject<Void> { get }
    var addButtonTapped: PublishRelay<Void> { get }
    
    //viewModel -> view
    var updateCellData: Driver<[Cocktail]> { get }
    var showDetailView: Signal<Cocktail> { get }
    var showAddView: Signal<Void> { get }
}

class MyOwnCocktailRecipeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let addMyOwnCocktailRecipeViewController = AddMyOwnCocktailRecipeViewController()
    
    let detailViewController = CocktailDetailViewController()
    
    let mainTableView = UITableView()
    
    let rightAddButton = UIBarButtonItem(title: "Add".localized, style: .plain, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Recipes".localized
        view.addSubview(mainTableView)
        mainTableView.rowHeight = 100

        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainTableView.register(CocktailListCell.self, forCellReuseIdentifier: "CocktailListCell")
        navigationItem.rightBarButtonItem = rightAddButton
    }
    
    func bind(_ viewModel: MyOwnCocktailRecipeViewBindable) {
        
        self.rightAddButton.rx.tap
            .bind(to: viewModel.addButtonTapped)
            .disposed(by: disposeBag)
        
        self.mainTableView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .map { _ in Void()}
            .bind(to: viewModel.viewWillappear)
            .disposed(by: disposeBag)
        
        self.mainTableView.rx.itemDeleted
            .bind(to: viewModel.cellDeleted)
            .disposed(by: disposeBag)
        
        viewModel.updateCellData
            .drive(mainTableView.rx.items(cellIdentifier: "CocktailListCell", cellType: CocktailListCell.self)) { index, cocktail, cell in
                cell.configure(data: cocktail)
            }
            .disposed(by: disposeBag)
        
        viewModel.showDetailView
            .emit(to: self.rx.showDetailView)
            .disposed(by: disposeBag)
        
        viewModel.showAddView
            .emit(to: self.rx.showAddView)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: MyOwnCocktailRecipeViewController {
    var showDetailView: Binder<Cocktail> {
        return Binder(base) { base, cocktail in
            base.detailViewController.setData(data: cocktail)
            base.show(base.detailViewController, sender: nil)
        }
    }
    
    var showAddView: Binder<Void> {
        return Binder(base) { base, _ in
            base.addMyOwnCocktailRecipeViewController.choiceView.havePresetData = false
            base.addMyOwnCocktailRecipeViewController.myTipTextView.text = "Your own tip".localized
            base.addMyOwnCocktailRecipeViewController.textFieldArray.append(UITextField())
            base.show(base.addMyOwnCocktailRecipeViewController, sender: nil)
        }
    }
}
