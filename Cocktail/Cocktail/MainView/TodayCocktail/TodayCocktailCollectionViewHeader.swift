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
    
    let topSplitLine = UILabel()
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

            sectionTextLabel.textColor = .black
            sectionTextLabel.sizeToFit()
            sectionTextLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            
            addSubview(sectionTextLabel)
            sectionTextLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(5)
                $0.leading.equalToSuperview().offset(20)
            }
        
        addSubview(topSplitLine)
        
        topSplitLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
            
        }
        topSplitLine.backgroundColor = UIColor(named: "selectedGray")
    }
}
