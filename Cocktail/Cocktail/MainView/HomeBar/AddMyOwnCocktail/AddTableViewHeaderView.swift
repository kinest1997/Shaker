//
//  AddTableViewHeaderView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/02.
//

import Foundation
import UIKit
import SnapKit

class AddTableViewHeaderView: UITableViewHeaderFooterView {

    let titleLabel = UILabel()
    let topSplitLine = UILabel()
    let showButton = UIButton()
    var isIngredients = false

    override func layoutSubviews() {
        super.layoutSubviews()
        [titleLabel, topSplitLine, showButton].forEach {
            contentView.addSubview($0)
        }
        titleLabel.font = .nexonFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .mainGray
        titleLabel.textAlignment = .right

        [showButton].forEach {
            $0.isHidden = !isIngredients
        }
        showButton.setTitleColor(.black, for: .normal)
        showButton.setImage(UIImage(systemName: "increase.indent"), for: .normal)
        showButton.tintColor = .mainGray
        topSplitLine.backgroundColor = .tappedOrange

        topSplitLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }

        showButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(showButton.snp.height)
            $0.trailing.equalToSuperview().offset(-50)
        }
    }
}
