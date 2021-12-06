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
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        nameLabel.textAlignment = .center
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
    }
}
