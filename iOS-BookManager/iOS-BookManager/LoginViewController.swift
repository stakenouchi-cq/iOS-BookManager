import UIKit

class LoginViewController: UIViewController, UITabBarDelegate, UITextFieldDelegate{
    
    // UI関連の変数定義
    let addressLabel = UILabel()
    @IBOutlet weak var addressTextField: UITextField!
    let passLabel = UILabel()
    @IBOutlet weak var passTextField: UITextField!
    
    let loginButton = UIButton()
    var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white // これで背景が白色に
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        
        let navigationBarTiltle = NSLocalizedString("booklineup", comment: "")
        self.navigationItem.title = navigationBarTiltle
        
        addressTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        passTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        // 入力フォームの自動補完およびShiftキーを無効化
        addressTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passTextField.autocapitalizationType = UITextAutocapitalizationType.none
        addressTextField.autocorrectionType = UITextAutocorrectionType.no
        passTextField.autocorrectionType = UITextAutocorrectionType.no
        
        // フォームの初期値をセット
        addressTextField.text = ""
        passTextField.text = ""
        
        
        setForms() // アドレスとPassのフォーム位置を定義
        setLoginButton() // ログインボタンの定義
        
        addressTextField.delegate = self
        addressTextField.returnKeyType = .done
        passTextField.delegate = self
        passTextField.returnKeyType = .done
    }
    
    func setForms(){
        
        let addressTitle = NSLocalizedString("mailaddress", comment: "")
        let passwordTitle = NSLocalizedString("password", comment: "")
        addressLabel.text = addressTitle
        passLabel.text = passwordTitle
        addressLabel.sizeToFit()
        passLabel.sizeToFit()
        addressTextField.borderStyle = UITextBorderStyle.roundedRect
        passTextField.borderStyle = UITextBorderStyle.roundedRect
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.isSecureTextEntry = true
        self.view.addSubview(addressLabel)
        self.view.addSubview(passLabel)
        self.view.addSubview(addressTextField)
        self.view.addSubview(passTextField)
        
        // アドレスと入力フォーム類の位置設定
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        addressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200.0).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        addressTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225.0).isActive = true
        addressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300.0).isActive = true
        passTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 325.0).isActive = true
        passTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setLoginButton(){
        // ボタン通常時の処理
        let loginTitle = NSLocalizedString("login", comment: "")
        loginButton.setTitle(loginTitle, for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        // ボタン押下時の処理
        loginButton.setTitle(loginTitle, for: .highlighted)
        
        loginButton.backgroundColor = UIColor.blue // 背景色
        loginButton.layer.borderWidth = 2.0 // 枠線の幅
        loginButton.layer.borderColor = UIColor.black.cgColor // 枠線の色
        loginButton.layer.cornerRadius = 10.0 // 角丸のサイズ
        
        loginButton.addTarget(self, action: #selector(touchedButton(sender:)), for: .touchUpInside)
        loginButton.sizeToFit()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        
        
        // ログインボタンの位置を定義
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450.0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchedButton(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = TabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ログイン成功しました")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
}
