//
//  TodayCocktailCollectionViewHeader.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit

class TodayCocktailCollectionViewHeader: UICollectionReusableView {
    
    let sectionTextLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionTextLabel.textColor = .black
        sectionTextLabel.sizeToFit()
        sectionTextLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        addSubview(sectionTextLabel)
        sectionTextLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(5)
        }
    }
}
