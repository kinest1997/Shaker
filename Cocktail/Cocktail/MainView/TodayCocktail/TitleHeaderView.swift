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
    let topSplitLine = UILabel()
    
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(sectionTextLabel)
        addSubview(titleLabel)
        addSubview(topSplitLine)
        
        topSplitLine.snp.makeConstraints {
            $0.top.equalTo(sectionTextLabel).offset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
            
        }
        topSplitLine.backgroundColor = UIColor(named: "selectedGray")
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(45)
        }
        titleLabel.text = "SHAKER"
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .black
        
        sectionTextLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        sectionTextLabel.snp.makeConstraints {
            //                $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        titleLabel.sizeToFit()
        sectionTextLabel.sizeToFit()
    }
}
