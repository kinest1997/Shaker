//
//  TodayCocktailCollectionViewCell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit

class TodayCocktailCollectionViewCell: UICollectionViewCell {
    
    let mainImageView = UIImageView()
    let nameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainImageView)
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        nameLabel.textColor = .black
        
        nameLabel.textAlignment = .center
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top).offset(-5)
        }
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.black.cgColor
        nameLabel.layer.cornerRadius = 15
        mainImageView.layer.borderWidth = 0
        mainImageView.layer.cornerRadius = 15
        mainImageView.clipsToBounds = true
        
        nameLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
    }
}
