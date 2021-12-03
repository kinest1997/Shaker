import UIKit
import SnapKit

class ColorChoiceViewController: UIViewController {
    
    let questionLabel = UILabel()
    
    let colorArray = Cocktail.Color.allCases
    var selectedColor = [Cocktail.Color]()
    var isCheckedArray = [Bool]()
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        isCheckedArray = colorArray.map { _ in false}
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
        layout()
        attribute()
        self.tabBarController?.tabBar.isHidden = true
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
            $0.top.equalTo(mainCollectionView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(150)
            $0.height.equalTo(30)
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
            let alcoholChoiceViewController = AlcoholChoiceViewController()
            alcoholChoiceViewController.modalPresentationStyle = .overFullScreen
            self.show(alcoholChoiceViewController, sender: nil)
            UserFavor.shared.colorFavor = self.selectedColor
        }), for: .touchUpInside)
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
        if isCheckedArray[indexPath.row] == false {
            isCheckedArray[indexPath.row] = true
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            selectedColor.append(colorArray[indexPath.row])
        } else {
            isCheckedArray[indexPath.row] = false
            selectedCell.isChecked = isCheckedArray[indexPath.row]
            guard let number = selectedColor.firstIndex(of: colorArray[indexPath.row]) else { return }
            selectedColor.remove(at: number)
        }
    }
}
