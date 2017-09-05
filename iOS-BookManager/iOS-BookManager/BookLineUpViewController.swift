import UIKit

class BookLineUpViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var books: [Book] = []
    
    var bookDataDict: [Dictionary<String, Any>] = [
        ["name": "スッキリわかるJava入門", "price": 3500, "boughtDate": "2014/04/03", "imagePath": "javabook.jpg"],
        ["name": "Oxford英英辞典", "price": 5000, "boughtDate": "2014/04/02", "imagePath": "Oxford_Dict.jpg"],
        ["name": "詳細!Swift 3 iPhoneアプリ開発入門ノート", "price": 4000, "boughtDate": "2014/03/15", "imagePath": "sw3book.jpg"],
        ["name": "200点アップのTOEICテスト英単語 - 得点に大きくつながる意外な意味を持つ英単語 -", "price": 2500, "boughtDate": "2006/10/15", "imagePath": "toeicbook.jpg"],
        ["name": "Accelerated C++ - 効率的なプログラミングのための新しい定跡 -", "price": 3400, "boughtDate": "2009/07/30", "imagePath": "cppbook.jpg"]
    ]
    
    func generateBookObjects() -> Void {
        for bookData in bookDataDict {
            let name = bookData["name"] as! String
            let price = bookData["price"] as! Int
            let boughtDate = bookData["boughtDate"] as! String
            let imagePath = bookData["imagePath"] as! String
            books.append(Book(name: name, price: price, boughtDate: boughtDate, imagePath: imagePath))
        }
    }
    
    let loadButton: UIButton = {
       let button = UIButton()
        button.setTitle(R.string.localizable.loadmore(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "loadMoreBooks", for: .touchUpInside)
        return button
    }()
    
    lazy var bookTableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateBookObjects() // 書籍のデータ郡を生成
        setNavigationBarInfo() // ナビゲーションバーの記述が肥大化するため，今回はextension部にコードを書く
        setBookLineupViewLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 書籍編集画面に行った時に戻るボタンが表示されるよう，viewWillAppearに定義
        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        backButton.title = R.string.localizable.back()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBook() {
        // 書籍追加ボタン押下時の処理を追加
        let addBookViewController = AddBookViewController()
        let navi = UINavigationController(rootViewController: addBookViewController) // モーダル画面でもナビゲーションバーが出るようにする
        print("Open add book screen.")
        addBookViewController.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
    }
    
    func loadMoreBooks() {
        print("More Books will be loaded.")
    }
    
}

extension BookLineUpViewController {
    
    // tableViewのセル情報を記述
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Sectionは1つだけ
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count // 本の数だけ表示
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BookCell.self), for: indexPath) as! BookCell
        cell.registCell(book: books[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたcellに対応する書籍編集画面へ移動
        let editBookViewController = EditBookViewController()
        print(books[indexPath.row].price)
        editBookViewController.book = books[indexPath.row]
        self.navigationController?.pushViewController(editBookViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 100
    }
    
}

extension BookLineUpViewController {
    func setNavigationBarInfo() {
        // ナビゲーションバーのタイトルを設定
        self.navigationItem.title = R.string.localizable.booklineup()
        // 左上部の戻るボタンを非表示(画面遷移後は表示)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.add(), style: .plain, target: self, action: "addBook")
    }
    
    func setBookLineupViewLayout() {
        self.view.addSubview(bookTableView)
        self.view.addSubview(loadButton)
        
        let tabBarHeight = CGFloat(49)
        loadButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1.0*tabBarHeight).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
