//
//  SearchViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import RxSwift
import RxCocoa
import UIKit

struct SearchViewModel: SearchControllerBindable {
    let inputTexts = PublishRelay<String>()
    
    let outPuts: Signal<String>
    
    init() {
        outPuts = inputTexts
            .distinctUntilChanged()
            .asSignal(onErrorSignalWith: .empty())
    }
}
