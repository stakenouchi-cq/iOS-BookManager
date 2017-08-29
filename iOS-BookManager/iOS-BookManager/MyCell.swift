//
//  MyCell.swift
//  iOS-BookManager
//
//  Created by 竹之内翔太郎 on 2017/08/25.
//  Copyright © 2017年 shotaro takenouchi. All rights reserved.
//

import UIKit
import Foundation

class MyCell: UITableViewCell {
    var myLabelOfBookTitle: UILabel!
    var myLabelOfBookPrice: UILabel!
    var myLabelOfDatePublished: UILabel!
    var myImage: UIImage!
    var myImageView: UIImageView!
    var bookEditLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myLabelOfBookTitle = UILabel(frame: CGRect.zero)
        myLabelOfBookTitle.textAlignment = .left
        contentView.addSubview(myLabelOfBookTitle)
        
        myLabelOfBookPrice = UILabel(frame: CGRect.zero)
        myLabelOfBookPrice.textAlignment = .left
        contentView.addSubview(myLabelOfBookPrice)
        
        myLabelOfDatePublished = UILabel(frame: CGRect.zero)
        myLabelOfDatePublished.textAlignment = .left
        contentView.addSubview(myLabelOfDatePublished)
        
        myImage = UIImage(named: "no_image.png")
        myImageView = UIImageView(image: myImage)
        contentView.addSubview(myImageView)
        
        bookEditLabel = UILabel()
        bookEditLabel.text = ">"
        // bookEditLabel.addTarget(self, action: #selector(onClicked(sender:)), for: .touchUpInside)
        contentView.addSubview(bookEditLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabelOfBookTitle.frame = CGRect(x: 90, y: -25, width: frame.width - 100, height: frame.height)
        myLabelOfBookPrice.frame = CGRect(x: 90, y: 25, width: 120, height: frame.height)
        myLabelOfDatePublished.frame = CGRect(x: frame.width - 150, y: 25, width: 120, height: frame.height)
        myImageView.frame = CGRect(x: 5, y: 0, width: frame.height*(210/297), height: frame.height)
        bookEditLabel.frame = CGRect(x: frame.width - 20, y: 0, width: 10, height: frame.height)
    }
    
    func onClicked(sender: UIButton){
        // print("書籍編集画面に入ります")
    }
    
}
