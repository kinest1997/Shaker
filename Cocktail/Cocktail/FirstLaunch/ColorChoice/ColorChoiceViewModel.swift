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
    var colorModel: ColorChoiceModel
    
    var cellTapped: PublishRelay<IndexPath>
    
    var nextButtontapped: PublishRelay<[Cocktail.Color]>
    
    var changeCellImage: Signal<IndexPath>
    
    var addSelectedColor: Signal<Cocktail.Color>
    
    var showNextPage: Signal<[Cocktail]>
    
    var buttonLabelCountUpdate: Driver<Int>
    
    var presentAlert: Signal<Void>
    
    var colorArray: Driver<[Cocktail.Color]>
    
//    init() {
//        colorModel = ColorChoiceModel()
//
//        changeCellImage = self.cellTapped
//            .asSignal()
//    }
}
