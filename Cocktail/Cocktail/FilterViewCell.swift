import UIKit
import SnapKit

class FilterViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let mainStackView = UIStackView()
    let appliedCheckImgageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(appliedCheckImgageView)
        nameLabel.textAlignment = .left
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
