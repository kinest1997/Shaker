//
//  DrinkTypeChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/06.
//

import UIKit
import SnapKit

class DrinkTypeChoiceViewController: UIViewController {
    
    var drinkTypeSelected: Cocktail.DrinkType?
    
    var filteredRecipe = [Cocktail]()
    
    let questionLabel = UILabel()
    
    let mainStackView = UIStackView()
    let shooterButton = UIButton()
    let shortDrinkButton = UIButton()
    let longDrinkButton = UIButton()
    let nextButton = UIButton()
    
    let informationButton = UIButton()
    
    var myFavor: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout() {
        view.addSubview(questionLabel)
        view.addSubview(mainStackView)
        view.addSubview(nextButton)
        view.addSubview(informationButton)
        
        mainStackView.addArrangedSubview(shooterButton)
        mainStackView.addArrangedSubview(shortDrinkButton)
        mainStackView.addArrangedSubview(longDrinkButton)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.trailing.equalToSuperview().inset(70)
            $0.height.equalTo(50)
        }
        
        informationButton.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing)
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(questionLabel)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(220)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(120)
            $0.height.equalTo(50)
            $0.width.equalTo(220)
            $0.centerX.equalToSuperview()
        }
        
        [shortDrinkButton, longDrinkButton, shooterButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(250)
            }
        }
    }
    
    func attribute() {
        view.backgroundColor = .white
        questionLabel.text = "선호하는 칵테일 용량"
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        
        [shooterButton, shortDrinkButton, longDrinkButton, nextButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 15
        }

        questionLabel.textColor = .black
        shooterButton.setTitle("슈터", for: .normal)
        shortDrinkButton.setTitle("숏드링크", for: .normal)
        longDrinkButton.setTitle("롱드링크", for: .normal)
        nextButton.setTitle("다음", for: .normal)
        nextButton.isEnabled = false
        nextButton.backgroundColor = .white
        
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let lastRecipe = self.filteredRecipe.filter {$0.drinkType == self.drinkTypeSelected}
            if lastRecipe.isEmpty {
                self.present(UserFavor.shared.makeAlert(title: "다른걸 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            } else {
                let baseChoiceViewController = BaseChoiceViewController()
                    baseChoiceViewController.filteredRecipe = lastRecipe
                self.show(baseChoiceViewController, sender: nil)
            }
        }), for: .touchUpInside)
        
        shooterButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.shooterButton, drinkType: .shooter)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)
        shortDrinkButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.shortDrinkButton, drinkType: .shortDrink)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)
        longDrinkButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.longDrinkButton, drinkType: .longDrink)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)
        
        informationButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    }
    
    func setImageAndData(button: UIButton, drinkType: Cocktail.DrinkType) {
        [shooterButton, shortDrinkButton, longDrinkButton].forEach {
            $0.backgroundColor = .white
        }
        button.backgroundColor = .brown
        drinkTypeSelected = drinkType
        nextButton.isEnabled = true
        nextButton.backgroundColor = .brown
    }
    
    func buttonLabelCountUpdate(button: UIButton) {
        let number = filteredRecipe.filter {
            $0.drinkType == drinkTypeSelected
        }.count
        button.setTitle("\(number)개의 칵테일 발견", for: .normal)
    }
}