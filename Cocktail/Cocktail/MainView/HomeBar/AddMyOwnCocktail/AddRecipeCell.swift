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
            $0.leading.equalToSuperview().offset(5)
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(30)
        }
        contentView.backgroundColor = UIColor(named: "splitLineGray")
        numberLabel.textColor = UIColor(named: "miniButtonGray")
        numberLabel.textAlignment = .center
        explainTextField.textColor = UIColor(named: "miniButtonGray")
        explainTextField.font = .systemFont(ofSize: 14, weight: .medium)
        
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30))
        contentView.cornerRadius = 15
        contentView.clipsToBounds = true
        
        
        explainTextField.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(numberLabel.snp.trailing)
        }
    }
}
