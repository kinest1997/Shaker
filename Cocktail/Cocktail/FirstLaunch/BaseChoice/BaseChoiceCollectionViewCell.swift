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
            $0.backgroundColor = isChecked ? .tappedOrange : .white
        }
        
        mainLabel.backgroundColor = isChecked ? .tappedOrange : .white
        
        
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
        mainLabel.font = .nexonFont(ofSize: 18, weight: .bold)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .mainGray
        
        mainLabel.layer.cornerRadius = 15
        mainLabel.clipsToBounds = true
        mainLabel.layer.borderColor = UIColor.borderGray.cgColor
        mainLabel.layer.borderWidth = 1
    }
    
    func setData(text: String, image: UIImage) {
        mainLabel.text = text
        mainImageView.image = image
    }
}


