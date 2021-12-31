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
        self.layer.cornerRadius = 35
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
        setTitleColor(UIColor(named: "miniButtonGray"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
