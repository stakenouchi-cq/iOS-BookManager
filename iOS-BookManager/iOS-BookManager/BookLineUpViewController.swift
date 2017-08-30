import UIKit

class BookLineUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    var loadButton: UIButton!
    
    let rowHeight: CGFloat = 100
    let tabBarHeight: CGFloat = 49
    let loadButtonHeight: CGFloat = 20
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
        
        automaticallyAdjustsScrollViewInsets = false
        
        let navigationBarTitle = NSLocalizedString("booklineup", comment: "")
        self.navigationItem.title = navigationBarTitle
        
        // 追加ボタン押下時の動作定義
        let addTitle = NSLocalizedString("add", comment: "")
        let bookAddButton: UIBarButtonItem = UIBarButtonItem(title: addTitle, style: .plain, target: self, action: #selector(onClick(sender:)))
        bookAddButton.tag = 1
        
        // 戻るボタンの表示内容の設定
        let backTitle = NSLocalizedString("back", comment: "")
        let backButton = UIBarButtonItem()
        backButton.title = backTitle
        self.navigationItem.backBarButtonItem = backButton
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
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        // TableViewがステータスバーに埋もれないよう，先頭部分を調整
        let edgeInsets = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        myTableView.contentInset = edgeInsets
        myTableView.scrollIndicatorInsets = edgeInsets
        
        // TableViewの高さなどを定義
        myTableView.rowHeight = rowHeight
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(MyCell.self, forCellReuseIdentifier: NSStringFromClass(MyCell.self))
        
        self.view.addSubview(myTableView)
        
        loadButton = UIButton()
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        
        loadButton.frame = CGRect(x:0, y:0, width:displayWidth, height:loadButtonHeight)
        loadButton.backgroundColor = UIColor.white
        loadButton.layer.borderWidth = 2.0
        loadButton.layer.borderColor = UIColor.gray.cgColor
        
        let loadMoreTitle = NSLocalizedString("loadmore", comment: "")
        loadButton.setTitle(loadMoreTitle, for: .normal)
        loadButton.setTitleColor(UIColor.green, for: .normal)
        loadButton.setTitle(loadMoreTitle, for: .highlighted)
        loadButton.setTitleColor(UIColor.red, for: .highlighted)
        
        // ボタン押下時の処理
        loadButton.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        loadButton.tag = 0
        
        self.view.addSubview(loadButton)
        
        loadButton.topAnchor.constraint(equalTo: myTableView.bottomAnchor, constant: -83.5).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
       
    }
    
    // TabBar押下時の動作設定
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            print("書籍追加画面に行きます")
        case 2:
            print("設定画面に行きます")
            let settingView: SettingViewController = SettingViewController()
            self.navigationController?.pushViewController(settingView, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taxOutTitle = NSLocalizedString("taxout", comment: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyCell.self), for: indexPath) as! MyCell
        cell.bookTitleLabel.text = bookTitles[indexPath.row]
        cell.bookPriceLabel.text = priceOfBooks[indexPath.row].description + taxOutTitle
        cell.bookPublishedDate.text = boughtDates[indexPath.row]
        cell.bookImageView.image = UIImage(named: imageNames[indexPath.row])
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
        self.navigationController?.pushViewController(editBookViewController, animated: true)
    }
    
    func touchBookAddButton(){
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
    
    func onClick(sender: UIButton){
        switch sender.tag {
        case 0:
            print("書籍をさらに読み込みます")
        case 1:
            print("書籍の追加を行います")
            touchBookAddButton()
        default:
            break
        }
    }
    
    func gotoBookEdit() {
        let editBookView: EditBookViewController = EditBookViewController()
        self.navigationController?.pushViewController(editBookView, animated: true)
    }
    
}
