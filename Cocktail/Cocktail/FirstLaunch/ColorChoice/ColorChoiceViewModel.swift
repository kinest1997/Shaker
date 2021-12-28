//
//  ColorChoiceViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/22.
//

import UIKit
import RxCocoa
import RxSwift

struct ColorChoiceViewModel: ColorChoiceBindable {
    var cellTapped: PublishRelay<IndexPath>
    
    var nextButtontapped: PublishRelay<[Cocktail.Color]>
    
    var cellIsChecked: Driver<Cocktail>
    
    var buttonLabelCountUpdate: Driver<Int>
    
    var showNextPage: Signal<Void>
    
    var presentAlert: Signal<Void>
}
