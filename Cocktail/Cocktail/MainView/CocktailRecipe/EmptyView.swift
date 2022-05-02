//
//  EmptyCell.swift
//  Cocktail
//
//  Created by 강희성 on 2022/02/26.
//

import UIKit
import SnapKit

/// 검색된 레시피가 없을떄 보여주는 뷰
final class EmptyView: UIView {
    
    typealias TitleAndBody = (String, String)
    
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
        
        firstLabel.text = "There's no cocktail added".localized
        secondLabel.text = "Please add some cocktails".localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(_ titleAndBody: TitleAndBody) {
        firstLabel.text = titleAndBody.0
        secondLabel.text = titleAndBody.1
    }
}
