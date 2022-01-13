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
        bind()
    }
    
    func bind(_ viewModel: WishListViewBindable = WishListCocktailViewModel()) {
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
            .emit(to: self.rx.showWishList)
            .disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wishListRecipe = FirebaseRecipe.shared.wishList.sorted { $0.name < $1.name}
        tableView.reloadData()
    }
    

}
//
//extension WishListCocktailListViewController: UITableViewDelegate, UITableViewDataSource {
//    
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return wishListRecipe.count
//    }
//    
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath) as? CocktailListCell else { return UITableViewCell()}
//        cell.configure(data: wishListRecipe[indexPath.row])
//        return cell
//    }
//    
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let cocktailData = wishListRecipe[indexPath.row]
//         let cocktailDetailViewController = CocktailDetailViewController()
//         cocktailDetailViewController.setData(data: cocktailData)
//         self.show(cocktailDetailViewController, sender: nil)
//    }
//    

//}

extension Reactive where Base: UIViewController {
    var showWishList: Binder<Cocktail> {
        return Binder(base) { base, cocktail  in
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: cocktail)
            base.show(cocktailDetailViewController, sender: nil)
        }
    }
    
}
