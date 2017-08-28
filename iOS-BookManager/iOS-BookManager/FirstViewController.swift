//
//  FirstViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/24.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

//
//  ViewController.swift
//  SampleViewController
//
//  Created by 竹之内翔太郎 on 2017/08/22.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITabBarDelegate, UITextFieldDelegate{
    
    let loginText: String = "Login"
    
    // UI関連の変数定義
    let addressLabel = UILabel()
    @IBOutlet weak var addressForm: UITextField!
    let passLabel = UILabel()
    @IBOutlet weak var passForm: UITextField!
    
    let loginButton = UIButton()
    var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white // これで背景が白色に
        self.title = "書籍一覧"
        
        addressForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        passForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        // 入力フォームの自動補完およびShiftキーを無効化
        addressForm.autocapitalizationType = UITextAutocapitalizationType.none
        passForm.autocapitalizationType = UITextAutocapitalizationType.none
        addressForm.autocorrectionType = UITextAutocorrectionType.no
        passForm.autocorrectionType = UITextAutocorrectionType.no
        
        // フォームの初期値をセット
        addressForm.text = ""
        passForm.text = ""
        
        
        setForms() // アドレスとPassのフォーム位置を定義
        setLoginButton() // ログインボタンの定義
        
        addressForm.delegate = self
        addressForm.returnKeyType = .done
        passForm.delegate = self
        passForm.returnKeyType = .done
    }
    
    func setForms(){
        addressLabel.text = "メールアドレス"
        passLabel.text = "パスワード"
        addressLabel.textColor = UIColor.black
        passLabel.textColor = UIColor.black
        addressLabel.sizeToFit()
        passLabel.sizeToFit()
        addressForm.borderStyle = UITextBorderStyle.roundedRect
        passForm.borderStyle = UITextBorderStyle.roundedRect
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        addressForm.translatesAutoresizingMaskIntoConstraints = false
        passForm.translatesAutoresizingMaskIntoConstraints = false
        passForm.isSecureTextEntry = true
        self.view.addSubview(addressLabel)
        self.view.addSubview(passLabel)
        self.view.addSubview(addressForm)
        self.view.addSubview(passForm)
        
        // アドレスと入力フォーム類の位置設定
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        addressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200.0).isActive = true
        addressForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        addressForm.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225.0).isActive = true
        addressForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300.0).isActive = true
        passForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        passForm.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 325.0).isActive = true
        passForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setLoginButton(){
        // ボタン通常時の処理
        loginButton.setTitle(loginText, for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        // ボタン押下時の処理
        loginButton.setTitle(loginText, for: .highlighted)
        loginButton.setTitleColor(UIColor.black, for: .highlighted)
        
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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedButton(sender: UIButton) {
        let bookLineupViewController: BookLineUpViewController = BookLineUpViewController()
        self.navigationController?.pushViewController(bookLineupViewController, animated: true)
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
