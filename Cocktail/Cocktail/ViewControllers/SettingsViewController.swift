import UIKit
import SnapKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    let mainStackView = UIStackView()
    let mainView = UIView()
    
    let logOutButton = UIButton()
    
    //생각중인것, 내 술장 백업하기, 내술장 리셋하기, 내 술장 불러오기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        attribute()
        layout()
    }
    
    func attribute() {
        logOutButton.backgroundColor = .blue
        logOutButton.addAction(UIAction(handler: {[weak self]_ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                UserFavor.shared.firstLogin = true
                let loginViewController = LoginViewController()
                loginViewController.modalPresentationStyle = .overFullScreen
                self?.tabBarController?.show(loginViewController, sender: nil)
            } catch let error {
                print(error)
            }
        }), for: .touchUpInside)
    }
    func layout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(logOutButton)
        mainView.addSubview(mainStackView)
        mainScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.height.equalToSuperview()
        }
        
        logOutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }
}
