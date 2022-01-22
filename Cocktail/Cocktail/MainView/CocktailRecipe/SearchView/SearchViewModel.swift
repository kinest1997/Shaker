//
//  SearchViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import RxSwift
import RxCocoa
import UIKit

struct SearchViewModel: searchControllerBindble {
    var inputTexts = PublishRelay<String>()
    
    var outPuts: Signal<String>
    
    init() {
        outPuts = inputTexts
            .distinctUntilChanged()
            .asSignal(onErrorSignalWith: .empty())
    }
}


