import UIKit
import SnapKit
import Lottie

class LoadingView: UIView {
    
    let explainLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(explainLabel)
        let animationView = AnimationView(name: "LoadingAnimation")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        
        self.addSubview(animationView)
        
        animationView.play(fromFrame: 0, toFrame: 120, loopMode: .loop , completion: nil)
        
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        
        self.addSubview(explainLabel)
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
