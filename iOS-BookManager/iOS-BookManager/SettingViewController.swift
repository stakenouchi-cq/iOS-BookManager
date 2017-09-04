import UIKit

class SettingViewController: UIViewController {
    
    var gotoSettingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.setting()
        
        // 左上部の戻るボタンを非表示
        self.navigationItem.hidesBackButton = false
        gotoSettingButton.tag = ButtonTags.setting.rawValue
        
        setSettingViewLayout()
    }
    
    func buttonTapped(sender: UIButton) {
        var btag = ButtonTags(rawValue: sender.tag)!
        switch btag {
        case .setting:
            print("アカウント設定画面に入ります")
            touchAccountSettingButton()
        default:
            break
        }
    }
    
    func touchAccountSettingButton() {
        let accountSettingViewController = AccountSettingViewController()
        let navi = UINavigationController(rootViewController: accountSettingViewController) // モーダル画面でもナビゲーションバーが出るようにする
        print("アカウント設定のモーダル画面をopen")
        accountSettingViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SettingViewController {

    func setSettingViewLayout() {
        let tabBarHeight: CGFloat = 49
        self.view.addSubview(gotoSettingButton)
        gotoSettingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        gotoSettingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        gotoSettingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        gotoSettingButton.translatesAutoresizingMaskIntoConstraints = false
        gotoSettingButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-tabBarHeight, height: 50)
        
        gotoSettingButton.setTitle(R.string.localizable.accountsetting(), for: .normal)
        gotoSettingButton.setTitleColor(UIColor.white, for: .normal)
        gotoSettingButton.backgroundColor = UIColor.blue // 背景色
        gotoSettingButton.layer.borderWidth = 2.0 // 枠線の幅
        gotoSettingButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        // ボタン押下時の処理
        gotoSettingButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
}
