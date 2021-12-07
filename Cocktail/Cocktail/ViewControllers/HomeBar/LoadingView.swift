import UIKit
import SnapKit
import Lottie

class LoadingView: UIViewController {
    
    let explainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "LoadingAnimation")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.play(fromFrame: 0, toFrame: 120, loopMode: .loop , completion: nil)
        
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        
        view.addSubview(explainLabel)
        explainLabel.textColor = .black
        explainLabel.textAlignment = .center
        
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(20)
            $0.width.equalTo(animationView)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
