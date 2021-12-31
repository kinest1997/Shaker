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
    
    let explainView = UIView()
    let exitbutton = UIButton()
    
    let explainStackView = UIStackView()
    let ozExplainLabel = UILabel()
    let shotExplainLabel = UILabel()
    let shortExplainLabel = UILabel()
    let longExplainLabel = UILabel()
    
    let questionButton = UIButton()
    let questionLabel = UILabel()
    
    let mainStackView = UIStackView()
    
    let shooterButton = UIButton()
    let shortDrinkButton = UIButton()
    let longDrinkButton = UIButton()
    let nextButton = MainButton()
    
    var myFavor: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout() {
        [questionLabel, mainStackView, nextButton, explainView, questionButton].forEach {
            view.addSubview($0)
        }
        explainView.addSubview(exitbutton)
        explainView.addSubview(explainStackView)
        explainView.addSubview(ozExplainLabel)
        
        [shotExplainLabel, shortExplainLabel, longExplainLabel].forEach {
            explainStackView.addArrangedSubview($0)
        }
        
        [shooterButton, shortDrinkButton, longDrinkButton].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        explainView.snp.makeConstraints {
            $0.height.width.equalTo(view.snp.width).multipliedBy(0.8)
            $0.center.equalToSuperview()
        }
        
        questionButton.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(questionLabel)
            $0.width.height.equalTo(30)
        }
        
        explainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        exitbutton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        
        ozExplainLabel.snp.makeConstraints {
            $0.top.equalTo(explainStackView.snp.bottom).offset(40)
            $0.leading.equalTo(explainStackView)
        }

        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(220)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
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
        questionLabel.textColor = UIColor(named: "miniButtonGray")
        questionLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.spacing = 20
          
        [shooterButton, shortDrinkButton, longDrinkButton].forEach {
            $0.setTitleColor(UIColor(named: "miniButtonGray"), for: .normal)
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.masksToBounds = false
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowRadius = 5
            $0.layer.shadowOpacity = 0.4
        }
        [shortExplainLabel, shotExplainLabel, longExplainLabel, ozExplainLabel].forEach {
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor(named: "miniButtonGray")
        }
        
        shotExplainLabel.text = "슈터: 1oz ~ 3oz"
        shortExplainLabel.text = "숏드링크: 3oz ~ 5oz"
        longExplainLabel.text = "롱드링크: 5oz ~"
        ozExplainLabel.text = "1oz = 30ml"
        
        explainStackView.axis = .vertical
        explainStackView.distribution = .fillEqually
        
        questionButton.setBackgroundImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        questionButton.tintColor = .red
        exitbutton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        exitbutton.tintColor = .black
        
        exitbutton.addAction(UIAction(handler: {[weak self] _ in
            self?.explainView.isHidden = true
        }), for: .touchUpInside)
        
        explainView.backgroundColor = .white
        explainView.isHidden = true
        explainView.layer.cornerRadius = 15
        explainView.clipsToBounds = true
        explainView.layer.borderWidth = 1
        
        [shotExplainLabel, shortExplainLabel, longExplainLabel].forEach {
            $0.textColor = UIColor(named: "miniButtonGray")
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        shooterButton.setTitle("슈터", for: .normal)
        shortDrinkButton.setTitle("숏드링크", for: .normal)
        longDrinkButton.setTitle("롱드링크", for: .normal)
        nextButton.setTitle("0개의 칵테일 발견", for: .normal)
        nextButton.isEnabled = false
        
        questionButton.addAction(UIAction(handler: {[weak self] _ in
            self?.explainView.isHidden = false
        }), for: .touchUpInside)
        
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
    }
    
    func setImageAndData(button: UIButton, drinkType: Cocktail.DrinkType) {
        [shooterButton, shortDrinkButton, longDrinkButton].forEach {
            $0.backgroundColor = .white
        }
        button.backgroundColor = UIColor(named: "mainOrangeColor")
        drinkTypeSelected = drinkType
        nextButton.isEnabled = true
    }
    
    func buttonLabelCountUpdate(button: UIButton) {
        let number = filteredRecipe.filter {
            $0.drinkType == drinkTypeSelected
        }.count
        if number == 0 {
            nextButton.backgroundColor = .white
        } else {
            nextButton.backgroundColor = UIColor(named: "mainOrangeColor")
        }
        button.setTitle("\(number)개의 칵테일 발견", for: .normal)
    }
}
