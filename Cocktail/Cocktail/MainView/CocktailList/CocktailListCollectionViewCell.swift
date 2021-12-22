//
//  CocktailListCollectionViewCell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/19.
//

import UIKit
import SnapKit
import Kingfisher

class CocktailListCollectionViewCell: UICollectionViewCell {
    let mainImageView = UIImageView()
    let nameTextLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainImageView)
        contentView.addSubview(nameTextLabel)
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        nameTextLabel.textColor = .black
        nameTextLabel.textAlignment = .center
        nameTextLabel.font = .systemFont(ofSize: 14, weight: .medium)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        nameTextLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(data: Cocktail) {
        mainImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(systemName: "heart"))
        nameTextLabel.text = data.name
    }
}
