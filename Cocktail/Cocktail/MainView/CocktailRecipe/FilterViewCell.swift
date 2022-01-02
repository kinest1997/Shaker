import UIKit
import SnapKit

class FilterViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let appliedCheckImgageView = UIImageView()
    var isChecked: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(nameLabel)
        contentView.addSubview(appliedCheckImgageView)
        
        appliedCheckImgageView.tintColor = isChecked ? UIColor(named: "shaker") : UIColor(named: "miniButtonGray")
        nameLabel.textAlignment = .left
        appliedCheckImgageView.image = isChecked ? UIImage(systemName: "chevron.down.square.fill") : UIImage(systemName: "square")
        
        
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        appliedCheckImgageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(appliedCheckImgageView.snp.height)
        }
    }
    func imageApply() {
        if isChecked {
            appliedCheckImgageView.image = UIImage(systemName: "chevron.down.square.fill")
        } else {
            appliedCheckImgageView.image = UIImage(systemName: "square")
        }
    }
}
