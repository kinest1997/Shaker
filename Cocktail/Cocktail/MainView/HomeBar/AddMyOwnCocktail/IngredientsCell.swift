//
//  IngredientsCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import Foundation
import UIKit
import SnapKit

class IngredientsCell: UITableViewCell {

    let mainLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(mainLabel)
        contentView.backgroundColor = .splitLineGray
        mainLabel.textColor = .mainGray
        mainLabel.font = .nexonFont(ofSize: 14, weight: .medium)
        mainLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
        }

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30))
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
}
