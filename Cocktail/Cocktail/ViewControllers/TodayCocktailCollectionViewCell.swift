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
        mainImageView.image = UIImage(named: "Martini")
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
