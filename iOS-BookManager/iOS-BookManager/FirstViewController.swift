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
    let label_address = UILabel()
    @IBOutlet weak var form_address: UITextField!
    let label_pass = UILabel()
    @IBOutlet weak var form_pass: UITextField!
    
    let button1 = UIButton()
    var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white // これで背景が白色に
        self.title = "書籍一覧"
        
        form_address = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        form_pass = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        // 入力フォームの自動補完およびShiftキーを無効化
        form_address.autocapitalizationType = UITextAutocapitalizationType.none
        form_pass.autocapitalizationType = UITextAutocapitalizationType.none
        form_address.autocorrectionType = UITextAutocorrectionType.no
        form_pass.autocorrectionType = UITextAutocorrectionType.no
        
        // フォームの初期値をセット
        form_address.text = ""
        form_pass.text = ""
        
        
        setForms() // アドレスとPassのフォーム位置を定義
        setLoginButton() // ログインボタンの定義
        
        form_address.delegate = self
        form_address.returnKeyType = .done
        form_pass.delegate = self
        form_pass.returnKeyType = .done
    }
    
    func setForms(){
        label_address.text = "メールアドレス"
        label_pass.text = "パスワード"
        label_address.textColor = UIColor.black
        label_pass.textColor = UIColor.black
        label_address.sizeToFit()
        label_pass.sizeToFit()
        form_address.borderStyle = UITextBorderStyle.roundedRect
        form_pass.borderStyle = UITextBorderStyle.roundedRect
        label_address.translatesAutoresizingMaskIntoConstraints = false
        label_pass.translatesAutoresizingMaskIntoConstraints = false
        form_address.translatesAutoresizingMaskIntoConstraints = false
        form_pass.translatesAutoresizingMaskIntoConstraints = false
        form_pass.isSecureTextEntry = true
        self.view.addSubview(label_address)
        self.view.addSubview(label_pass)
        self.view.addSubview(form_address)
        self.view.addSubview(form_pass)
        
        // アドレスと入力フォーム類の位置設定
        label_address.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        label_address.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200.0).isActive = true
        form_address.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        form_address.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225.0).isActive = true
        form_address.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        label_pass.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        label_pass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300.0).isActive = true
        form_pass.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        form_pass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 325.0).isActive = true
        form_pass.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setLoginButton(){
        // ボタン通常時の処理
        button1.setTitle(loginText, for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        // ボタン押下時の処理
        button1.setTitle(loginText, for: .highlighted)
        button1.setTitleColor(UIColor.black, for: .highlighted)
        
        button1.backgroundColor = UIColor.blue // 背景色
        button1.layer.borderWidth = 2.0 // 枠線の幅
        button1.layer.borderColor = UIColor.black.cgColor // 枠線の色
        button1.layer.cornerRadius = 10.0 // 角丸のサイズ
        
        button1.addTarget(self, action: #selector(touchedButton(sender:)), for: .touchUpInside)
        button1.sizeToFit()
        button1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button1)
        
        
        // 親ビューの左端から30ptに設置
        button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        // Yの位置設定
        button1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450.0).isActive = true
        // 親ビューの幅の1/2
        button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        // ボタンの高さは30pt
        button1.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
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
