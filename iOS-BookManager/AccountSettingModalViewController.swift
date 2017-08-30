import UIKit

class AccountSettingModalViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {
    
    let newAddressLabel = UILabel()
    @IBOutlet weak var newAddressTextField: UITextField!
    let newPassLabel1 = UILabel() // パスワード(再入力じゃない方)
    @IBOutlet weak var newPassForm1: UITextField!
    let newPassLabel2 = UILabel() // パスワード(再入力)
    @IBOutlet weak var newPassForm2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面のサイズを取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        let navigationBarTiltle = NSLocalizedString("accountsetting", comment: "")
        self.navigationItem.title = navigationBarTiltle
        
        // ナビゲーションバーに表示するボタンの設定
        let closeTitle = NSLocalizedString("close", comment: "")
        let saveTitle = NSLocalizedString("save", comment: "")
        let closeButton = UIBarButtonItem(title: closeTitle, style: .plain, target: self, action: #selector(onClick(sender:)))
        closeButton.tag = 0
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        let saveButton = UIBarButtonItem(title: saveTitle, style: .plain, target: self, action: #selector(onClick(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        // ラベルの設定
        let addressTitle = NSLocalizedString("mailaddress", comment: "")
        let passwordTitle = NSLocalizedString("password", comment: "")
        let accpasswordTitle = NSLocalizedString("accpassword", comment: "")
        newAddressLabel.text = addressTitle
        newPassLabel1.text = passwordTitle
        newPassLabel2.text = accpasswordTitle
        newAddressLabel.sizeToFit()
        newPassLabel1.sizeToFit()
        newPassLabel2.sizeToFit()
        
        
        // メールアドレスとパスワードのフォームのサイズを設定
        newAddressTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        newPassForm1 = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        newPassForm2 = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        // フォームの枠を丸枠にする
        newAddressTextField.borderStyle = UITextBorderStyle.roundedRect
        newPassForm1.borderStyle = UITextBorderStyle.roundedRect
        newPassForm2.borderStyle = UITextBorderStyle.roundedRect
        
        // 入力フォームの自動補完およびShiftキーを無効化
        newAddressTextField.autocapitalizationType = UITextAutocapitalizationType.none
        newPassForm1.autocapitalizationType = UITextAutocapitalizationType.none
        newPassForm2.autocapitalizationType = UITextAutocapitalizationType.none
        newAddressTextField.autocorrectionType = UITextAutocorrectionType.no
        newPassForm1.autocorrectionType = UITextAutocorrectionType.no
        newPassForm2.autocorrectionType = UITextAutocorrectionType.no
        
        // パスワードは，入力文字を●で隠す
        newPassForm1.isSecureTextEntry = true
        newPassForm2.isSecureTextEntry = true
        
        // 画面に入った時は，各フォームは空である
        newAddressTextField.text = ""
        newPassForm1.text = ""
        newPassForm2.text = ""
        
        newAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        newPassLabel1.translatesAutoresizingMaskIntoConstraints = false
        newPassLabel2.translatesAutoresizingMaskIntoConstraints = false
        newAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        newPassForm1.translatesAutoresizingMaskIntoConstraints = false
        newPassForm2.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(newAddressLabel)
        self.view.addSubview(newPassLabel1)
        self.view.addSubview(newPassLabel2)
        self.view.addSubview(newAddressTextField)
        self.view.addSubview(newPassForm1)
        self.view.addSubview(newPassForm2)
        
        newAddressTextField.delegate = self as? UITextFieldDelegate
        newPassForm1.delegate = self as? UITextFieldDelegate
        newPassForm2.delegate = self as? UITextFieldDelegate
        
        // アドレスと入力フォーム類の位置設定
        
        let marginBtwLabTextField: CGFloat = 5.0
        let marginBtwLabels: CGFloat = displayHeight*0.1
        
        // メールアドレス
        newAddressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newAddressLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (5/30)*displayHeight).isActive = true
        newAddressTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newAddressTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newAddressTextField.topAnchor.constraint(equalTo: newAddressLabel.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        // パスワード(入力1回目)
        newPassLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassLabel1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassLabel1.topAnchor.constraint(equalTo: newAddressLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        newPassForm1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassForm1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassForm1.topAnchor.constraint(equalTo: newPassLabel1.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        // パスワード(入力2回目)
        newPassLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassLabel2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassLabel2.topAnchor.constraint(equalTo: newPassLabel1.bottomAnchor, constant: marginBtwLabels).isActive = true
        newPassForm2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassForm2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassForm2.topAnchor.constraint(equalTo: newPassLabel2.bottomAnchor, constant: marginBtwLabTextField).isActive = true
    }
    
    // ボタン押下時の分岐
    func onClick(sender: UIButton){
        switch sender.tag {
        case 0:
            print("書籍追加画面を閉じます")
            self.dismiss(animated: true, completion: nil)
        case 1:
            print("アカウント情報を更新しました")
            break
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
