//
//  CocktailListCellTableViewCell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/03.
//

import UIKit
import SnapKit
import Kingfisher

class CocktailListCell: UITableViewCell {
    let cocktailImageView = UIImageView()
    let nameLabel = UILabel()
    let ingredientCountLabel = UILabel()
    let likeCount = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [nameLabel, ingredientCountLabel, cocktailImageView, likeCount].forEach {
            contentView.addSubview($0)
        }
        cocktailImageView.contentMode = .scaleAspectFit
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        ingredientCountLabel.font = .systemFont(ofSize: 15, weight: .medium)
        ingredientCountLabel.alpha = 0.7
        likeCount.textColor = .white
        
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(80)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
            $0.bottom.equalTo(cocktailImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        ingredientCountLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        likeCount.snp.makeConstraints {
            $0.leading.equalTo(ingredientCountLabel.snp.trailing)
            $0.width.equalTo(50)
            $0.height.bottom.equalToSuperview()
        }
    }
    
    func configure(data: Cocktail) {
        nameLabel.text = data.name
        ingredientCountLabel.text = "Ingredients".localized + " \(data.ingredients.count)" + "EA".localized
        cocktailImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(systemName: "heart"))
    }
}