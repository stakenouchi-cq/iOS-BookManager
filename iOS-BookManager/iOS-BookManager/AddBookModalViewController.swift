//
//  AddBookModalView.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/25.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class AddBookModalViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {

    let addImageButton = UIButton() // 書籍画像添付ボタン
    
    var bookImage: UIImage?
    var bookImageView: UIImageView?
    
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
        self.navigationItem.title = "書籍追加"
        
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(onClicked(sender:)))
        closeButton.tag = 0
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        
        let saveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onClicked(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
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
    
    // ボタン押下時の分岐
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
