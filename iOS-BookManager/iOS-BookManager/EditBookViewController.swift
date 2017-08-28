//
//  EditBookViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/25.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class EditBookViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {

    let addImageButton = UIButton() // 書籍画像添付ボタン
    
    let label_BookName = UILabel()
    @IBOutlet weak var form_BookName: UITextField!
    // var form_BookName: UITextField!
    let label_BookPrice = UILabel()
    @IBOutlet weak var form_BookPrice: UITextField!
    let label_BoughtDate = UILabel()
    @IBOutlet weak var form_BoughtDate: UITextField!
    
    var bookImage: UIImage?
    var bookImageView: UIImageView?
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        self.navigationItem.title = "書籍編集"
        
        // 戻るボタンの表示内容の設定
        
        let saveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onClicked(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        // 書籍のサムネイルを定義
        bookImage = UIImage(named: appDelegate.imagePath!)
        bookImageView = UIImageView(image: bookImage)
        bookImageView?.frame = CGRect(x: displayWidth*0.1, y: displayHeight*(4/30), width: displayWidth*0.3, height: displayHeight*0.2)
        bookImageView?.layer.borderColor = UIColor.gray.cgColor
        bookImageView?.layer.borderWidth = 1.0
        
        let addImageText: String = "画像添付ボタン"
        addImageButton.addTarget(self, action: #selector(onClicked(sender:)), for: .touchUpInside) // ボタン押下時の動作
        addImageButton.frame = CGRect(x: 170, y: 115, width: 120, height: 60) // ボタン枠サイズの設定
        addImageButton.setTitle(addImageText, for: .normal)
        addImageButton.setTitleColor(UIColor.white, for: .normal)
        addImageButton.setTitle(addImageText, for: .highlighted)
        addImageButton.setTitleColor(UIColor.black, for: .highlighted)
        addImageButton.backgroundColor = UIColor.blue // 背景色
        addImageButton.layer.borderWidth = 2.0 // 枠線の幅
        addImageButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        addImageButton.tag = 2
        
        form_BookName = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        form_BookPrice = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        form_BoughtDate = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        form_BookName.borderStyle = UITextBorderStyle.roundedRect
        form_BookPrice.borderStyle = UITextBorderStyle.roundedRect
        form_BoughtDate.borderStyle = UITextBorderStyle.roundedRect
        
        // 入力フォームの自動補完およびShiftキーを無効化
        form_BookName.autocapitalizationType = UITextAutocapitalizationType.none
        form_BookPrice.autocapitalizationType = UITextAutocapitalizationType.none
        form_BoughtDate.autocapitalizationType = UITextAutocapitalizationType.none
        form_BookName.autocorrectionType = UITextAutocorrectionType.no
        form_BookPrice.autocorrectionType = UITextAutocorrectionType.no
        form_BoughtDate.autocorrectionType = UITextAutocorrectionType.no
        form_BookName.returnKeyType = .done
        form_BookPrice.returnKeyType = .done
        form_BoughtDate.returnKeyType = .done
        
        // ラベルの中身をセット
        label_BookName.text = "書籍名"
        label_BookPrice.text = "金額"
        label_BoughtDate.text = "購入日"
        
        // フォームの初期値をセット
        form_BookName.text = appDelegate.title
        form_BookPrice.text = String(describing: appDelegate.price!)
        form_BoughtDate.text = appDelegate.boughtDate
        
        
        // closeButton.center = self.view.center
        label_BookName.translatesAutoresizingMaskIntoConstraints = false
        form_BookName.translatesAutoresizingMaskIntoConstraints = false
        label_BookPrice.translatesAutoresizingMaskIntoConstraints = false
        form_BookPrice.translatesAutoresizingMaskIntoConstraints = false
        label_BoughtDate.translatesAutoresizingMaskIntoConstraints = false
        form_BoughtDate.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(bookImageView!)
        self.view.addSubview(label_BookName)
        self.view.addSubview(form_BookName)
        self.view.addSubview(label_BookPrice)
        self.view.addSubview(form_BookPrice)
        self.view.addSubview(label_BoughtDate)
        self.view.addSubview(form_BoughtDate)
        // self.view.addSubview(closeButton)
        self.view.addSubview(addImageButton)
        
        form_BookName.delegate = self as? UITextFieldDelegate
        form_BookPrice.delegate = self as? UITextFieldDelegate
        form_BoughtDate.delegate = self as? UITextFieldDelegate
        
        // アドレスと入力フォーム類の位置設定
        
        let marginBtwLabForm: CGFloat = 5.0
        let marginBtwLabels: CGFloat = displayHeight*0.1
        
        bookImageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: displayWidth*0.1).isActive = true
        bookImageView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (2/30)*displayHeight).isActive = true
        bookImageView?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        bookImageView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        
        label_BookName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label_BookName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        label_BookName.topAnchor.constraint(equalTo: (self.bookImageView?.bottomAnchor)!, constant: 50).isActive = true
        form_BookName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        form_BookName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        form_BookName.topAnchor.constraint(equalTo: label_BookName.bottomAnchor, constant: marginBtwLabForm).isActive = true
        label_BookPrice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label_BookPrice.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        label_BookPrice.topAnchor.constraint(equalTo: label_BookName.bottomAnchor, constant: marginBtwLabels).isActive = true
        form_BookPrice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        form_BookPrice.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        form_BookPrice.topAnchor.constraint(equalTo: label_BookPrice.bottomAnchor, constant: marginBtwLabForm).isActive = true
        
        label_BoughtDate.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label_BoughtDate.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        label_BoughtDate.topAnchor.constraint(equalTo: label_BookPrice.bottomAnchor, constant: marginBtwLabels).isActive = true
        
        form_BoughtDate.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        form_BoughtDate.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        form_BoughtDate.topAnchor.constraint(equalTo: label_BoughtDate.bottomAnchor, constant: marginBtwLabForm).isActive = true
        
        addImageButton.centerYAnchor.constraint(equalTo: (bookImageView?.centerYAnchor)!).isActive = true
        addImageButton.leftAnchor.constraint(equalTo: (bookImageView?.rightAnchor)!, constant: 10.0).isActive = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    /*
     func pushedCloseButton(sender: UIButton){
     self.dismiss(animated: true, completion: nil)
     }
     */
    
    // ボタン押下時の分岐(タブバーは別所でやる)
    func onClicked(sender: UIButton){
        switch sender.tag {
        case 0:
            print("書籍追加画面を閉じます")
            self.dismiss(animated: true, completion: nil)
        case 1:
            print("書籍データを保存しました")
            break
        case 2:
            print("画像登録を行います")
        default:
            break
        }
    }

}
