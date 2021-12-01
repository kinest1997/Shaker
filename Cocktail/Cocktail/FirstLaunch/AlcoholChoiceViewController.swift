//
//  AlcoholChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/01.
//

import UIKit
import SnapKit

class AlcoholChoiceViewController: UIViewController {
    
    let questionLabel = UILabel()
    let explainLabel = UILabel()
    
    let highLabel = UILabel()
    let highButton = UIButton()
    let middleButton = UIButton()
    let lowButton = UIButton()
    let lowLabel = UILabel()
    let nextButton = UIButton()
    
    let topVerticalLine = UIView()
    let bottomVerticalLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.backgroundColor = .white
        questionLabel.text = "어떤 맛을 좋아하세요?"
        questionLabel.textAlignment = .center
        questionLabel.textColor = .systemGray2
        explainLabel.text = "*기준: 도수"
        explainLabel.textAlignment = .center
        explainLabel.textColor = .systemGray2
        highLabel.text = "높음"
        highLabel.textColor = .systemGray2
        highLabel.textAlignment = .center
        lowLabel.text = "낮음"
        lowLabel.textColor = .systemGray2
        lowLabel.textAlignment = .center
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.systemGray2, for: .normal)
        
        highButton.setBackgroundImage(UIImage(named: "갈색"), for: .normal)
        middleButton.setBackgroundImage(UIImage(named: "갈색"), for: .normal)
        lowButton.setBackgroundImage(UIImage(named: "갈색"), for: .normal)
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.cornerRadius = 15
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            //알콜 추가 버튼을 넣어야함. 3중에 하나로해서 일단 고민중
            self?.navigationController?.popToRootViewController(animated: true)
            self?.tabBarController?.tabBar.isHidden = false
        }), for: .touchUpInside)
        
        topVerticalLine.backgroundColor = .systemGray2
        bottomVerticalLine.backgroundColor = .systemGray2
    }
    
    func layout() {
        [questionLabel, explainLabel, highLabel, highButton, middleButton, lowLabel, lowButton, nextButton, topVerticalLine, bottomVerticalLine].forEach {
            view.addSubview($0)
        }
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(160)
            $0.leading.trailing.equalToSuperview().inset(85)
            $0.height.equalTo(55)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom)
            $0.trailing.equalTo(questionLabel)
            $0.width.equalTo(70)
            $0.height.equalTo(20)
        }
        
        highLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(170)
            $0.height.equalTo(25)
        }
        
        highButton.snp.makeConstraints {
            $0.top.equalTo(highLabel.snp.bottom)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        middleButton.snp.makeConstraints {
            $0.top.equalTo(highButton.snp.bottom).offset(110)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        lowButton.snp.makeConstraints {
            $0.top.equalTo(middleButton.snp.bottom).offset(110)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        lowLabel.snp.makeConstraints {
            $0.top.equalTo(lowButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(highLabel)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(lowLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(75)
            $0.height.equalTo(30)
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
}
