import UIKit
import SnapKit

class WhatIHaveCollectionViewCell: UICollectionViewCell{
    let mainImageView = UIImageView()
    let nameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemRed
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        mainImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(nameLabel)
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
