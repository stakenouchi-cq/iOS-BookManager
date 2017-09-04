import UIKit
import APIKit
import Himotoki

class AccountSettingViewController: UIViewController, UITextFieldDelegate {
    
    let mailAddressLabel = UILabel()
    let mailAddressTextField = UITextField()
    let passwordLabel1 = UILabel() // パスワード(再入力じゃない方)
    let passwordTextField1 = UITextField()
    let passwordLabel2 = UILabel() // パスワード(再入力)
    let passwordTextField2 = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.accountsetting()
        
        // ナビゲーションバーに表示するボタンの設定
        let closeButton = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: #selector(buttonTapped(sender:)))
        closeButton.tag = ButtonTags.close.rawValue
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        let saveButton = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: #selector(buttonTapped(sender:)))
        saveButton.tag = ButtonTags.save.rawValue
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        // ラベルの設定
        mailAddressLabel.text = R.string.localizable.mailaddress()
        passwordLabel1.text = R.string.localizable.password()
        passwordLabel2.text = R.string.localizable.accpassword()
        
        
        // 入力フォームの自動補完およびShiftキーを無効化
        mailAddressTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField1.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField2.autocapitalizationType = UITextAutocapitalizationType.none
        mailAddressTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField1.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField2.autocorrectionType = UITextAutocorrectionType.no
        
        // パスワードは，入力文字を●で隠す
        passwordTextField1.isSecureTextEntry = true
        passwordTextField2.isSecureTextEntry = true
        
        // 各フォームの初期値を設定．
        mailAddressTextField.text = ""
        passwordTextField1.text = ""
        passwordTextField2.text = ""
        
        mailAddressTextField.delegate = self as? UITextFieldDelegate
        passwordTextField1.delegate = self as? UITextFieldDelegate
        passwordTextField2.delegate = self as? UITextFieldDelegate
        
        setAccountSettingViewLayout()
        
    }
    
    // ボタン押下時の分岐
    func buttonTapped(sender: UIButton) {
        var btag = ButtonTags(rawValue: sender.tag)!
        switch btag {
        case .close:
            print("アカウント設定画面を閉じます")
            self.dismiss(animated: true, completion: nil)
        case .save:
            print("アカウント情報を保存します")
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AccountSettingViewController {
    
    // アドレスと入力フォーム類の位置設定
    func setAccountSettingViewLayout() {
        mailAddressLabel.sizeToFit()
        passwordLabel1.sizeToFit()
        passwordLabel2.sizeToFit()
        
        // メールアドレスとパスワードのフォームのサイズを設定
        mailAddressTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        passwordTextField1.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        passwordTextField2.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        
        // フォームの枠を丸枠にする
        mailAddressTextField.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField1.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField2.borderStyle = UITextBorderStyle.roundedRect
        mailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel1.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel2.translatesAutoresizingMaskIntoConstraints = false
        mailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField1.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField2.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mailAddressLabel)
        self.view.addSubview(passwordLabel1)
        self.view.addSubview(passwordLabel2)
        self.view.addSubview(mailAddressTextField)
        self.view.addSubview(passwordTextField1)
        self.view.addSubview(passwordTextField2)
        
        let marginBtwLabTextField: CGFloat = 5.0
        let marginBtwLabels: CGFloat = self.view.frame.height*0.1
        
        // メールアドレス
        mailAddressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mailAddressLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        mailAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (5/30)*self.view.frame.height).isActive = true
        mailAddressTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mailAddressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        mailAddressTextField.topAnchor.constraint(equalTo: mailAddressLabel.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        // パスワード(入力1回目)
        passwordLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordLabel1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordLabel1.topAnchor.constraint(equalTo: mailAddressLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        passwordTextField1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField1.topAnchor.constraint(equalTo: passwordLabel1.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        // パスワード(入力2回目)
        passwordLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordLabel2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordLabel2.topAnchor.constraint(equalTo: passwordLabel1.bottomAnchor, constant: marginBtwLabels).isActive = true
        passwordTextField2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField2.topAnchor.constraint(equalTo: passwordLabel2.bottomAnchor, constant: marginBtwLabTextField).isActive = true
    }
    
}
