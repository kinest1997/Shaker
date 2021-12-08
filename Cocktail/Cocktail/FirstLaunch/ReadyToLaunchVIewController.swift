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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let loadingView = LoadingView()
//        loadingView.modalPresentationStyle = .overCurrentContext
//        loadingView.modalTransitionStyle = .crossDissolve
//        loadingView.explainLabel.text = "로딩중"
//        self.present(loadingView, animated: true)
//        FirebaseRecipe.shared.getRecipe { data in
//            FirebaseRecipe.shared.recipe = data
//            FirebaseRecipe.shared.getMyRecipe { data in
//                FirebaseRecipe.shared.myRecipe = data
//                FirebaseRecipe.shared.getWishList { data in
//                    FirebaseRecipe.shared.wishList = data
//                }
//            }
//            loadingView.dismiss(animated: true)
//        }
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        nextButton.addAction(UIAction(handler: {[weak self] _ in
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            window?.rootViewController = MainViewController()
            
//            self?.tabBarController?.tabBar.isHidden = false
//            self?.navigationController?.popToRootViewController(animated: true)
        }), for: .touchUpInside)
        nextButton.setTitle("시작하기", for: .normal)
        nextButton.backgroundColor = .brown
        
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
            $0.bottom.equalToSuperview().offset(-180)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
    }
}
