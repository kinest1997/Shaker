//
//  DrinkTypeChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol DrinkTypeChoiceViewBindable {
    //viewModel -> view
    var setImageAndData: Signal<Cocktail.DrinkType> { get }
    var buttonLabelCount: Signal<Int> { get }
    var presentAlert: Signal<Void> { get }
    var presentBaseChoiceViewController: Signal<[Cocktail]> { get }
    
    //view -> viewModel
    var cocktailTypeButtonTapped: PublishRelay<Cocktail.DrinkType> { get }
    var nextButtonTapped: PublishRelay<Void> { get }
    var informationButtonTapped: PublishRelay<Void> { get }
}


class DrinkTypeChoiceViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let questionLabel = UILabel()
    let mainStackView = UIStackView()
    let shooterButton = UIButton()
    let shortDrinkButton = UIButton()
    let longDrinkButton = UIButton()
    let nextButton = UIButton()
    let informationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func bind(_ viewModel: DrinkTypeChoiceViewBindable) {
        viewModel.setImageAndData
            .emit(to: self.rx.setImageAndData)
            .disposed(by: disposeBag)
        
        viewModel.buttonLabelCount
            .map { number in
                "\(number)개의 칵테일 발견"
            }
            .emit(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(onNext: {[weak self] _ in
                self?.present(UserFavor.shared.makeAlert(title: "다른걸 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentBaseChoiceViewController
            .emit(onNext: {[weak self] lastRecipe in
                let baseChoiceViewController = BaseChoiceViewController()
                    baseChoiceViewController.filteredRecipe = lastRecipe
                self?.show(baseChoiceViewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        shooterButton.rx.tap
            .map { _ in Cocktail.DrinkType.shooter}
            .bind(to: viewModel.cocktailTypeButtonTapped)
            .disposed(by: disposeBag)
        
        shortDrinkButton.rx.tap
            .map { _ in Cocktail.DrinkType.shortDrink}
            .bind(to: viewModel.cocktailTypeButtonTapped)
            .disposed(by: disposeBag)
        
        longDrinkButton.rx.tap
            .map { _ in Cocktail.DrinkType.longDrink}
            .bind(to: viewModel.cocktailTypeButtonTapped)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: disposeBag)
        
        informationButton.rx.tap        //TODO: 현재 받는 쪽 없지만 생성만 해놈
            .bind(to: viewModel.informationButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func layout() {
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
    
    private func attribute() {
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
        
        informationButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    }
}

extension Reactive where Base: DrinkTypeChoiceViewController {
    var setImageAndData: Binder<Cocktail.DrinkType> {
        return Binder(base) { base, drinkType in
            [base.shooterButton, base.shortDrinkButton, base.longDrinkButton].forEach {
                $0.backgroundColor = .white
            }
            
            switch drinkType {
            case .shooter:
                base.shooterButton.backgroundColor = .brown
            case .shortDrink:
                base.shortDrinkButton.backgroundColor = .brown
            case .longDrink:
                base.longDrinkButton.backgroundColor = .brown
            }
            
            base.nextButton.isEnabled = true
            base.nextButton.backgroundColor = .brown
        }
    }
}
