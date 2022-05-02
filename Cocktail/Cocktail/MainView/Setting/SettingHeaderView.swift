//
//  SettingHeaderView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/04.
//

import UIKit
import SnapKit

final class SettingHeaderView: UITableViewHeaderFooterView {
    let mainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
