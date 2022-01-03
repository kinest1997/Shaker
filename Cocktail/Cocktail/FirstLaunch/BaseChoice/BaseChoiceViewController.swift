//
//  BaseChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/06.
//

import Foundation
import UIKit
import SnapKit

class BaseChoiceViewController: UIViewController {
    
    var filteredRecipe: [Cocktail] = []
    
    var mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var selectedBaseArray = [Cocktail.Base]()
    var isCheckedArray = [Bool]()
    let baseArray: [Cocktail.Base] = [.rum, .vodka, .tequila, .brandy, .whiskey, .gin, .liqueur]
    
    let nextButton = MainButton()
    
    let questionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isCheckedArray = baseArray.map { _ in false}
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(BaseChoiceCollectionViewCell.self, forCellWithReuseIdentifier: "BaseChoiceCollectionViewCell")
        mainCollectionView.isScrollEnabled = false
        
        attribute()
        layout()
    }
    
    func layout() {
        view.addSubview(questionLabel)
        view.addSubview(mainCollectionView)
        view.addSubview(nextButton)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(80)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(400)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func attribute() {
        
        let questionText = NSMutableAttributedString(string: "어떤 술을 선호하시나요?")
        let firstRange = NSRange(location: 0, length: 3)
        let secondReange = NSRange(location: 4, length: 9)
        let tintRange = NSRange(location: 3, length: 1)
        let smallFont = UIFont.nexonFont(ofSize: 20, weight: .bold)
        let bigfont = UIFont.nexonFont(ofSize: 24, weight: .bold)
        let mainColor = UIColor.mainGray
        
        questionText.addAttribute(.font, value: smallFont, range: firstRange)
        questionText.addAttribute(.font, value: smallFont, range: secondReange)
        
        questionText.addAttribute(.foregroundColor, value: mainColor, range: firstRange)
        questionText.addAttribute(.foregroundColor, value: mainColor, range: secondReange)
        
        questionText.addAttribute(.font, value: bigfont, range: tintRange)
        questionText.addAttribute(.foregroundColor, value: UIColor.mainOrange, range: tintRange)
        
        questionLabel.attributedText = questionText
        
        view.backgroundColor = .white
        mainCollectionView.backgroundColor = .white
        questionLabel.textAlignment = .center
        
        nextButton.setTitle("다음", for: .normal)
        
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            var lastRecipe: [Cocktail] {
                return self.filteredRecipe.filter {
                    self.selectedBaseArray.contains($0.base)}
            }
            
            if lastRecipe.isEmpty {
                self.present(UserFavor.shared.makeAlert(title: "다른걸 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            } else {
                let cocktailListViewController = CocktailListViewController()
                cocktailListViewController.lastRecipe = lastRecipe
                self.show(cocktailListViewController, sender: nil)
            }
        }), for: .touchUpInside)
        
    }
    
    func buttonLabelCountUpdate(button: UIButton) {
        let number = filteredRecipe.filter {
            selectedBaseArray.contains($0.base)
        }.count
        button.setTitle("\(number)개의 칵테일 발견", for: .normal)
    }
}

extension BaseChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        baseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.5
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseChoiceCollectionViewCell", for: indexPath) as? BaseChoiceCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(text: baseArray[indexPath.row].rawValue.localized, image: UIImage(named: "\(baseArray[indexPath.row].rawValue)") ?? UIImage())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BaseChoiceCollectionViewCell else { return }
        if isCheckedArray[indexPath.row] == false {
            isCheckedArray[indexPath.row] = true
            cell.isChecked = isCheckedArray[indexPath.row]
            selectedBaseArray.append(baseArray[indexPath.row])
            buttonLabelCountUpdate(button: nextButton)
        } else {
            isCheckedArray[indexPath.row] = false
            cell.isChecked = isCheckedArray[indexPath.row]
            guard let number = selectedBaseArray.firstIndex(of: baseArray[indexPath.row]) else { return }
            selectedBaseArray.remove(at: number)
            buttonLabelCountUpdate(button: nextButton)
        }
        let number = filteredRecipe.filter {
            selectedBaseArray.contains($0.base)
        }.count
        
        if number != 0 {
            nextButton.backgroundColor = .tappedOrange
        } else {
            nextButton.backgroundColor = .white
        }
    }
}
