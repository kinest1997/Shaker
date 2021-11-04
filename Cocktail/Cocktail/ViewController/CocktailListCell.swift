//
//  CocktailListCellTableViewCell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/03.
//

import UIKit
import SnapKit

class CocktailListCell: UITableViewCell {
    let cocktailImage = UIImageView()
    let nameLabel = UILabel()
    let ingredientCountLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [nameLabel, ingredientCountLabel, cocktailImage].forEach {
            contentView.addSubview($0)
        }
        cocktailImage.contentMode = .scaleAspectFit
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        ingredientCountLabel.font = .systemFont(ofSize: 15, weight: .medium)
        ingredientCountLabel.alpha = 0.7
        
        cocktailImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(80)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cocktailImage.snp.trailing).offset(20)
            $0.bottom.equalTo(cocktailImage.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        ingredientCountLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }

    func configure(data: Cocktail) {
        nameLabel.text = data.name
        ingredientCountLabel.text = "필요한 재료 \(data.ingredients.count)개"
        //이미지를 어떻게 해야하나 고민중, URL 추가해서 다 넣어줘야하나? 에반데
        cocktailImage.image = UIImage(named: "cocktail-glass")
    }
}
