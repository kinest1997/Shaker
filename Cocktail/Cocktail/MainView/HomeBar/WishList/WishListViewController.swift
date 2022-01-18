import UIKit
import SnapKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import RxCocoa
import RxSwift
import RxAppState

protocol WishListViewBindable {
    //view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var cellDeleted: PublishRelay<IndexPath> { get }
    var viewWillappear: PublishSubject<Void> { get }
    
    //viewModel -> view
    var updateCellData: Driver<[Cocktail]> { get }
    var showDetailView: Signal<Cocktail> { get }
}

class WishListCocktailListViewController: UIViewController {
    
    var wishListRecipe: [Cocktail] = []
    
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmark".localized
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(_ viewModel: WishListViewBindable) {
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillappear)
            .disposed(by: disposeBag)

        self.tableView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)

        self.tableView.rx.itemDeleted
            .bind(to: viewModel.cellDeleted)
            .disposed(by: disposeBag)
        
        viewModel.updateCellData
            .drive(self.tableView.rx.items(cellIdentifier: "key", cellType: CocktailListCell.self)) { index, cocktail, cell in
                cell.configure(data: cocktail)
            }
            .disposed(by: disposeBag)
        
        viewModel.showDetailView
            .emit(to: self.rx.showDetailView)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UIViewController {
    var showDetailView: Binder<Cocktail> {
        return Binder(base) { base, cocktail  in
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: cocktail)
            base.show(cocktailDetailViewController, sender: nil)
        }
    }
}
