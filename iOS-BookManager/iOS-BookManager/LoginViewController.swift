import UIKit
import APIKit
import Himotoki

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate let mailAddressLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.mailaddress()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.password()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var mailAddressTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    fileprivate lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.login(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10.0
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside) // ログインボタン押下時の動作
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white // これで背景が白色に
        // ナビゲーションバーの表示
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.booklineup()
        
        setLoginViewLayout() // レイアウトの定義
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tappedLoginButton(sender: UIButton) {
        let email: String = mailAddressTextField.text!
        let password: String = passwordTextField.text!
        
        print("ログイン開始します")
        let loginRequest = LoginRequest(email: email, password: password)
        
        Session.send(loginRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                UserDefaults.standard.set(response.id, forKey: "id")
                UserDefaults.standard.set(response.email, forKey: "email")
                UserDefaults.standard.set(response.token, forKey: "token")
                UIApplication.shared.keyWindow?.rootViewController = TabBarController()
            case .failure(let error):
                print(error)
            }
        }
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

extension LoginViewController {
    fileprivate func setLoginViewLayout() {
        self.view.addSubview(mailAddressLabel)
        self.view.addSubview(mailAddressTextField)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        
        let marginBtwLabForm = CGFloat(30.0)
        let marginBtwLabels = CGFloat(self.view.frame.height*0.1)
        
        // アドレスと入力フォーム類の位置設定
        mailAddressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        mailAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150.0).isActive = true
        mailAddressTextField.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        mailAddressTextField.centerYAnchor.constraint(equalTo: mailAddressLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        mailAddressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: mailAddressTextField.centerYAnchor, constant: marginBtwLabels).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: mailAddressTextField.widthAnchor).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: mailAddressTextField.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 100.0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: mailAddressTextField.widthAnchor).isActive = true
    }
    
}
