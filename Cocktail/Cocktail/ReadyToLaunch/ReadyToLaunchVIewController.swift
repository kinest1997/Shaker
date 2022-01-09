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
        nextButton.setTitle("Start".localized, for: .normal)
        nextButton.backgroundColor = .tappedOrange
        
        let originText = "Ready to launch Shaker".localized
        
        if NSLocale.current.languageCode == "ko" {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 3, length: 17), bigFont: UIFont.nexonFont(ofSize: 40, weight: .bold), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 36, weight: .semibold), orangeRange: NSRange(location: 0, length: 3))
            startTextLabel.attributedText = questionText
        } else {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 21), bigFont: UIFont.nexonFont(ofSize: 40, weight: .bold), secondRange: NSRange(location: 26, length: 1), smallFont: UIFont.nexonFont(ofSize: 36, weight: .semibold), orangeRange: NSRange(location: 21, length: 5))
            startTextLabel.attributedText = questionText
        }
        
        startTextLabel.textAlignment = .center
        startTextLabel.numberOfLines = 0
    }
    
    func layout() {
        [startTextLabel, nextButton].forEach { view.addSubview($0) }
        startTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
//            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
}
