//
//  TitleHeaderView.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/31.
//
import UIKit
import SnapKit

class TitleHeaderView: UICollectionReusableView {
    
    let sectionTextLabel = UILabel()
    
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(sectionTextLabel)
        addSubview(titleLabel)
        self.backgroundColor = .white
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(45)
        }
        titleLabel.text = "SHAKER"
        titleLabel.font = .nexonFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .black

        sectionTextLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        titleLabel.sizeToFit()
        sectionTextLabel.sizeToFit()
    }
}
