//
//  EmptyCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/02/26.
//

import Foundation
import UIKit
import SnapKit

class EmptyView: UIView {
    
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        [firstLabel, secondLabel].forEach {
            self.addSubview($0)
            $0.numberOfLines = 0
            $0.textColor = .borderGray
        }
        
        firstLabel.sizeToFit()
        firstLabel.font = .nexonFont(ofSize: 14, weight: .bold)
        secondLabel.font = .nexonFont(ofSize: 12, weight: .regular)
        
        firstLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}