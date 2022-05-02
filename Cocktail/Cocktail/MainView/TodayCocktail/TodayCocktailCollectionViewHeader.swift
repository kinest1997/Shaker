//
//  TodayCocktailCollectionViewHeader.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit

final class TodayCocktailCollectionViewHeader: UICollectionReusableView {
    
    let sectionTextLabel = UILabel()
    
    let topSplitLine = UILabel()
    let explainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [topSplitLine, sectionTextLabel, explainLabel].forEach {
            addSubview($0)
        }
        sectionTextLabel.snp.makeConstraints {
            $0.top.equalTo(topSplitLine.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        explainLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(sectionTextLabel)
        }
        topSplitLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        topSplitLine.backgroundColor = .splitLineGray
    }
}
