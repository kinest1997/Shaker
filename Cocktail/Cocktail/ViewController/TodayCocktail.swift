import UIKit
import SnapKit

class TodayCocktailViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let firstButton = UIButton()
    let secondButton = UIButton()
    let thirdButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        let nextPage = UIAction(handler: { _ in
            print("이게뭐고")
        })
        firstButton.addAction(nextPage, for: .touchUpInside)
        mainScrollView.backgroundColor = .systemGray
        mainView.backgroundColor = .systemGray4
        firstButton.backgroundColor = .systemBlue
    }
    
    func layout() {
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(firstButton)
        firstButton.snp.makeConstraints {
            $0.center.equalTo(mainView)
            $0.width.height.equalTo(100)
        }
        mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.height.equalTo(2000)
        }
        mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
