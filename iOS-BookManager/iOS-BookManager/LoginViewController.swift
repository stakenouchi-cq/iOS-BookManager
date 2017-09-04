import UIKit
import APIKit
import Himotoki

class LoginViewController: UIViewController {
    
    let mailAddressLabel = UILabel()
    let mailAddressTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white // これで背景が白色に
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.booklineup()
        
        loginButton.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside) // ログインボタン押下時の動作
        
        setTextViewRules() // TextViewの入力ルールを制定
        setLoginViewLayout() // レイアウトの定義
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tappedLoginButton(sender: UIButton) {
        print("ログイン開始します")
        UIApplication.shared.keyWindow?.rootViewController = TabBarController()
    }
    
    // キーボード入力の終了ルールを定義
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func setTextViewRules() {
        // 各TextFieldの移譲
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
        // フォームの初期値をセット
        mailAddressTextField.text = ""
        passwordTextField.text = ""
        // 入力フォームの自動補完およびShiftキーを無効化
        mailAddressTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        mailAddressTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        mailAddressTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
    }
}

extension LoginViewController {
    func setLoginViewLayout() {
        mailAddressTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        passwordTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        
        self.view.addSubview(mailAddressLabel)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(mailAddressTextField)
        self.view.addSubview(passwordTextField)
        
        mailAddressLabel.text = R.string.localizable.mailaddress()
        passwordLabel.text = R.string.localizable.password()
        mailAddressLabel.sizeToFit()
        passwordLabel.sizeToFit()
        mailAddressTextField.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField.borderStyle = UITextBorderStyle.roundedRect
        mailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        mailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        
        // アドレスと入力フォーム類の位置設定
        mailAddressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        mailAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200.0).isActive = true
        mailAddressTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        mailAddressTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225.0).isActive = true
        mailAddressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 325.0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        // ボタン通常時の処理
        loginButton.setTitle(R.string.localizable.login(), for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        // ボタン押下時の処理
        loginButton.setTitle(R.string.localizable.login(), for: .highlighted)
        
        loginButton.backgroundColor = UIColor.blue // 背景色
        loginButton.layer.borderWidth = 2.0 // 枠線の幅
        loginButton.layer.borderColor = UIColor.black.cgColor // 枠線の色
        loginButton.layer.cornerRadius = 10.0 // 角丸のサイズ
        loginButton.sizeToFit()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        
        // ログインボタンの位置を定義
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450.0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
}
