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
        
        appliedCheckImgageView.tintColor = .black
        nameLabel.textAlignment = .left
        appliedCheckImgageView.image = isChecked ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        appliedCheckImgageView.snp.makeConstraints {
            $0.height.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(appliedCheckImgageView.snp.height)
        }
    }
    func imageApply() {
        if isChecked {
            appliedCheckImgageView.image = UIImage(systemName: "checkmark.circle")
        } else {
            appliedCheckImgageView.image = UIImage(systemName: "circle")
        }
    }
}
