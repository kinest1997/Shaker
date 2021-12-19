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
    let colorImageView = UIImageView()
    var isChecked: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(colorImageView)
        contentView.layer.cornerRadius = 30
        contentView.addSubview(checkMark)
        checkMark.image = isChecked ? UIImage(systemName: "checkmark") : nil
        colorImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        checkMark.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
