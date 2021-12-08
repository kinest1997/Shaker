//
//  TodayCocktailCollectionViewHeader.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit

class TodayCocktailCollectionViewHeader: UICollectionReusableView {
    
    let sectionTextLabel = UILabel()
    
    let seeTotalButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionTextLabel.textColor = .black
        sectionTextLabel.sizeToFit()
        
        seeTotalButton.setTitle("전체보기안됨", for: .normal)
        seeTotalButton.setTitleColor(.darkGray, for: .normal)
        seeTotalButton.titleLabel?.font = .systemFont(ofSize: 10)
        
        addSubview(sectionTextLabel)
        addSubview(seeTotalButton)
        sectionTextLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(5)
            $0.trailing.equalTo(seeTotalButton.snp.leading)
        }
        seeTotalButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
}
