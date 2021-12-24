import UIKit
import SnapKit

class ReadyToLaunchVIewController: UIViewController {
    
    let mainViewController = MainViewController()
    
    let startTextLabel = UILabel()
    let nextButton = MainButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.rootViewController = self?.mainViewController
        }), for: .touchUpInside)
        nextButton.setTitle("시작하기", for: .normal)
        
        startTextLabel.text = "쉐이커를 시작할 준비가 다 되었습니다"
        startTextLabel.textAlignment = .center
        startTextLabel.numberOfLines = 0
        startTextLabel.textColor = .black
    }
    
    func layout() {
        [startTextLabel, nextButton].forEach { view.addSubview($0) }
        startTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
}