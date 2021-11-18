import UIKit
import SnapKit

class FilterViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()

        }
    }
    
}
