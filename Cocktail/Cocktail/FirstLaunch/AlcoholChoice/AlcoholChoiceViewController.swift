//
//  AlcoholChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/01.
//

import UIKit
import SnapKit

class AlcoholChoiceViewController: UIViewController {

    var myFavor: Bool = true

    var filteredRecipe: [Cocktail] = []

    var alcoholSelected: Cocktail.Alcohol?

    let questionLabel = UILabel()
    let explainLabel = UILabel()

    let highLabel = UILabel()
    let highButton = UIButton()
    let middleButton = UIButton()
    let lowButton = UIButton()
    let lowLabel = UILabel()
    let nextButton = MainButton()

    let topVerticalLine = UILabel()
    let bottomVerticalLine = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        nextButton.isEnabled = false
        attribute()
        layout()
        if myFavor {
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
    }

    func attribute() {

        let originText = "What Flavor do you like?".localized

        if NSLocale.current.languageCode == "ko" {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 3), bigFont: UIFont.nexonFont(ofSize: 24, weight: .bold), secondRange: NSRange(location: 4, length: 8), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 3, length: 1))

            questionLabel.attributedText = questionText
        } else {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 5), bigFont: UIFont.nexonFont(ofSize: 24, weight: .bold), secondRange: NSRange(location: 11, length: 13), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 5, length: 6))
            questionLabel.attributedText = questionText
        }

        view.backgroundColor = .white

        questionLabel.textAlignment = .center

        explainLabel.text = "*Standard: Alcohol".localized
        explainLabel.textAlignment = .center
        explainLabel.textColor = .mainGray
        highLabel.text = "High".localized
        highLabel.textColor = .mainGray
        highLabel.textAlignment = .center
        lowLabel.text = "Low".localized
        lowLabel.textColor = .mainGray
        lowLabel.textAlignment = .center
        nextButton.setTitle("Next".localized, for: .normal)

        [highButton, middleButton, lowButton].forEach {
            $0.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            $0.tintColor = .tappedOrange
        }

        nextButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            if self.myFavor {
                UserDefaults.standard.set(self.alcoholSelected?.rawValue, forKey: "AlcoholFavor")
                let readyToLaunchViewController = ReadyToLaunchViewController()
                readyToLaunchViewController.bind(ReadyToLaunchViewModel())

                self.show(readyToLaunchViewController, sender: nil)

            } else {
                let lastRecipe = self.filteredRecipe.filter { $0.alcohol == self.alcoholSelected }
                if lastRecipe.isEmpty {
                    self.present(UserFavor.shared.makeAlert(title: "Please choose something else!".localized, message: "I don't have anything to recommend".localized), animated: true, completion: nil)
                } else {
                    let drinkTypeChoiceViewController = DrinkTypeChoiceViewController()
                    drinkTypeChoiceViewController.myFavor = self.myFavor
                    drinkTypeChoiceViewController.filteredRecipe = lastRecipe
                    self.show(drinkTypeChoiceViewController, sender: nil)
                }
            }
        }), for: .touchUpInside)

        highButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.highButton, alcohol: .high)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)

        middleButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.middleButton, alcohol: .mid)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)

        lowButton.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self else { return }
            self.setImageAndData(button: self.lowButton, alcohol: .low)
            self.buttonLabelCountUpdate(button: self.nextButton)
        }), for: .touchUpInside)

        topVerticalLine.backgroundColor = .systemGray2
        bottomVerticalLine.backgroundColor = .systemGray2
    }

    func setImageAndData(button: UIButton, alcohol: Cocktail.Alcohol) {
        [lowButton, middleButton, highButton].forEach {
            $0.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        button.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        alcoholSelected = alcohol
        nextButton.isEnabled = true
    }

    func layout() {
        [questionLabel, explainLabel, highLabel, highButton, middleButton, lowLabel, lowButton, nextButton, topVerticalLine, bottomVerticalLine].forEach {
            view.addSubview($0)
        }

        questionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(55)
        }

        explainLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom)
            $0.trailing.equalTo(questionLabel)
            $0.height.equalTo(20)
        }

        highLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(25)
        }

        highButton.snp.makeConstraints {
            $0.top.equalTo(highLabel.snp.bottom)
            $0.width.height.equalTo(35)
            $0.centerX.equalToSuperview()
        }

        middleButton.snp.makeConstraints {
            $0.top.equalTo(highButton.snp.bottom).offset(80)
            $0.width.height.equalTo(highButton)
            $0.centerX.equalToSuperview()
        }

        lowButton.snp.makeConstraints {
            $0.top.equalTo(middleButton.snp.bottom).offset(80)
            $0.width.height.equalTo(highButton)
            $0.centerX.equalToSuperview()
        }

        lowLabel.snp.makeConstraints {
            $0.top.equalTo(lowButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(highLabel)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }

        topVerticalLine.snp.makeConstraints {
            $0.top.equalTo(highButton.snp.bottom)
            $0.bottom.equalTo(middleButton.snp.top)
            $0.width.equalTo(2)
            $0.centerX.equalToSuperview()
        }

        bottomVerticalLine.snp.makeConstraints {
            $0.top.equalTo(middleButton.snp.bottom)
            $0.bottom.equalTo(lowButton.snp.top)
            $0.width.equalTo(2)
            $0.centerX.equalToSuperview()
        }
    }

    func buttonLabelCountUpdate(button: UIButton) {
        let number = filteredRecipe.filter {
            $0.alcohol == alcoholSelected
        }.count
        if number == 0 {
            button.backgroundColor = .white
        } else {
            button.backgroundColor = .tappedOrange
        }
        button.setTitle("\(number)" + "cocktails have searched".localized, for: .normal)
    }
}
