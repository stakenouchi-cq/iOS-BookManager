import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookLineUpViewController = BookLineUpViewController()
        let settingViewController = SettingViewController()
        
        let navigationController1 = UINavigationController(rootViewController: bookLineUpViewController)
        let navigationController2 = UINavigationController(rootViewController: settingViewController)
        
        bookLineUpViewController.title = R.string.localizable.booklineup()
        settingViewController.title = R.string.localizable.setting()
        
        self.delegate = self
        self.viewControllers = [navigationController1, navigationController2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
