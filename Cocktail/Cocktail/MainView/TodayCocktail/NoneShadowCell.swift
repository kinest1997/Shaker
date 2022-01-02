//
//  NoneShadowCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import UIKit
import SnapKit

class NoneShadowCell: UICollectionViewCell {
    
    let mainImageView = UIImageView()
    
    var shadows: Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainImageView)
        contentView.backgroundColor = .white

        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainImageView.layer.borderWidth = 0
        mainImageView.layer.cornerRadius = 15
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
}
