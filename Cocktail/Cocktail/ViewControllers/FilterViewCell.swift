import UIKit
import SnapKit

class FilterViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let mainStackView = UIStackView()
    let appliedCheckImgageView = UIImageView()
    var isChecked: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(appliedCheckImgageView)
        nameLabel.textAlignment = .left
//        imageApply()
        appliedCheckImgageView.image = isChecked ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
