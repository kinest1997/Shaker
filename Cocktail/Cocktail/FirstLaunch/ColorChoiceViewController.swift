import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftUI

protocol ColorChoiceViewBindable {
    var alcoholChoiceViewModel: AlcoholChoiceViewModel { get }
    //ViewModel -> View
    var colorArray: Driver<[Cocktail.Color]> { get }
    var updateItem: Signal<(indexPath: IndexPath, selected: [Bool])> { get }
    var buttonLabelCount: Signal<Int> { get }
    var myFavor: Signal<Bool> { get }
    var saveMyFavor: Signal<[Cocktail.Color]> { get }
    var presentAlert: Driver<Void> { get }
    var presentAlcoholChoiceView: Driver<Void> { get }
    
    //View -> ViewModel
    var nextButtonTapped: PublishRelay<Void> { get }
    var itemSelected: PublishRelay<IndexPath> { get }
}

class ColorChoiceViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let alcoholChoiceViewController = AlcoholChoiceViewController()
    let questionLabel = UILabel()
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        attribute()
    }
    
    func bind(_ viewModel: ColorChoiceViewBindable) {
        alcoholChoiceViewController.bind(viewModel.alcoholChoiceViewModel)
        
        viewModel.colorArray
            .drive(mainCollectionView.rx.items(cellIdentifier: "colorCell", cellType: ColorCollectionViewCell.self)) { index, color, cell in
                cell.colorImageView.image = UIImage(named: color.rawValue)
            }
            .disposed(by: disposeBag)
        
        viewModel.updateItem
            .emit(to: self.rx.updateSelectedItem)
            .disposed(by: disposeBag)
        
        viewModel.buttonLabelCount
            .map { "\($0)개의 칵테일 발견" }
            .emit(to: nextButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.myFavor
            .emit(to: tabBarController!.tabBar.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.saveMyFavor
            .emit(onNext: { colors in
                UserDefaults.standard.set(colors.map { $0.rawValue }, forKey: "ColorFavor")
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .drive(onNext: {[weak self] _ in
                self?.present(UserFavor.shared.makeAlert(title: "하나이상 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlcoholChoiceView
            .drive(self.rx.presentAlcoholChoiceView)
            .disposed(by: disposeBag)
        
        mainCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mainCollectionView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        [questionLabel, mainCollectionView, nextButton]
            .forEach { view.addSubview($0) }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(210)
            $0.leading.equalToSuperview().inset(60)
            $0.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(50)
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(questionLabel)
            $0.height.equalTo(mainCollectionView.snp.width)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(mainCollectionView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(30)
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        questionLabel.text = "선호하는 색은 무엇인가요?"
        questionLabel.textAlignment = .center
        questionLabel.textColor = .systemGray2
        
        mainCollectionView.backgroundColor = .white
        
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.cornerRadius = 15
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.systemGray2, for: .normal)
    }
}

extension ColorChoiceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
}

extension Reactive where Base: ColorChoiceViewController {
    var updateSelectedItem: Binder<(indexPath: IndexPath, selected: [Bool])> {
        return Binder(base) { base, data in
            guard let selectedCell = base.mainCollectionView.cellForItem(at: data.indexPath) as? ColorCollectionViewCell else { return }
            selectedCell.isChecked = data.selected[data.indexPath.row]
        }
    }
    
    var presentAlcoholChoiceView: Binder<Void> {
        return Binder(base) { base, _ in
            base.show(base.alcoholChoiceViewController, sender: nil)
        }
    }
}
