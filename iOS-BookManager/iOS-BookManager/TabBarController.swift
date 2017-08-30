import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookLineUpViewController = BookLineUpViewController()
        let settingViewController = SettingViewController()
        
        let navigationController1 = UINavigationController(rootViewController: bookLineUpViewController)
        let navigationController2 = UINavigationController(rootViewController: settingViewController)
        
        let bookLineUpTitle = NSLocalizedString("booklineup", comment: "")
        let settingTitle = NSLocalizedString("setting", comment: "")
        
        bookLineUpViewController.title = bookLineUpTitle
        settingViewController.title = settingTitle
        self.delegate = self
        self.viewControllers = [navigationController1, navigationController2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
