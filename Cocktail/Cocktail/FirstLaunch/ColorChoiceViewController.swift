import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftUI

protocol ColorChoiceViewBindable {
    var colorArray: Driver<[Cocktail.Color]> { get }
    var updateItem: Signal<IndexPath> { get }
    var buttonLabelCount: Signal<Int> { get }
    var myFavor: Signal<Void> { get }
    var saveMyFavor: Signal<Void> { get }
    var presentAlert: Driver<Void> { get }
    var presentAlcoholChoiceView: Driver<AlcoholChoiceViewModel> { get }
    
    var nextButtonTapped: PublishRelay<Void> { get }
    var itemSelected: PublishRelay<IndexPath> { get }
}

class ColorChoiceViewController: UIViewController {
    let disposeBag = DisposeBag()
    let questionLabel = UILabel()
    
    var selectedColor = [Cocktail.Color]()
    var isCheckedArray = Array(repeating: false, count: Cocktail.Color.allCases.count)
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        attribute()
    }
    
    func bind(_ viewModel: ColorChoiceViewBindable) {
        viewModel.colorArray
            .drive(mainCollectionView.rx.items(cellIdentifier: "colorCell", cellType: ColorCollectionViewCell.self)) { index, color, cell in
                cell.colorImageView.image = UIImage(named: colorArray[indexPath.row].rawValue)
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
            .emit(to: tabBarController?.tabBar.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.saveMyFavor
            .emit(onNext: {[weak self] _ in
                UserDefaults.standard.set(self?.selectedColor.map { $0.rawValue }, forKey: "ColorFavor")
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .drive(onNext: {[weak self] _ in
                self?.present(UserFavor.shared.makeAlert(title: "하나이상 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlcoholChoiceView
            .emit(to: self.rx.presentAlcoholChoiceView)
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
    var updateSelectedItem: Binder<IndexPath> {[weak self] indexPath in
        guard let self = self,
            let selectedCell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
        if self.isCheckedArray[indexPath.row] == false {
            self.isCheckedArray[indexPath.row] = true
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            self.selectedColor.append(colorArray[indexPath.row])
        } else {
            self.isCheckedArray[indexPath.row] = false
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            guard let number = self.selectedColor.firstIndex(of: colorArray[indexPath.row]) else { return }
            self.selectedColor.remove(at: number)
        }
    }
    
    var presentAlcoholChoiceView: Binder<AlcoholChoiceViewModel> {[weak self] viewModel in
            let alcoholChoiceViewController = AlcoholChoiceViewController()
            alcoholChoiceViewController.bind(viewModel)
            self.show(alcoholChoiceViewController, sender: nil)
        }
    }
}
