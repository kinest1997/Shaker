import UIKit
import SnapKit

class WhatIHaveCollectionViewCell: UICollectionViewCell{
    typealias CellData = (title: String, checked: Bool)
    
    let mainImageView = UIImageView()
    let nameLabel = UILabel()
    var checkBoxImage = UIImageView()
    let mainView = UIView()
    
    var isChecked = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.contentMode = .scaleAspectFit
        nameLabel.numberOfLines = 0
        [mainImageView, nameLabel, checkBoxImage].forEach {
            contentView.addSubview($0)
        }
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        nameLabel.font = .nexonFont(ofSize: 15, weight: .semibold)
        nameLabel.textAlignment = .center
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.splitLineGray.cgColor
        
        mainImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(5)
            $0.centerX.equalTo(mainImageView)
        }
        checkBoxImage.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(5)
            $0.height.width.equalTo(30)
        }
        checkBoxImage.tintColor = .mainOrange
    }
    
    func setImage(bool: Bool) {
        self.checkBoxImage.image = UIImage(systemName: bool ? "checkmark.circle.fill" : "checkmark.circle")
    }
}
