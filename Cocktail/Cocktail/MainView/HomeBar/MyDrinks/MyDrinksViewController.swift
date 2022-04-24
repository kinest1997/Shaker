import UIKit
import SnapKit
import StoreKit
import RxSwift
import RxCocoa
import RxAppState

protocol MyDrinkViewBindable {
    // view -> viewModel
    var whatICanMakeButtonTapped: PublishRelay<Void> { get }
    var cellTapped: PublishRelay<IndexPath> { get }
    var viewWillAppear: PublishRelay<Void> { get }

    // viewModel -> view
    var showIngredientsView: Signal<Cocktail.Base> { get }
    var showRecipeListView: Signal<[Cocktail]> { get }
    var updateWhatICanMakeButton: Signal<String> { get }
    var updateCellData: Driver<[MyDrinkCell.CellData]> { get }
    var changeButtonColor: Signal<Bool> { get }

    var whatIhaveViewModel: WhatIHaveViewModel { get }
}

class MyDrinksViewController: UIViewController {

    let disposeBag = DisposeBag()

    let whatICanMakeViewController = CocktailListViewController()

    let whatIHaveViewController = WhatIHaveViewController()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let topNameLabel = UILabel()
    let topExplainLabel = UILabel()

    let whatICanMakeButton = MainButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MyDrinkCell.self, forCellWithReuseIdentifier: "MyDrinkCell")
        collectionView.isScrollEnabled = false
        attribute()
        layout()
    }

    func bind(_ viewModel: MyDrinkViewBindable) {

        self.whatIHaveViewController.bind(viewModel.whatIhaveViewModel)

        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        self.whatICanMakeButton.rx.tap
            .bind(to: viewModel.whatICanMakeButtonTapped)
            .disposed(by: disposeBag)

        self.collectionView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)

        viewModel.showIngredientsView
            .emit(to: self.rx.showIngredientsListView)
            .disposed(by: disposeBag)

        viewModel.showRecipeListView
            .emit(to: self.rx.showCocktailListView)
            .disposed(by: disposeBag)

        viewModel.updateWhatICanMakeButton
            .emit(to: self.whatICanMakeButton.rx.title())
            .disposed(by: disposeBag)

        self.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.updateCellData
            .drive(self.collectionView.rx.items(cellIdentifier: "MyDrinkCell", cellType: MyDrinkCell.self)) { _, cellData, cell in
                cell.configure(data: cellData)
            }
            .disposed(by: disposeBag)

        viewModel.changeButtonColor
            .emit(to: self.whatICanMakeButton.rx.changeButtonState)
            .disposed(by: disposeBag)
    }

    func layout() {
        topNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(30)
        }

        topExplainLabel.snp.makeConstraints {
            $0.top.equalTo(topNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topNameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(topExplainLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(collectionView.snp.width)
        }

        whatICanMakeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }

    func attribute() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(whatICanMakeButton)
        view.addSubview(topNameLabel)
        view.addSubview(topExplainLabel)

        topNameLabel.textColor = .black
        topExplainLabel.textColor = .mainGray
        topNameLabel.text = "My Drinks".localized
        topNameLabel.font = .nexonFont(ofSize: 30, weight: .bold)
        topExplainLabel.font = .nexonFont(ofSize: 15, weight: .semibold)
        topExplainLabel.text = "Find out the recipes that you can make with the ingredients you have!".localized
        topExplainLabel.numberOfLines = 0
    }
}

extension MyDrinksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
}

extension Reactive where Base: MyDrinksViewController {
    var showIngredientsListView: Binder<Cocktail.Base> {
        return Binder(base) { base, _ in

            base.show(base.whatIHaveViewController, sender: nil)

//            base.whatIHaveViewController.refreshList = cocktailBase
//            base.show(base.whatIHaveViewController, sender: nil)
        }
    }

    var showCocktailListView: Binder<[Cocktail]> {
        return Binder(base) { base, cocktail in
            base.whatICanMakeViewController.lastRecipe = cocktail
            base.show(base.whatICanMakeViewController, sender: nil)
        }
    }
}

extension Reactive where Base: MainButton {
    var changeButtonState: Binder<Bool> {
        return Binder(base) { base, bool in
            base.backgroundColor = bool ? .tappedOrange: .white
            base.isEnabled = bool
        }
    }
}
