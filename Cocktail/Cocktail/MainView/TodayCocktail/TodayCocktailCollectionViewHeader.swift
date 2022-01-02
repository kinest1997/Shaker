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
    let explainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(topSplitLine)
        addSubview(sectionTextLabel)
        addSubview(explainLabel)
        
        sectionTextLabel.textColor = UIColor(named: "miniButtonGray")
        sectionTextLabel.sizeToFit()
        sectionTextLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        explainLabel.textColor = UIColor(named: "miniButtonGray")
        explainLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        sectionTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(sectionTextLabel.snp.bottom)
            $0.leading.equalTo(sectionTextLabel)
        }
        
        topSplitLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        topSplitLine.backgroundColor = UIColor(named: "selectedGray")
    }
}
