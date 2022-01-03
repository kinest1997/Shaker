import UIKit
import SnapKit
import Lottie

class LoadingView: UIView {
    
    let explainLabel = UILabel()
    
    let animationView = AnimationView(name: "LoadingAnimation")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(explainLabel)
        self.addSubview(animationView)

        animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFit
        animationView.play(fromFrame: 0, toFrame: 120, loopMode: .loop , completion: nil)
        
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        
        self.addSubview(explainLabel)
        explainLabel.textColor = .black
        explainLabel.font = .nexonFont(ofSize: 24, weight: .bold)
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
