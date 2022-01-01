//
//  BaseChoiceCollectionViewcell.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/31.
//

import Foundation
import UIKit
import SnapKit

class BaseChoiceCollectionViewCell: UICollectionViewCell {
    
    let mainImageView = UIImageView()
    let mainLabel = UILabel()
    
    var isChecked = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainImageView)
        contentView.addSubview(mainLabel)
        
        [mainLabel, contentView].forEach {
            $0.backgroundColor = isChecked ? UIColor(named: "mainOrangeColor") : .white
        }
        
        mainLabel.backgroundColor = isChecked ? UIColor(named: "mainOrangeColor") : .white
        
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        mainLabel.layer.cornerRadius = 20
        
        mainLabel.layer.borderWidth = 2
        mainLabel.layer.borderColor = UIColor.red.cgColor
        mainLabel.layer.shadowOpacity = 1
        mainLabel.layer.shadowColor = UIColor.black.cgColor
        mainLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainLabel.layer.shadowRadius = 10

        mainLabel.layer.masksToBounds = false
        
//        mainLabel.layer.cornerRadius = 15
//        mainLabel.backgroundColor = .white
        mainLabel.clipsToBounds = true
////        mainLabel.setTitleColor(.black, for: .normal)
//        mainLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        mainLabel.layer.shadowColor = UIColor.black.cgColor
//        mainLabel.layer.masksToBounds = false
//        mainLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
//        mainLabel.layer.shadowRadius = 5
//        mainLabel.layer.shadowOpacity = 0.4
        
    }
    
    func setData(text: String, image: UIImage) {
        mainLabel.text = text
        mainImageView.image = image
    }
}


