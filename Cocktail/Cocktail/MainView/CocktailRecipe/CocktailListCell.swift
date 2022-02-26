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
    let disclosureMark = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        nameLabel.textColor = .mainGray
        ingredientCountLabel.textColor = .gray
        disclosureMark.tintColor = .mainGray
        
        [nameLabel, ingredientCountLabel, cocktailImageView, likeCount, disclosureMark].forEach {
            contentView.addSubview($0)
        }
        cocktailImageView.contentMode = .scaleAspectFit
        nameLabel.font = .nexonFont(ofSize: 18, weight: .bold)
        ingredientCountLabel.font = .nexonFont(ofSize: 15, weight: .medium)
        ingredientCountLabel.alpha = 0.7
        ingredientCountLabel.numberOfLines = 1

        likeCount.textColor = .white
        
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(cocktailImageView.snp.height)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
            $0.top.equalToSuperview().offset(20)
        }
        ingredientCountLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(disclosureMark.snp.leading).offset(-5)
        }
        likeCount.snp.makeConstraints {
            $0.leading.equalTo(ingredientCountLabel.snp.trailing)
            $0.width.equalTo(50)
            $0.height.bottom.equalToSuperview()
        }
        disclosureMark.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(data: Cocktail) {
        nameLabel.text = data.name
        var text = data.ingredients.reduce("") {
            $0 + $1.rawValue.localized + ", "
        }
        text.removeLast(2)
        ingredientCountLabel.text = text
        cocktailImageView.kf.setImage(with: URL(string: data.imageURL), placeholder: UIImage(named: "\(data.glass.rawValue)" + "Empty"))
    }
}

