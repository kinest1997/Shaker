//
//  ColorChoiceModel.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/22.
//

import UIKit
import RxCocoa
import RxSwift

struct ColorChoiceModel {
    let colorArray = Cocktail.Color.allCases
    var selectedColor = [Cocktail.Color]()
    var myFavor: Bool = true
    
//    guard let selectedCell = base.mainCollectionView.cellForItem(at: data.indexPath) as? ColorCollectionViewCell else { return }
//
//    if base.selectedColor.contains(base.selectedColor[data.indexPath.row]) {
//        guard let number = base.selectedColor.firstIndex(of: base.selectedColor[data.indexPath.row]) else { return }
//        selectedCell.isChecked = false
//        base.selectedColor.remove(at: number)
//    } else {
//        selectedCell.isChecked = true
//        base.selectedColor.append(base.selectedColor[data.indexPath.row])
//    }
}
