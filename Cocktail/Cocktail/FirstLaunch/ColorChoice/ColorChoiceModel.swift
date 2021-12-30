//
//  ColorChoiceModel.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/22.
//

import UIKit
import RxCocoa
import RxSwift

class ColorChoiceModel {
    let colorArray = Cocktail.Color.allCases
    var selectedColor = [Cocktail.Color]()
    var myFavor: Bool = true
    
}
