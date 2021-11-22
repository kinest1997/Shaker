import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    let mainStackView = UIStackView()
    let mainView = UIView()
    
    //생각중인것, 내 술장 백업하기, 내술장 리셋하기, 내 술장 불러오기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        attribute()
        layout()
    }
    
    func attribute() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(mainStackView)
    }
    func layout() {
        mainScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
