//
//  AlcoholChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol AlcoholChoiceViewBindable {
    typealias DrinkTypeChoiceViewComponents = (favor: Bool, recipe: [Cocktail])
    var drinkTypeChoiceViewModel: DrinkTypeChoiceViewModel { get }
    
    var myFavor: Signal<Bool> { get }
    var isNextButtonEnabled: Signal<Bool> { get }
    var setButtonImage: Signal<Cocktail.Alcohol> { get }
    var buttonLabelCount: Signal<Int> { get }
    var showReadyToLaunchViewController: Driver<Void> { get }
    var presentAlert: Driver<Void> { get }
    var showDrinkTypeChoiceView: Driver<Void> { get }
    
    var alcoholLevelButtonTapped: PublishRelay<Cocktail.Alcohol> { get }
    var nextButtonTapped: PublishRelay<Void> { get }
}

class AlcoholChoiceViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let drinkTypeChoiceViewController = DrinkTypeChoiceViewController()
    
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
    
    func bind(_ viewModel: AlcoholChoiceViewBindable) {
        drinkTypeChoiceViewController.bind(viewModel.drinkTypeChoiceViewModel)
        
        viewModel.myFavor
            .emit(to: tabBarController!.tabBar.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isNextButtonEnabled
            .emit(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.setButtonImage
            .emit(to: self.rx.setImage)
            .disposed(by: disposeBag)
        
        viewModel.buttonLabelCount
            .map { "\($0)개의 칵테일 발견" }
            .emit(to: nextButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.showReadyToLaunchViewController
            .drive(onNext: {[weak self] _ in
                self?.show(ReadyToLaunchViewController(), sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .drive(onNext: {[weak self] _ in
                self?.present(UserFavor.shared.makeAlert(title: "다른걸 선택해주세요!", message: "추천할술이 없어요"), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.showDrinkTypeChoiceView
            .drive(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.show(self.drinkTypeChoiceViewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        highButton.rx.tap
            .map { Cocktail.Alcohol.high }
            .do(onNext: {
                UserDefaults.standard.set($0.rawValue, forKey: "AlcoholFavor")
            })
            .bind(to: viewModel.alcoholLevelButtonTapped)
            .disposed(by: disposeBag)
        
        middleButton.rx.tap
            .map { Cocktail.Alcohol.mid }
            .do(onNext: {
                UserDefaults.standard.set($0.rawValue, forKey: "AlcoholFavor")
            })
            .bind(to: viewModel.alcoholLevelButtonTapped)
            .disposed(by: disposeBag)
        
        lowButton.rx.tap
            .map { Cocktail.Alcohol.low }
            .do(onNext: {
                UserDefaults.standard.set($0.rawValue, forKey: "AlcoholFavor")
            })
            .bind(to: viewModel.alcoholLevelButtonTapped)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .do(onNext: {[weak self] _ in
                self?.topVerticalLine.backgroundColor = .systemGray2
                self?.bottomVerticalLine.backgroundColor = .systemGray2
            })
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        
        questionLabel.text = "어떤 맛을 좋아하세요?"
        questionLabel.textAlignment = .center
        questionLabel.textColor = .systemGray2

        explainLabel.font = .systemFont(ofSize: 10)
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
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.cornerRadius = 15
        
        [highButton, middleButton, lowButton].forEach {
            $0.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
                
        topVerticalLine.backgroundColor = .systemGray2
        bottomVerticalLine.backgroundColor = .systemGray2
    }
    
    private func layout() {
        [questionLabel, explainLabel, highLabel, highButton, middleButton, lowLabel, lowButton, nextButton, topVerticalLine, bottomVerticalLine].forEach {
            view.addSubview($0)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
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
            $0.width.equalTo(150)
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

extension Reactive where Base: AlcoholChoiceViewController {
    var setImage: Binder<Cocktail.Alcohol> {
        return Binder(base) { base, alcohol in
            switch alcohol {
            case .high:
                base.highButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            case .mid:
                base.middleButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            case .low:
                base.lowButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            default:
                return
            }
        }
    }
}
