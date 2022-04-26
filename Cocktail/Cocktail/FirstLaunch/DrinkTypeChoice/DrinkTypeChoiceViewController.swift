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
            $0.top.trailing.equalToSuperview().inset(5)
            $0.height.width.equalTo(30)
        }

        ozExplainLabel.snp.makeConstraints {
            $0.top.equalTo(explainStackView.snp.bottom).offset(40)
            $0.leading.equalTo(explainStackView)
        }

        questionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        let originText = "Favorite cocktail Size".localized

        if NSLocale.current.languageCode == "ko" {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 8), bigFont: UIFont.nexonFont(ofSize: 24, weight: .bold), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 8, length: 3))
            questionLabel.attributedText = questionText
        } else {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 18), bigFont: UIFont.nexonFont(ofSize: 24, weight: .bold), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 18, length: 4))
            questionLabel.attributedText = questionText
        }

        view.backgroundColor = .white
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.spacing = 20

        [shooterButton, shortDrinkButton, longDrinkButton].forEach {
            $0.setTitleColor(.mainGray, for: .normal)
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.setTitleColor(.mainGray, for: .normal)
            $0.titleLabel?.font = .nexonFont(ofSize: 18, weight: .semibold)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.borderGray.cgColor
        }
        [shortExplainLabel, shotExplainLabel, longExplainLabel, ozExplainLabel].forEach {
            $0.font = .nexonFont(ofSize: 20, weight: .semibold)
            $0.textColor = .mainGray
        }

        shotExplainLabel.text = "shooter".localized + ": 1oz ~ 3oz"
        shortExplainLabel.text = "shortDrink".localized + ": 3oz ~ 5oz"
        longExplainLabel.text = "longDrink".localized + ": 5oz ~"
        ozExplainLabel.text = "1oz = 30ml"

        explainStackView.axis = .vertical
        explainStackView.distribution = .fillEqually

        questionButton.setBackgroundImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        questionButton.tintColor = .tappedOrange
        exitbutton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        exitbutton.tintColor = .mainGray

        exitbutton.addAction(UIAction(handler: {[weak self] _ in
            self?.explainView.isHidden = true
        }), for: .touchUpInside)

        explainView.backgroundColor = .white
        explainView.isHidden = true
        explainView.layer.cornerRadius = 15
        explainView.clipsToBounds = true
        explainView.layer.borderWidth = 1
        explainView.layer.borderColor = UIColor.borderGray.cgColor

        shooterButton.setTitle("shooter".localized, for: .normal)
        shortDrinkButton.setTitle("shortDrink".localized, for: .normal)
        longDrinkButton.setTitle("longDrink".localized, for: .normal)
        nextButton.setTitle("0" + "cocktails have searched".localized, for: .normal)
        nextButton.isEnabled = false

        questionButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.explainView.isHidden = self.explainView.isHidden ? false : true
        }), for: .touchUpInside)

        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            let lastRecipe = self.filteredRecipe.filter {$0.drinkType == self.drinkTypeSelected}
            if lastRecipe.isEmpty {
                self.present(UserFavor.shared.makeAlert(title: "Please choose something else!".localized, message: "I don't have anything to recommend".localized), animated: true, completion: nil)
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
        button.backgroundColor = .tappedOrange
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
            nextButton.backgroundColor = .tappedOrange
        }
        button.setTitle("\(number)" + "cocktails have searched".localized, for: .normal)
    }
}
