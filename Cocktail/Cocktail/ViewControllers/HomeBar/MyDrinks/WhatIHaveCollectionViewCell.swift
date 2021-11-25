import UIKit
import SnapKit

class WhatIHaveCollectionViewCell: UICollectionViewCell{
    let mainImageView = UIImageView()
    let nameLabel = UILabel()
    var checkBoxImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemRed
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        mainImageView.contentMode = .scaleAspectFill
        nameLabel.numberOfLines = 0
        contentView.addSubview(mainImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(checkBoxImage)
        nameLabel.font = .systemFont(ofSize: 15)
        
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
        checkBoxImage.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.width.equalTo(30)
        }
    }
}
