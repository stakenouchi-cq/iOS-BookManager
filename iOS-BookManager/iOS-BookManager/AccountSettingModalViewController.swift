//
//  AccountSettingViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/28.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class AccountSettingModalViewController: UIViewController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = "アカウント設定"
        
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(onClicked(sender:)))
        closeButton.tag = 0
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        
        let saveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onClicked(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
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
