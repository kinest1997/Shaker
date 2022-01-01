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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
    }
}
