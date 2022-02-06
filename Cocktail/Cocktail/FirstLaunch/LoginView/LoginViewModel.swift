//
//  LoginViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/19.
//

import UIKit
import RxSwift
import RxCocoa

struct LoginViewModel: LoginViewBiandable {
    let startSignInWithAppleFlow: Signal<Void>
    let updateFirstLogin: Signal<Bool>
    let changeLoginView: Signal<Void>

    let appleLoginButtonTapped = PublishRelay<Void>()
    let justUseButtonTapped = PublishRelay<Void>()

    init() {
        startSignInWithAppleFlow = appleLoginButtonTapped
            .asSignal()

        updateFirstLogin = appleLoginButtonTapped
            .map { false }
            .asSignal(onErrorJustReturn: false)

        changeLoginView = justUseButtonTapped
            .asSignal()
    }
}
