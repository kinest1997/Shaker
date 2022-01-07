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
        nameTextLabel.backgroundColor = .white
        nameTextLabel.textColor = .black
        nameTextLabel.textAlignment = .center
        nameTextLabel.font = .nexonFont(ofSize: 16, weight: .semibold)
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        nameTextLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.borderGray.cgColor
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func configure(data: Cocktail) {
        mainImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(named: "\(data.glass.rawValue)" + "Empty") )
        nameTextLabel.text = data.name
    }
}


