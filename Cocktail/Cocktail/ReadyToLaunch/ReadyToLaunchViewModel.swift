//
//  ReadyToLaunchViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/10.
//

import Foundation
import RxSwift
import RxCocoa

struct ReadyToLaunchViewModel: ReadyToLaunchViewBindable {
    var readytoLaunchButtonTapped = PublishRelay<Void>()

    var showNextPage: Signal<Void>

    init() {
        showNextPage = self.readytoLaunchButtonTapped
            .asSignal()
    }
}
