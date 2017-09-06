import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookLineUpViewController = BookLineUpViewController()
        let settingViewController = SettingViewController()
        
        bookLineUpViewController.title = R.string.localizable.booklineup()
        settingViewController.title = R.string.localizable.setting()
        
        let navigationControllerLeft = UINavigationController(rootViewController: bookLineUpViewController)
        let navigationControllerRight = UINavigationController(rootViewController: settingViewController)
        
        self.delegate = self
        self.viewControllers = [navigationControllerLeft, navigationControllerRight]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
