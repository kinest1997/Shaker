import UIKit
import SnapKit

class AddRecipeCell: UITableViewCell {
    
    let numberLabel = UILabel()
    var explainTextField = UITextField()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(numberLabel)
        contentView.addSubview(explainTextField)
        
        explainTextField.placeholder = "Input Recipes".localized
        numberLabel.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        explainTextField.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(numberLabel.snp.trailing)
        }
    }
}
