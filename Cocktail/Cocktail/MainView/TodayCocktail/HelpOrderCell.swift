//
//  HelpOrderCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import UIKit
import SnapKit

class HelpOrderCell: UICollectionViewCell {
    
    let mainImageView = UIImageView()
    
    let questionLabel = UILabel()
    
    let explainLabel = UILabel()
    
    let orderLabel = UILabel()
    
    let disclosureImageView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        [mainImageView, questionLabel, explainLabel, orderLabel, disclosureImageView].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .white
        [questionLabel, explainLabel, orderLabel].forEach {
            $0.textAlignment = .center
        }
        mainImageView.image = UIImage(systemName: "menucard")
        mainImageView.tintColor = .mainOrange
        
        mainImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalTo(mainImageView.snp.height)
        }
        
        questionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainImageView.snp.bottom).offset(15)
        }
        
        explainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questionLabel.snp.bottom).offset(5)
        }
        
        orderLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        disclosureImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(orderLabel)
            $0.leading.equalTo(orderLabel.snp.trailing)
            $0.height.width.equalTo(15)
        }
        
        disclosureImageView.image = UIImage(systemName: "chevron.right")
        disclosureImageView.tintColor = .mainGray
        orderLabel.textColor = .mainGray
        orderLabel.text = "주문하러 가기"
        orderLabel.font = .nexonFont(ofSize: 12, weight: .bold)
        
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
}
