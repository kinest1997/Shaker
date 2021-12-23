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
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 3
        self.clipsToBounds = true
        self.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
