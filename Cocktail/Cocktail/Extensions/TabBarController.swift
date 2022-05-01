import UIKit

extension UIViewController {
    /// 탭바에서 특정 뷰컨트롤러로 이동시켜준다
    func goToViewController(number: Int, viewController: UIViewController) {
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[number]
        self.tabBarController?.viewControllers?[number].show(viewController, sender:  nil)
    }
}
