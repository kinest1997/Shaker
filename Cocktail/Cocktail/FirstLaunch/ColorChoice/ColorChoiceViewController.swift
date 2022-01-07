import UIKit
import SnapKit
import RxSwift
import RxCocoa

import UIKit
import SnapKit

class ColorChoiceViewController: UIViewController {
    
    let questionLabel = UILabel()
    
    var myFavor: Bool = true
    
    let colorArray = Cocktail.Color.allCases
    var selectedColor = [Cocktail.Color]()
    var isCheckedArray = [Bool]()
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let nextButton = MainButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isCheckedArray = colorArray.map { _ in false}
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
        mainCollectionView.isScrollEnabled = false
        layout()
        attribute()
        if myFavor {
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func layout() {
        view.addSubview(questionLabel)
        view.addSubview(mainCollectionView)
        view.addSubview(nextButton)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func attribute() {
        let questionText = NSMutableAttributedString(string: "What's your favorite color?".localized)
        let firstRange = NSRange(location: 0, length: 5)
        let secondReange = NSRange(location: 6, length: 8)
        let smallFont = UIFont.nexonFont(ofSize: 20, weight: .bold)
        let bigfont = UIFont.nexonFont(ofSize: 24, weight: .bold)
        let mainColor = UIColor.mainGray
        
        questionText.addAttribute(.font, value: smallFont, range: firstRange)
        questionText.addAttribute(.font, value: smallFont, range: secondReange)
        
        questionText.addAttribute(.foregroundColor, value: mainColor, range: firstRange)
        questionText.addAttribute(.foregroundColor, value: mainColor, range: secondReange)
        
        questionText.addAttribute(.font, value: bigfont, range: NSRange(location: 5, length: 1))
        questionText.addAttribute(.foregroundColor, value: UIColor.mainOrange, range: NSRange(location: 5, length: 1))
        
        questionLabel.attributedText = questionText
        view.backgroundColor = .white
        mainCollectionView.backgroundColor = .white
        questionLabel.textAlignment = .center

        nextButton.setTitle("Next".localized, for: .normal)
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            if self.myFavor {
                UserDefaults.standard.set(self.selectedColor.map { $0.rawValue }, forKey: "ColorFavor")
            }
            let lastRecipe = FirebaseRecipe.shared.recipe.filter {
                self.selectedColor.contains($0.color)}
            if lastRecipe.isEmpty {
                self.present(UserFavor.shared.makeAlert(title: "Please choose one or more", message: "I don't have any drinks to recommend"), animated: true, completion: nil)
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
        button.setTitle("\(number)" + "cocktails have searched".localized, for: .normal)
    }
}

extension ColorChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Cocktail.Color.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.9
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
        cell.colorView.image = UIImage(named: colorArray[indexPath.row].rawValue)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
        if isCheckedArray[indexPath.row] == false {
            isCheckedArray[indexPath.row] = true
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            selectedColor.append(colorArray[indexPath.row])
            buttonLabelCountUpdate(button: nextButton)
        } else {
            isCheckedArray[indexPath.row] = false
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            guard let number = selectedColor.firstIndex(of: colorArray[indexPath.row]) else { return }
            selectedColor.remove(at: number)
            buttonLabelCountUpdate(button: nextButton)
        }
        if !selectedColor.isEmpty {
            nextButton.backgroundColor = .tappedOrange
        } else {
            nextButton.backgroundColor = .white
        }
    }
}

/*

protocol ColorChoiceBindable {
    //    view -> viewModel
    var cellTapped: PublishRelay<IndexPath> { get }
    var nextButtontapped: PublishRelay<Void> { get }

    //    viewModel -> View
    var selectedColor : Driver<[Cocktail.Color]> { get }
    //내가 현재 가진 색들
    var updateCell: Signal<(indexPath :IndexPath, bool: Bool)> { get }
    var buttonLabelCountUpdate: Signal<Int> { get }
    var showNextPage: Driver<Void> { get }
    var presentAlert: Driver<Void> { get }
    var colorArray: Driver<[Cocktail.Color]> { get }
    var myFavor: Signal<Bool> { get }
    var saveMyFavor: Signal<[Cocktail.Color]> { get }
}

class ColorChoiceViewController: UIViewController {

    let disposeBag = DisposeBag()

    let alcoholChoiceViewController = AlcoholChoiceViewController()

    let questionLabel = UILabel()

    //    var myFavor: Bool = true
//
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    let nextButton = MainButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        //        mainCollectionView.delegate = self
        //        mainCollectionView.dataSource = self
        //        mainCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
        layout()
        attribute()
        mainCollectionView.isScrollEnabled = false
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

        //컬렉션뷰 설정할때는 데이터를 observable 형태로 만들어줘야한다?
        viewModel.colorArray
            .drive(mainCollectionView.rx.items(cellIdentifier: "colorCell", cellType: ColorCollectionViewCell.self)) { index, color, cell in
                cell.colorImageView.image = UIImage(named: color.rawValue)
            }
            .disposed(by: disposeBag)

        viewModel.updateCell
            .emit(to: self.rx.cellTapped)
            .disposed(by: disposeBag)

        viewModel.buttonLabelCountUpdate
            .map{ "\($0)개의 칵테일 발견" }
            .emit(to: nextButton.rx.title(for: .normal))
            .disposed(by: disposeBag)

        viewModel.showNextPage
            .drive(self.rx.presentAlcoholChoieViewController)
            .disposed(by: disposeBag)

        viewModel.presentAlert
            .drive {[weak self] _ in
                self?.present(UserFavor.shared.makeAlert(title: "하나이상 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)}
            .disposed(by: disposeBag)

        viewModel.myFavor
            .emit { bool in
                self.tabBarController?.tabBar.isHidden = bool
            }
            .disposed(by: disposeBag)

        viewModel.saveMyFavor
            .emit { colors in
                UserDefaults.standard.set(colors.map { $0.rawValue }, forKey: "ColorFavor")
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

extension ColorChoiceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Cocktail.Color.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
    //        cell.colorImageView.image = UIImage(named: colorArray[indexPath.row].rawValue)
    //        return cell
    //    }
}

extension Reactive where Base: ColorChoiceViewController {
    var cellTapped: Binder<(indexPath :IndexPath, bool: Bool)> {
        return Binder(base) {base, data in
            guard let cell = base.mainCollectionView.cellForItem(at: data.indexPath) as? ColorCollectionViewCell else { return }
            cell.isChecked = data.bool
        }
    }

    var presentAlcoholChoieViewController: Binder<Void> {
        return Binder(base) { base, _ in
            base.show(base.alcoholChoiceViewController, sender: nil)
        }
    }
}

*/
