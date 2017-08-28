//
//  TabBarController.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/28.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let bookLineUpViewController = BookLineUpViewController()
        let settingViewController = SettingViewController()
        
        let navigationController1 = UINavigationController(rootViewController: bookLineUpViewController)
        let navigationController2 = UINavigationController(rootViewController: settingViewController)
        
        bookLineUpViewController.title = "書籍一覧"
        settingViewController.title = "設定"
        self.delegate = self
        self.viewControllers = [navigationController1, navigationController2]
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
