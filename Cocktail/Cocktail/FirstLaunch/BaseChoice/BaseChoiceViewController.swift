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
    
    var selectedBase: Cocktail.Base?
    
    let mainBigStackView = UIStackView()
    let leftStackView = UIStackView()
    let middleStackView = UIStackView()
    let rightStackView = UIStackView()
    
    let ginButton = UIButton()
    let tequilaButton = UIButton()
    let rumButton = UIButton()
    let vodkaButton = UIButton()
    let brandyButton = UIButton()
    let whiskeyButton = UIButton()
    let liqueorButton = UIButton()
    let anyThingButton = UIButton()
    
    let nextButton = MainButton()
    
    let questionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func layout() {
        view.addSubview(mainBigStackView)
        view.addSubview(nextButton)
        view.addSubview(questionLabel)
        mainBigStackView.axis = .vertical
        mainBigStackView.distribution = .fillEqually
        mainBigStackView.spacing = 20
        [leftStackView, middleStackView, rightStackView].forEach {
            mainBigStackView.addArrangedSubview($0)
            $0.distribution = .fillEqually
            $0.spacing = 20
            $0.axis = .horizontal
        }
        
        [ginButton, tequilaButton, whiskeyButton].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [rumButton, vodkaButton, brandyButton].forEach {
            middleStackView.addArrangedSubview($0)
        }
        
        [liqueorButton, anyThingButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        mainBigStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.width.height.equalTo(nextButton)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(mainBigStackView.snp.top).offset(-50)
        }
    }
    
    func attribute() {
        [ginButton, tequilaButton, rumButton, vodkaButton, brandyButton, whiskeyButton, liqueorButton, anyThingButton].forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 15
            $0.setTitleColor(.black, for: .normal)
        }
        view.backgroundColor = .white
        nextButton.setTitle("다음", for: .normal)
        ginButton.setTitle("gin".localized, for: .normal)
        tequilaButton.setTitle("tequila".localized, for: .normal)
        rumButton.setTitle("rum".localized, for: .normal)
        vodkaButton.setTitle("vodka".localized, for: .normal)
        brandyButton.setTitle("brandy".localized, for: .normal)
        whiskeyButton.setTitle("whiskey".localized, for: .normal)
        liqueorButton.setTitle("liqueur".localized, for: .normal)
        anyThingButton.setTitle("다볼래", for: .normal)
        questionLabel.text = "기주를 선택하세요"
        questionLabel.layer.borderWidth = 1
        questionLabel.layer.borderColor = UIColor.black.cgColor
        questionLabel.layer.cornerRadius = 15
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        
        ginButton.addAction(setAction(base: .gin, button: ginButton), for: .touchUpInside)
        tequilaButton.addAction(setAction(base: .tequila, button: tequilaButton), for: .touchUpInside)
        rumButton.addAction(setAction(base: .rum, button: rumButton), for: .touchUpInside)
        vodkaButton.addAction(setAction(base: .vodka, button: vodkaButton), for: .touchUpInside)
        brandyButton.addAction(setAction(base: .brandy, button: brandyButton), for: .touchUpInside)
        whiskeyButton.addAction(setAction(base: .whiskey, button: whiskeyButton), for: .touchUpInside)
        liqueorButton.addAction(setAction(base: .liqueur, button: liqueorButton), for: .touchUpInside)
        anyThingButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let number = self.filteredRecipe.count
            self.selectedBase = .assets
            self.nextButton.setTitle("\(number)개의 칵테일 발견", for: .normal)
            self.setImage(button: self.anyThingButton)
        }), for: .touchUpInside)
        
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            var lastRecipe: [Cocktail] {
                if self.selectedBase == .assets {
                    return self.filteredRecipe
                } else {
                    return self.filteredRecipe.filter { $0.base == self.selectedBase }
                }
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
        let number = filteredRecipe.filter { $0.base == selectedBase }.count
        button.setTitle("\(number)개의 칵테일 발견", for: .normal)
    }
    
    func setAction(base: Cocktail.Base, button: UIButton) -> UIAction {
        let action = UIAction{[weak self] _ in
            guard let self = self else { return }
            self.selectedBase = base
            self.buttonLabelCountUpdate(button: self.nextButton)
            self.setImage(button: button)
        }
        return action
    }
    
    func setImage(button: UIButton) {
        [ginButton, tequilaButton, rumButton, vodkaButton, brandyButton, whiskeyButton, liqueorButton, anyThingButton].forEach {
            $0.backgroundColor = .white
        }
        button.backgroundColor = .brown
        nextButton.isEnabled = true
        nextButton.backgroundColor = .brown
    }
}
