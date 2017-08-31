import UIKit

class BookLineUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var loadButton: UIButton!
    
    let tabBarHeight: CGFloat = 49
    let loadButtonHeight: CGFloat = 20
    var myTableView: UITableView!
    
    // ステータスバーの高さを取得する
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    var books: [Book] = []
    
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
    
    func generateBookObjects() -> [Book] {
        var books = [Book]()
        for i in 0..<bookTitles.count {
            books.append(Book(id: i, name: bookTitles[i], price: priceOfBooks[i], boughtDate: boughtDates[i], imagePath: imageNames[i]))
        }
        return books
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        books = generateBookObjects() // 書籍のデータオブジェクトの配列
        
        // ナビゲーションバーのタイトルを設定
        self.navigationItem.title = R.string.localizable.booklineup()
        
        // 追加ボタン押下時の動作定義
        let bookAddButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.add(), style: .plain, target: self, action: #selector(onClick(sender:)))
        bookAddButton.tag = 1
        
        // 戻るボタンの表示内容の設定
        let backButton = UIBarButtonItem()
        backButton.title = R.string.localizable.back()
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
        
        // TableViewのセル形式を，BookCell.swiftから取得
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        
        self.view.addSubview(myTableView)
        
        loadButton = UIButton()
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        
        loadButton.frame = CGRect(x:0, y:0, width:displayWidth, height:loadButtonHeight)
        loadButton.backgroundColor = UIColor.white
        loadButton.layer.borderWidth = 2.0
        loadButton.layer.borderColor = UIColor.gray.cgColor
        
        loadButton.setTitle(R.string.localizable.loadmore(), for: .normal)
        loadButton.setTitleColor(UIColor.green, for: .normal)
        loadButton.setTitle(R.string.localizable.loadmore(), for: .highlighted)
        loadButton.setTitleColor(UIColor.red, for: .highlighted)
        
        // ボタン押下時の処理
        loadButton.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        loadButton.tag = 0
        
        self.view.addSubview(loadButton)
        
        loadButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -49.0).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BookCell.self), for: indexPath) as! BookCell
        cell.registCell(book: books[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたcellに対応する書籍編集画面へ移動
        print("\(indexPath.row)番目の書籍編集画面に入ります")
        let editBookViewController: EditBookViewController = EditBookViewController()
        print(books[indexPath.row].price)
        editBookViewController.book = books[indexPath.row]
        self.navigationController?.pushViewController(editBookViewController, animated: true)
    }
    
    
    func touchBookAddButton() {
        // 書籍追加ボタン押下時の処理を追加
        let addBookModalView = AddBookModalViewController()
        let navi = UINavigationController(rootViewController: addBookModalView) // モーダル画面でもナビゲーションバーが出るようにする
        print("書籍追加のモーダル画面をopen")
        addBookModalView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onClick(sender: UIButton) {
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
    
}
