//
//  EmptyCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/02/26.
//

import Foundation
import UIKit
import SnapKit

class EmptyCell: UICollectionViewCell {
    
    let emptyView = EmptyView()
    
    override func layoutSubviews() {
        contentView.addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
