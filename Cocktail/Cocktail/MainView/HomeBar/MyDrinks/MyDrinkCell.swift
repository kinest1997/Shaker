//
//  MyDrinkCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/04.
//

import UIKit
import SnapKit

final class MyDrinkCell: UICollectionViewCell {
    
    let mainImage = UIImageView()
    
    let badgecount = UILabel()
    
    let nameTextLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [mainImage, badgecount, nameTextLabel].forEach {
            contentView.addSubview($0)
        }
        
        mainImage.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }

        nameTextLabel.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        badgecount.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.width.height.equalTo(20)
        }
        
        mainImage.contentMode = .scaleAspectFit
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.splitLineGray.cgColor
        nameTextLabel.font = .nexonFont(ofSize: 20, weight: .semibold)
        nameTextLabel.backgroundColor = .white
        nameTextLabel.textColor = .mainGray
        nameTextLabel.textAlignment = .center
        
        badgecount.textColor = .white
        badgecount.textAlignment = .center
        badgecount.layer.cornerRadius = 10
        badgecount.layer.masksToBounds = true
        badgecount.font = .nexonFont(ofSize: 15, weight: .semibold)
        if badgecount.text == "0" {
            badgecount.backgroundColor = .systemGray
        } else {
            badgecount.backgroundColor = .mainOrange
        }
    }
}
