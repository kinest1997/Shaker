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
        ingredientCountLabel.text = "Ingredients".localized + " \(data.ingredients.count)" + "EA".localized
        cocktailImage.image = UIImage(named: data.name)
        
        let imagePath = getImageDirectoryPath().appendingPathComponent(data.name + ".png").path
        if FileManager.default.fileExists(atPath: imagePath) {
            let GetImageFromDirectory = UIImage(contentsOfFile: imagePath)
            cocktailImage.image = GetImageFromDirectory
        }
    }
}
