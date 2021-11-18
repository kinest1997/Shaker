import UIKit
import SnapKit

class FilteredView: UIView {
    
    let mainView = UITableView()
    var isOn: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainView)
        self.mainView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//extension FilteredView: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        4
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 1:
//            return Cocktail.Base.allCases.count
//        default:
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterViewCell else { return UITableViewCell()}
//        cell.accessoryType = .checkmark
//
//
//        return cell
//    }
//
//}
// 다른 화면에서도 재활용?
