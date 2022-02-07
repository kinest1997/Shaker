import UIKit
import SnapKit
import RxRelay
import RxSwift
import RxCocoa
import RxAppState

protocol WhatIHaveViewBindable {
    // view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var viewWillAppear: PublishSubject<Void> { get }

    // superViewModel -> viewModel
    var listData: PublishSubject<[String]> { get }

    // viewModel -> view
    var ingredientsArray: Driver<[WhatIHaveCollectionViewCell.CellData]> { get }
}

class WhatIHaveViewController: UIViewController {

    let disposeBag = DisposeBag()

    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.addSubview(mainCollectionView)
        mainCollectionView.register(WhatIHaveCollectionViewCell.self, forCellWithReuseIdentifier: "WhatIHaveCollectionViewCell")
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ viewModel: WhatIHaveViewBindable) {
        self.mainCollectionView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)

        self.rx.viewWillAppear
            .map { _ in Void()}
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        self.mainCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.ingredientsArray
            .drive(self.mainCollectionView.rx.items(cellIdentifier: "WhatIHaveCollectionViewCell", cellType: WhatIHaveCollectionViewCell.self)) { _, cellData, cell in
                cell.nameLabel.text = cellData.title.localized
                cell.mainImageView.image = UIImage(named: cellData.title)
                cell.setImage(bool: cellData.checked)
            }
            .disposed(by: disposeBag)
    }
}

extension WhatIHaveViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.1
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
}
