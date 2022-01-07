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
    
    let titleLabel = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(sectionTextLabel)
        addSubview(titleLabel)
        self.backgroundColor = .white
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.bottom.equalTo(sectionTextLabel.snp.top)
        }
        titleLabel.image = UIImage(named: "TitleImage")
        titleLabel.contentMode = .scaleAspectFit
        sectionTextLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(25)
        }
        sectionTextLabel.sizeToFit()
    }
}
