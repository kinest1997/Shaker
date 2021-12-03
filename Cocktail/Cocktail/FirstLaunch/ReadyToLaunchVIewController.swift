import UIKit
import SnapKit

class ReadyToLaunchVIewController: UIViewController {
    
    let startTextLabel = UILabel()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        
        
    }
    
    func layout() {
        [startTextLabel, nextButton].forEach { view.addSubview($0) }
        startTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.eq
        }
    }
    
}

