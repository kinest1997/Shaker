import UIKit

extension UIViewController {
    func goToViewController(number: Int, viewController: UIViewController) {
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[number]
        self.tabBarController?.viewControllers?[number].show(viewController, sender: nil)
    }
}
