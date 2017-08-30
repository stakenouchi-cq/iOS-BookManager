import UIKit

class SettingViewController: UIViewController, UITabBarDelegate {
    
    var gotoSettingButton: UIButton!
    var myTabBar: UITabBar!
    let tabBarHeight: CGFloat = 49
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        let navigationBarTiltle = NSLocalizedString("setting", comment: "")
        self.navigationItem.title = navigationBarTiltle
        
        self.view.backgroundColor = UIColor.white
        
        // 左上部の戻るボタンを非表示
        self.navigationItem.hidesBackButton = false
        
        gotoSettingButton = UIButton()
        gotoSettingButton.translatesAutoresizingMaskIntoConstraints = false
        gotoSettingButton.frame = CGRect(x: 0, y: 0, width: displayWidth-tabBarHeight, height: 50)
        
        let accountSettingTiltle = NSLocalizedString("accountsetting", comment: "")
        
        gotoSettingButton.setTitle(accountSettingTiltle, for: .normal)
        gotoSettingButton.setTitleColor(UIColor.white, for: .normal)
        gotoSettingButton.backgroundColor = UIColor.blue // 背景色
        gotoSettingButton.layer.borderWidth = 2.0 // 枠線の幅
        gotoSettingButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        // ボタン押下時の処理
        gotoSettingButton.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        gotoSettingButton.tag = 0
        self.view.addSubview(gotoSettingButton)
        
        gotoSettingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        gotoSettingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        gotoSettingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func onClick(sender: UIButton){
        switch sender.tag {
        case 0:
            print("アカウント設定画面に入ります")
            touchAccountSettingButton()
        default:
            break
        }
    }
    
    func touchAccountSettingButton(){
        let accountSettingModalView = AccountSettingModalViewController()
        let navi = UINavigationController(rootViewController: accountSettingModalView) // モーダル画面でもナビゲーションバーが出るようにする
        print("アカウント設定のモーダル画面をopen")
        accountSettingModalView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
