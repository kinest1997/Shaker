//
//  HashTagCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/03.
//

import UIKit
import SnapKit

class HashTagCell: UICollectionViewCell {
    
    let textLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        textLabel.font = .nexonFont(ofSize: 18, weight: .semibold)
        textLabel.textColor = .mainGray
        textLabel.textAlignment = .center
        contentView.backgroundColor = .tappedOrange
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.splitLineGray.cgColor
    }
}
