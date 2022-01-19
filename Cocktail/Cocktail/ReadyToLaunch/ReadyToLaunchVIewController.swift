import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol ReadyToLaunchViewBindable {
    //View -> ViewModel
    var readytoLaunchButtonTapped: PublishRelay<Void> { get }
    
    //ViewModel -> View
    var showNextPage: Signal<Void> { get}
}

class ReadyToLaunchViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let mainViewController = MainViewController()
    
    let startTextLabel = UILabel()
    let nextButton = MainButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func bind(_ viewModel: ReadyToLaunchViewBindable) {
        nextButton.rx.tap
            .bind(to: viewModel.readytoLaunchButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.showNextPage
            .emit { [weak self] _ in
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                window?.rootViewController = self?.mainViewController
            }
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        nextButton.setTitle("Start".localized, for: .normal)
        nextButton.backgroundColor = .tappedOrange
        
        let originText = "Ready to launch Shaker".localized
        
        if NSLocale.current.languageCode == "ko" {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 3, length: 17), bigFont: UIFont.nexonFont(ofSize: 40, weight: .bold), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 36, weight: .semibold), orangeRange: NSRange(location: 0, length: 3))
            startTextLabel.attributedText = questionText
        } else {
            let questionText = NSMutableAttributedString.addBigOrangeText(text: originText, firstRange: NSRange(location: 0, length: 16), bigFont: UIFont.nexonFont(ofSize: 40, weight: .bold), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 36, weight: .semibold), orangeRange: NSRange(location: 16, length: 6))
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
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
}
