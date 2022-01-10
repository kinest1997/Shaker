//
//  SettingCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/04.
//

import Foundation
import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    
    let mainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainLabel)
        mainLabel.font = .nexonFont(ofSize: 16, weight: .semibold)
        mainLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
    }
}
