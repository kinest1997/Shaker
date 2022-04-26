//
//  ButtonHeaderView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/05.
//

import UIKit
import SnapKit

class ButtonFooterView: UICollectionReusableView {

    let bottomButton = UIButton()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(bottomButton)
        bottomButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        bottomButton.titleLabel?.font = .nexonFont(ofSize: 14, weight: .semibold)
        bottomButton.setTitle("SeeAll".localized + " >", for: .normal)
        bottomButton.setTitleColor(.mainGray, for: .normal)
    }
}
