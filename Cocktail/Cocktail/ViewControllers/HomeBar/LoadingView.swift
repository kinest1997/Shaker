import UIKit
import NVActivityIndicatorView
import SnapKit


class LoadingView: UIViewController {
    
    var activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 10, y: 10, width: 10, height: 10), type: NVActivityIndicatorType.ballTrianglePath, color: .black, padding: 0.1)
    
    let explainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        
        view.addSubview(explainLabel)
        view.addSubview(activityIndicator)
        explainLabel.textColor = .black
        explainLabel.textAlignment = .center
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(60)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(20)
            $0.width.equalTo(activityIndicator)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
