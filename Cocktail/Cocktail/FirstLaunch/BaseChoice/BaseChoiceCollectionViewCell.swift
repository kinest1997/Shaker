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
    
    let mainView = UIView()
    let mainLabel = UILabel()
    
    var isChecked = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainImageView)
        contentView.addSubview(mainView)
        mainView.addSubview(mainLabel)
        
        [mainLabel, contentView].forEach {
            $0.backgroundColor = isChecked ? UIColor(named: "mainOrangeColor") : .white
        }
        
        mainLabel.backgroundColor = isChecked ? UIColor(named: "mainOrangeColor") : .white
        
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        mainLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainLabel.font = .systemFont(ofSize: 18, weight: .bold)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .black
        
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        mainLabel.layer.cornerRadius = 15
        mainLabel.clipsToBounds = true
    }
    
    func setData(text: String, image: UIImage) {
        mainLabel.text = text
        mainImageView.image = image
    }
}


