//
//  BookLineUpView.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/24.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class BookLineUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var loadButton: UIButton!
    
    let rowHeight: CGFloat = 100
    let tabBarHeight: CGFloat = 49
    var myTabBar: UITabBar!
    var myTableView: UITableView!
    
    // ステータスバーの高さを取得する
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    /// 画像のファイル名
    var imageNames: [String] = [
        "javabook.jpg",
        "Oxford_Dict.jpg",
        "sw3book.jpg",
        "toeicbook.jpg",
        "cppbook.jpg"
    ]
    
    /// 画像のタイトル
    var bookTitles: [String] = [
        "スッキリわかるJava入門",
        "Oxford英英辞典",
        "詳細!Swift 3 iPhoneアプリ開発入門ノート",
        "200点アップのTOEICテスト英単語 : 得点に大きくつながる意外な意味を持つ英単語.",
        "Accelerated C++ : 効率的なプログラミングのための新しい定跡"
    ]
    
    var priceOfBooks: [Int] = [
        3500,
        5000,
        4000,
        2500,
        3400
    ]
    
    var boughtDates: [String] = [
        "2014/04/03",
        "2014/04/02",
        "2014/03/15",
        "2006/10/15",
        "2009/07/30"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "登録済み書籍一覧"
        
        // 追加ボタン押下時の動作定義
        let bookAddButton: UIBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(onClicked(sender:)))
        bookAddButton.tag = 1
        
        // 戻るボタンの表示内容の設定
        let backButton = UIBarButtonItem()
        backButton.title = "戻る"
        self.navigationItem.backBarButtonItem = backButton
        // 左上部の戻るボタンを表示させる
        self.navigationItem.hidesBackButton = false
        // 左上部の戻るボタンを非表示
        self.navigationItem.hidesBackButton = true
        
        // ナビゲーションバーの右側に書籍追加ボタン付与
        self.navigationItem.setRightBarButtonItems([bookAddButton], animated: true)
        
        // ナビゲーションバーの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
   
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewを生成
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight-tabBarHeight)) // ステータスバー分ずらす
        myTableView.rowHeight = rowHeight
        myTableView.delegate      =   self
        myTableView.dataSource    =   self
        myTableView.register(MyCell.self, forCellReuseIdentifier: NSStringFromClass(MyCell.self))

        
        myTabBar = UITabBar()
        myTabBar.delegate = self as? UITabBarDelegate
        myTabBar.frame = CGRect(x:0, y:displayHeight - tabBarHeight,width:displayWidth, height:tabBarHeight) // サイズをセット
        myTabBar.barTintColor = UIColor.black // バー自身の色をセット
        myTabBar.unselectedItemTintColor = UIColor.white // 非選択ボタンの色
        myTabBar.tintColor = UIColor.blue // ボタン押下時の色
        let bookLineup: UITabBarItem = UITabBarItem(title: "書籍一覧", image: nil, tag: 1)
        let gotoSetting: UITabBarItem = UITabBarItem(title: "設定", image: nil, tag: 2)
        myTabBar.items = [bookLineup, gotoSetting]
        
        loadButton = UIButton()
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        let moreloadText: String = "さらに読み込む"
        loadButton.frame = CGRect(x: 0, y: 0, width: displayWidth-tabBarHeight, height: 50)
        loadButton.setTitle(moreloadText, for: .normal)
        loadButton.setTitleColor(UIColor.white, for: .normal)
        loadButton.setTitle(moreloadText, for: .highlighted)
        loadButton.setTitleColor(UIColor.black, for: .highlighted)
        loadButton.backgroundColor = UIColor.blue // 背景色
        loadButton.layer.borderWidth = 2.0 // 枠線の幅
        loadButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        // ボタン押下時の処理
        loadButton.addTarget(self, action: #selector(onClicked(sender:)), for: .touchUpInside)
        loadButton.tag = 0
        
        self.view.addSubview(myTableView)
        self.view.addSubview(myTabBar)
        self.view.addSubview(loadButton)
        
        loadButton.bottomAnchor.constraint(equalTo: myTabBar.topAnchor).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyCell.self), for: indexPath) as! MyCell
        cell.myLabelOfBookTitle.text = bookTitles[indexPath.row]
        cell.myLabelOfBookPrice.text = priceOfBooks[indexPath.row].description + "円 + 税"
        cell.myLabelOfDatePublished.text = boughtDates[indexPath.row]
        cell.myImageView.image = UIImage(named: imageNames[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたcellに対応する書籍編集画面へ移動
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.title = bookTitles[indexPath.row]
        appDelegate.imagePath = imageNames[indexPath.row]
        appDelegate.boughtDate = boughtDates[indexPath.row]
        appDelegate.title = bookTitles[indexPath.row]
        appDelegate.price = priceOfBooks[indexPath.row]
        
        print("\(indexPath.row)番目の書籍編集画面に入ります")
        let editBookViewController: EditBookViewController = EditBookViewController()
        self.navigationController?.pushViewController(editBookViewController, animated: false)
    }
    
    func clickBookAddButton(){
        // 書籍追加ボタン押下時の処理を追加
        
        let addBookModalView = AddBookModalViewController()
        let navi = UINavigationController(rootViewController: addBookModalView) // モーダル画面でもナビゲーションバーが出るようにする
        print("書籍追加のモーダル画面をopen")
        addBookModalView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onClicked(sender: UIButton){
        switch sender.tag {
        case 0:
            print("書籍をさらに読み込みます")
        case 1:
            print("書籍の追加を行います")
            clickBookAddButton()
        default:
            break
        }
    }
    
    func gotoBookEdit() {
        let editBookView: EditBookViewController = EditBookViewController()
        self.navigationController?.pushViewController(editBookView, animated: true)
    }
    
}
