//
//  AssistantCustomButton.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import UIKit
import SnapKit

final class AssistantCell: UITableViewCell {
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let explainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [mainImageView, titleLabel, explainLabel].forEach {
            contentView.addSubview($0)
        }
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        contentView.backgroundColor = .splitLineGray
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.backgroundColor = .clear
        mainImageView.layer.cornerRadius = 15
        mainImageView.clipsToBounds = true
        mainImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(80)
            $0.leading.equalToSuperview().offset(10)
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
        titleLabel.backgroundColor = .clear
        titleLabel.font = .nexonFont(ofSize: 20, weight: .bold)
        
        explainLabel.backgroundColor = .clear
        explainLabel.textColor = .mainGray
        explainLabel.font = .nexonFont(ofSize: 12, weight: .semibold)
        explainLabel.numberOfLines = 0
    }
}
