//
//  BookLineUpView.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/24.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit

class BookLineUpView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// 画像のファイル名
    let imageNames = ["javabook.jpg", "Oxford_Dict.jpg", ""]
    
    /// 画像のタイトル
    let imageTitles = ["スッキリわかるJava入門", "Oxford英英辞典"]
    
    /// 画像の説明
    let imageDescriptions = [
        "Javaの楽しい入門書",
        "英英辞典の定番"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTableView = UITableView(frame: view.frame, style: .plain)
        myTableView.rowHeight = 70
        myTableView.delegate      =   self
        myTableView.dataSource    =   self
        myTableView.register(MyCell.self, forCellReuseIdentifier: NSStringFromClass(MyCell.self))
        self.view.addSubview(myTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyCell.self), for: indexPath) as! MyCell
        cell.myLabel.text = imageTitles[indexPath.row]
        cell.myImageView.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Sample"
     }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // hogehoge
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

class MyCell: UITableViewCell {
    var myLabel: UILabel!
    var myImage: UIImage!
    var myImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myLabel = UILabel(frame: CGRect.zero)
        myLabel.textAlignment = .left
        contentView.addSubview(myLabel)
        
        myImage = UIImage(named: "javabook.jpg")
        myImageView = UIImageView(image: myImage)
        contentView.addSubview(myImageView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 110, y: 0, width: frame.width - 100, height: frame.height)
        myImageView.frame = CGRect(x: 0, y: 0, width: 100, height: frame.height)
    }
    
}

