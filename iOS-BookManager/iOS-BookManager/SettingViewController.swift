//
//  SettingViewController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/28.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITabBarDelegate {
    
    var gotoSettingButton: UIButton!
    var myTabBar: UITabBar!
    let tabBarHeight: CGFloat = 49
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = "設定"
        self.view.backgroundColor = UIColor.white
        
        // 左上部の戻るボタンを非表示
        self.navigationItem.hidesBackButton = false
        
        gotoSettingButton = UIButton()
        gotoSettingButton.translatesAutoresizingMaskIntoConstraints = false
        let moreloadText: String = "さらに読み込む"
        gotoSettingButton.frame = CGRect(x: 0, y: 0, width: displayWidth-tabBarHeight, height: 50)
        gotoSettingButton.setTitle("アカウント設定", for: .normal)
        gotoSettingButton.setTitleColor(UIColor.white, for: .normal)
        gotoSettingButton.backgroundColor = UIColor.blue // 背景色
        gotoSettingButton.layer.borderWidth = 2.0 // 枠線の幅
        gotoSettingButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        // ボタン押下時の処理
        gotoSettingButton.addTarget(self, action: #selector(onClicked(sender:)), for: .touchUpInside)
        gotoSettingButton.tag = 0
        self.view.addSubview(gotoSettingButton)
        
        gotoSettingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        gotoSettingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        gotoSettingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func onClicked(sender: UIButton){
        switch sender.tag {
        case 0:
            print("アカウント設定画面に入ります")
            clickAccountSettingButton()
        default:
            break
        }
    }
    
    func clickAccountSettingButton(){
        let accountSettingModalView = AccountSettingModalViewController()
        let navi = UINavigationController(rootViewController: accountSettingModalView) // モーダル画面でもナビゲーションバーが出るようにする
        print("アカウント設定のモーダル画面をopen")
        accountSettingModalView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
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
