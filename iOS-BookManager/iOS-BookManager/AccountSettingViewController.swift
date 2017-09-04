import UIKit
import APIKit
import Himotoki

class AccountSettingViewController: UIViewController, UITextFieldDelegate {
    
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
    
    fileprivate let passwordConfirmLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.passwordconfirm()
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
    
    fileprivate lazy var passwordConfirmTextField: UITextField = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white // これで背景が白色に
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.accountsetting()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: "saveAccountData")
        
        setLoginViewLayout() // レイアウトの定義
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tappedLoginButton(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = TabBarController()
    }
    
    func closeView() {
        print("Close add book screen.")
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveAccountData() {
        print("Account data is saved.")
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

extension AccountSettingViewController {
    fileprivate func setLoginViewLayout() {
        self.view.addSubview(mailAddressLabel)
        self.view.addSubview(mailAddressTextField)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordConfirmLabel)
        self.view.addSubview(passwordConfirmTextField)
        
        let marginBtwLabForm = CGFloat(30.0)
        let marginBtwLabels = CGFloat(self.view.frame.height*0.16)
        // アドレスと入力フォーム類の位置設定
        mailAddressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        mailAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150.0).isActive = true
        mailAddressTextField.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        mailAddressTextField.centerYAnchor.constraint(equalTo: mailAddressLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        mailAddressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: mailAddressLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: mailAddressTextField.widthAnchor).isActive = true
        passwordConfirmLabel.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordConfirmLabel.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor, constant: 65.0).isActive = true
        passwordConfirmTextField.leadingAnchor.constraint(equalTo: mailAddressLabel.leadingAnchor).isActive = true
        passwordConfirmTextField.centerYAnchor.constraint(equalTo: passwordConfirmLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        passwordConfirmTextField.widthAnchor.constraint(equalTo: mailAddressTextField.widthAnchor).isActive = true
    }
    
}
