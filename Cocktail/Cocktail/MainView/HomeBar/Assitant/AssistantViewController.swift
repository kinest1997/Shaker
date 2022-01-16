import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift
import RxAppState
import SwiftUI

protocol AssistantViewBindable {
    //view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var viewWillappear: PublishSubject<Void> { get }
    
    //viewModel -> view
    var showPage: Signal<AssistantModel.Views> { get }
    var cellData: Driver<[AssistantCell.CellData]> { get }
    
    var wishListViewModel: WishListCocktailViewModel { get }
    var myOwnRecipeViewModel: MyOwnCocktailViewModel { get }
}

class AssistantViewController: UIViewController {
    
    let wishListViewController = WishListCocktailListViewController()
  
    let homeBarViewController = MyDrinksViewController()

    let myOwnCocktailRecipeViewController = MyOwnCocktailRecipeViewController()
    
    let disposeBag = DisposeBag()
    
    let mainTableView = UITableView()
    let topTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(AssistantCell.self, forCellReuseIdentifier: "AssistantCell")
        mainTableView.isScrollEnabled = false
        attribute()
        layout()
    }
    
    func bind(viewmodel: AssistantViewBindable) {
        
        self.wishListViewController.bind(viewmodel.wishListViewModel)
        self.myOwnCocktailRecipeViewController.bind(viewmodel.myOwnRecipeViewModel)
        
        self.mainTableView.rx.itemSelected
            .bind(to: viewmodel.cellTapped)
            .disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewmodel.viewWillappear)
            .disposed(by: disposeBag)
        
        viewmodel.showPage
            .emit(to: self.rx.showPages)
            .disposed(by: disposeBag)
        
        viewmodel.cellData
            .drive(self.mainTableView.rx.items(cellIdentifier: "AssistantCell", cellType: AssistantCell.self)) { index, cellData, cell in
                cell.titleLabel.text = cellData.title.localized
                cell.explainLabel.text = cellData.explain.localized
                cell.mainImageView.image = UIImage(named: cellData.title)?.resize()
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = 100
        mainTableView.selectionFollowsFocus = false
        topTitleLabel.text = "마이페이지".localized
        topTitleLabel.font = .nexonFont(ofSize: 24, weight: .bold)
        topTitleLabel.textAlignment = .center
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(mainTableView)
        view.addSubview(topTitleLabel)
        topTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(100)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension Reactive where Base: AssistantViewController {
    var showPages: Binder<AssistantModel.Views> {
        return Binder(base) { base, view in
            switch view {
            case .wishList:
                if Auth.auth().currentUser?.uid == nil {
                    base.pleaseLoginAlert()
                } else {
                    base.show(base.wishListViewController, sender: nil)
                }
            case .myDrink:
                base.show(base.homeBarViewController, sender: nil)
            case .myRecipe:
                if Auth.auth().currentUser?.uid == nil {
                    base.pleaseLoginAlert()
                } else {
                    base.show(base.myOwnCocktailRecipeViewController, sender: nil)
                }
            }
        }
    }
}
