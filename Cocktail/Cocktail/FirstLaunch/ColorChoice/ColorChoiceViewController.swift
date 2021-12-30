import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ColorChoiceBindable {
    //    view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var nextButtontapped: PublishRelay<[Cocktail.Color]> { get }
    
    //    viewModel -> View
    var changeCellImage: Signal<IndexPath> { get }
    var addSelectedColor: Signal<Cocktail.Color> { get }
    var buttonLabelCountUpdate: Driver<Int> { get }
    var showNextPage: Signal<[Cocktail]> { get }
    var presentAlert: Signal<Void> { get }
    var colorArray: Driver<[Cocktail.Color]> { get }
}

class ColorChoiceViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let questionLabel = UILabel()
    
    var myFavor: Bool = true
    
    let colorArray = Cocktail.Color.allCases
    var selectedColor = [Cocktail.Color]()
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let nextButton = MainButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
        layout()
        attribute()
        mainCollectionView.isScrollEnabled = false
        if myFavor {
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    func bind(_ viewModel: ColorChoiceBindable) {
        
        mainCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mainCollectionView.rx.itemSelected
            .bind(to: viewModel.cellTapped)
            .disposed(by: disposeBag)
        
        
        nextButton.rx.tap
            .bind(to: viewModel.nextButtontapped)
            .disposed(by: disposeBag)
        
        
        
        viewModel.colorArray
            .drive(mainCollectionView.rx.items(cellIdentifier: "colorCell", cellType: ColorCollectionViewCell.self)) { index, color, cell in
                cell.colorImageView.image = UIImage(named: color.rawValue)
            }
            .disposed(by: disposeBag)
        

        
    }
    
    func layout() {
        view.addSubview(questionLabel)
        view.addSubview(mainCollectionView)
        view.addSubview(nextButton)
        
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func attribute() {
        questionLabel.text = "선호하는 색은 무엇인가요?"
        view.backgroundColor = .white
        mainCollectionView.backgroundColor = .white
        questionLabel.textAlignment = .center
        questionLabel.textColor = .systemGray2
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.systemGray2, for: .normal)
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            if self.myFavor {
                UserDefaults.standard.set(self.selectedColor.map { $0.rawValue }, forKey: "ColorFavor")
            }
            let lastRecipe = FirebaseRecipe.shared.recipe.filter {
                self.selectedColor.contains($0.color)}
            if lastRecipe.isEmpty {
                self.present(UserFavor.shared.makeAlert(title: "하나이상 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            } else {
                let alcoholChoiceViewController = AlcoholChoiceViewController()
                alcoholChoiceViewController.myFavor = self.myFavor
                alcoholChoiceViewController.filteredRecipe = lastRecipe
                self.show(alcoholChoiceViewController, sender: nil)
            }
        }), for: .touchUpInside)
    }
    
    func buttonLabelCountUpdate(button: UIButton) {
        let number = FirebaseRecipe.shared.recipe.filter {
            selectedColor.contains($0.color)
        }.count
        button.setTitle("\(number)개의 칵테일 발견", for: .normal)
    }
}

extension ColorChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Cocktail.Color.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
        cell.colorImageView.image = UIImage(named: colorArray[indexPath.row].rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
        
        if selectedColor.contains(colorArray[indexPath.row]) {
            guard let number = selectedColor.firstIndex(of: colorArray[indexPath.row]) else { return }
            selectedCell.isChecked = false
            selectedColor.remove(at: number)
            buttonLabelCountUpdate(button: nextButton)
        } else {
            selectedCell.isChecked = true
            selectedColor.append(colorArray[indexPath.row])
            buttonLabelCountUpdate(button: nextButton)
        }
    }
}

extension Reactive where Base: ColorChoiceViewController {
    var setCheckImage: Binder<(IndexPath, Bool)> {
        return Binder(base) { base, data in
            guard let cell = base.mainCollectionView.cellForItem(at: data.0) as? ColorCollectionViewCell else { return }
            cell.isChecked = data.1
        }
    }
}
