import UIKit

class SettingViewController: UIViewController {
    
    fileprivate let gotoSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.accountsetting(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "gotoAccountSetting", for: .touchUpInside) // ログインボタン押下時の動作
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.setting()
        
        setSettingViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("email: \(UserDefaults.standard.string(forKey: "email")!)")
        print("token: \(UserDefaults.standard.string(forKey: "token")!)")
    }
    
    func gotoAccountSetting() {
        let accountSettingViewController = AccountSettingViewController()
        let navi = UINavigationController(rootViewController: accountSettingViewController) // モーダル画面でもナビゲーションバーが出るようにする
        print("Open account setting screen")
        accountSettingViewController.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SettingViewController {

    fileprivate func setSettingViewLayout() {
        self.view.addSubview(gotoSettingButton)
        gotoSettingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        gotoSettingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        gotoSettingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
}
