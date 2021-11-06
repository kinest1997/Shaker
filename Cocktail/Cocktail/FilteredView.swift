import UIKit
import SnapKit

class FilteredView: UIView {
    
    var isOn: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 다른 화면에서도 재활용?
