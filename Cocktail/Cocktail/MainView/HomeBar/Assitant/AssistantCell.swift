//
//  AssistantCustomButton.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import Foundation
import UIKit
import SnapKit

class AssistantCell: UITableViewCell {
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let explainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [mainImageView, titleLabel, explainLabel].forEach {
            contentView.addSubview($0)
        }
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        contentView.backgroundColor = UIColor(named: "splitLineGray")
        contentView.cornerRadius = 15
        contentView.clipsToBounds = true
//        contentView.layer.borderColor = UIColor.splitLineGray.cgColor
//        contentView.layer.borderWidth = 1
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(20)
            $0.height.equalTo(mainImageView).multipliedBy(0.5)
            $0.top.equalTo(mainImageView)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(200)
        }
        
        titleLabel.textColor = .mainGray
        titleLabel.font = .nexonFont(ofSize: 20, weight: .bold)
        
        explainLabel.textColor = .mainGray
        explainLabel.font = .nexonFont(ofSize: 12, weight: .semibold)
        explainLabel.numberOfLines = 0
    }
}
