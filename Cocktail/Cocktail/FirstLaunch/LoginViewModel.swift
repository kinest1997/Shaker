//
//  LoginViewModel.swift
//  Cocktail
//
//  Created by Bo-Young Park on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel: LoginViewBindable {
    let startAppleSignInFlow: Signal<Void>
    let updateFirstLaunchStatus: Signal<Bool>
    let updateRootViewController: Signal<Void>
    let tabBarHidden: Signal<Bool>
    
    let appleLoginButtonTapped = PublishRelay<Void>()
    let justUseButtonTapped = PublishRelay<Void>()
    
    init() {
        startAppleSignInFlow = appleLoginButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        updateFirstLaunchStatus = justUseButtonTapped
            .map { false }
            .asSignal(onErrorSignalWith: .empty())
        
        updateRootViewController = justUseButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        tabBarHidden = justUseButtonTapped
            .map { false }
            .asSignal(onErrorSignalWith: .empty())
    }
}
