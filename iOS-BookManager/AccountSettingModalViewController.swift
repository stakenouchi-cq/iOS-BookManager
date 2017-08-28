//
//  AccountSettingViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/28.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class AccountSettingModalViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {
    
    let newAddressLabel = UILabel()
    @IBOutlet weak var newAddressForm: UITextField!
    let newPassLabel1 = UILabel() // パスワード(再入力じゃない方)
    @IBOutlet weak var newPassForm1: UITextField!
    let newPassLabel2 = UILabel() // パスワード(再入力)
    @IBOutlet weak var newPassForm2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画面のサイズを取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = "アカウント設定"
        
        // ナビゲーションバーに表示するボタンの設定
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(onClicked(sender:)))
        closeButton.tag = 0
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        let saveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onClicked(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        // ラベルの設定
        newAddressLabel.text = "メールアドレス"
        newPassLabel1.text = "パスワード"
        newPassLabel2.text = "パスワード確認"
        newAddressLabel.textColor = UIColor.black
        newPassLabel1.textColor = UIColor.black
        newPassLabel2.textColor = UIColor.black
        newAddressLabel.sizeToFit()
        newPassLabel1.sizeToFit()
        newPassLabel2.sizeToFit()
        
        
        // メールアドレスとパスワードのフォームのサイズを設定
        newAddressForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        newPassForm1 = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        newPassForm2 = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        // フォームの枠を丸枠にする
        newAddressForm.borderStyle = UITextBorderStyle.roundedRect
        newPassForm1.borderStyle = UITextBorderStyle.roundedRect
        newPassForm2.borderStyle = UITextBorderStyle.roundedRect
        
        // 入力フォームの自動補完およびShiftキーを無効化
        newAddressForm.autocapitalizationType = UITextAutocapitalizationType.none
        newPassForm1.autocapitalizationType = UITextAutocapitalizationType.none
        newPassForm2.autocapitalizationType = UITextAutocapitalizationType.none
        newAddressForm.autocorrectionType = UITextAutocorrectionType.no
        newPassForm1.autocorrectionType = UITextAutocorrectionType.no
        newPassForm2.autocorrectionType = UITextAutocorrectionType.no
        
        // パスワードは，入力文字を●で隠す
        newPassForm1.isSecureTextEntry = true
        newPassForm2.isSecureTextEntry = true
        
        // 画面に入った時は，各フォームは空である
        newAddressForm.text = ""
        newPassForm1.text = ""
        newPassForm2.text = ""
        
        newAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        newPassLabel1.translatesAutoresizingMaskIntoConstraints = false
        newPassLabel2.translatesAutoresizingMaskIntoConstraints = false
        newAddressForm.translatesAutoresizingMaskIntoConstraints = false
        newPassForm1.translatesAutoresizingMaskIntoConstraints = false
        newPassForm2.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(newAddressLabel)
        self.view.addSubview(newPassLabel1)
        self.view.addSubview(newPassLabel2)
        self.view.addSubview(newAddressForm)
        self.view.addSubview(newPassForm1)
        self.view.addSubview(newPassForm2)
        
        newAddressForm.delegate = self as? UITextFieldDelegate
        newPassForm1.delegate = self as? UITextFieldDelegate
        newPassForm2.delegate = self as? UITextFieldDelegate
        
        // アドレスと入力フォーム類の位置設定
        
        let marginBtwLabForm: CGFloat = 5.0
        let marginBtwLabels: CGFloat = displayHeight*0.1
        
        // メールアドレス
        newAddressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newAddressLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newAddressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (5/30)*displayHeight).isActive = true
        newAddressForm.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newAddressForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newAddressForm.topAnchor.constraint(equalTo: newAddressLabel.bottomAnchor, constant: marginBtwLabForm).isActive = true
        // パスワード(入力1回目)
        newPassLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassLabel1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassLabel1.topAnchor.constraint(equalTo: newAddressLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        newPassForm1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassForm1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassForm1.topAnchor.constraint(equalTo: newPassLabel1.bottomAnchor, constant: marginBtwLabForm).isActive = true
        // パスワード(入力2回目)
        newPassLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassLabel2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassLabel2.topAnchor.constraint(equalTo: newPassLabel1.bottomAnchor, constant: marginBtwLabels).isActive = true
        newPassForm2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newPassForm2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        newPassForm2.topAnchor.constraint(equalTo: newPassLabel2.bottomAnchor, constant: marginBtwLabForm).isActive = true
    }
    
    // ボタン押下時の分岐
    func onClicked(sender: UIButton){
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
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
