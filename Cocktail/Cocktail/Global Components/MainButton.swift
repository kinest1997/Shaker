//
//  mainButton.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/24.
//

import UIKit
import SnapKit

class MainButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(70)
        }
        self.setTitleColor(.mainGray, for: .normal)
        self.titleLabel?.font = .nexonFont(ofSize: 18, weight: .bold)
        self.layer.borderColor = UIColor.borderGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 35
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
