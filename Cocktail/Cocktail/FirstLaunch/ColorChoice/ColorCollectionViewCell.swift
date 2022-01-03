//
//  ColorCollectionViewCell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/30.
//

import UIKit
import SnapKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    let checkMark = UIImageView()
    let colorView = UIImageView()
    var isChecked: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(colorView)
        contentView.addSubview(checkMark)
        
        contentView.layer.borderWidth = isChecked ? 4 : 0
        contentView.layer.borderColor = UIColor.borderGray.cgColor
        contentView.layer.cornerRadius = 45
        contentView.clipsToBounds = true
        colorView.contentMode = .scaleAspectFill
        colorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        checkMark.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
