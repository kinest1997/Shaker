//
//  NoTitleHeader.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/03.
//

import UIKit
import SnapKit

class NoTitleHeader: UICollectionReusableView {
    
    let topSplitLine = UILabel()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(topSplitLine)
        
        topSplitLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        topSplitLine.backgroundColor = .splitLineGray
    }
}
