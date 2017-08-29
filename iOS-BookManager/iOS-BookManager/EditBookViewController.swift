//
//  EditBookViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/25.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class EditBookViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate, UITabBarDelegate {
    
    let tabBarHeight: CGFloat = 49

    let addImageButton = UIButton() // 書籍画像添付ボタン
    
    var myTabBar: UITabBar!
    let bookNameLabel = UILabel()
    @IBOutlet weak var bookNameForm: UITextField!
    // var bookNameForm: UITextField!
    let bookPriceLabel = UILabel()
    @IBOutlet weak var bookPriceForm: UITextField!
    let boughtDateLabel = UILabel()
    @IBOutlet weak var boughtDateForm: UITextField!
    
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
        
        bookNameForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        bookPriceForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        boughtDateForm = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        bookNameForm.borderStyle = UITextBorderStyle.roundedRect
        bookPriceForm.borderStyle = UITextBorderStyle.roundedRect
        boughtDateForm.borderStyle = UITextBorderStyle.roundedRect
        
        bookNameForm.tag = 1
        bookPriceForm.tag = 2
        boughtDateForm.tag = 3
        
        // 入力フォームの自動補完およびShiftキーを無効化
        bookNameForm.autocapitalizationType = UITextAutocapitalizationType.none
        bookPriceForm.autocapitalizationType = UITextAutocapitalizationType.none
        boughtDateForm.autocapitalizationType = UITextAutocapitalizationType.none
        bookNameForm.autocorrectionType = UITextAutocorrectionType.no
        bookPriceForm.autocorrectionType = UITextAutocorrectionType.no
        boughtDateForm.autocorrectionType = UITextAutocorrectionType.no
        bookNameForm.returnKeyType = .done
        bookPriceForm.returnKeyType = .done
        boughtDateForm.returnKeyType = .done
        
        // ラベルの中身をセット
        bookNameLabel.text = "書籍名"
        bookPriceLabel.text = "金額"
        boughtDateLabel.text = "購入日"
        
        // フォームの初期値をセット
        bookNameForm.text = appDelegate.title
        bookPriceForm.text = String(describing: appDelegate.price!)
        boughtDateForm.text = appDelegate.boughtDate
        
        
        // closeButton.center = self.view.center
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameForm.translatesAutoresizingMaskIntoConstraints = false
        bookPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bookPriceForm.translatesAutoresizingMaskIntoConstraints = false
        boughtDateLabel.translatesAutoresizingMaskIntoConstraints = false
        boughtDateForm.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(bookImageView!)
        self.view.addSubview(bookNameLabel)
        self.view.addSubview(bookNameForm)
        self.view.addSubview(bookPriceLabel)
        self.view.addSubview(bookPriceForm)
        self.view.addSubview(boughtDateLabel)
        self.view.addSubview(boughtDateForm)
        self.view.addSubview(addImageButton)
        
        bookNameForm.delegate = self as? UITextFieldDelegate
        bookPriceForm.delegate = self as? UITextFieldDelegate
        boughtDateForm.delegate = self as? UITextFieldDelegate
        
        // アドレスと入力フォーム類の位置設定
        
        let marginBtwLabForm: CGFloat = 5.0
        let marginBtwLabels: CGFloat = displayHeight*0.1
        
        bookImageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: displayWidth*0.1).isActive = true
        bookImageView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (2/30)*displayHeight).isActive = true
        bookImageView?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        bookImageView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        
        bookNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookNameLabel.topAnchor.constraint(equalTo: (self.bookImageView?.bottomAnchor)!, constant: 50).isActive = true
        bookNameForm.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookNameForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookNameForm.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: marginBtwLabForm).isActive = true
        bookPriceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookPriceLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        bookPriceForm.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookPriceForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceForm.topAnchor.constraint(equalTo: bookPriceLabel.bottomAnchor, constant: marginBtwLabForm).isActive = true
        
        boughtDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boughtDateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        boughtDateLabel.topAnchor.constraint(equalTo: bookPriceLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        
        boughtDateForm.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boughtDateForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        boughtDateForm.topAnchor.constraint(equalTo: boughtDateLabel.bottomAnchor, constant: marginBtwLabForm).isActive = true
        
        addImageButton.centerYAnchor.constraint(equalTo: (bookImageView?.centerYAnchor)!).isActive = true
        addImageButton.leftAnchor.constraint(equalTo: (bookImageView?.rightAnchor)!, constant: 10.0).isActive = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1,2:
            return
        case 3:
            print("日付編集します")
            dateEditing(sender: textField)
        default:
            break
        }
    }
    
    func dateEditing(sender: UITextField){
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        boughtDateForm.text = dateFormatter.string(from: sender.date)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
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
