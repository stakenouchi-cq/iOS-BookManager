import UIKit

class BookLineUpViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var books: [Book] = []
    
    fileprivate let loadButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.loadmore(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "loadMoreBooks", for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var bookTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        return tableView
    }()
    
    fileprivate let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = R.string.localizable.back()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateBookDataSet()
        // ナビゲーションバーのタイトルを設定
        self.navigationItem.title = R.string.localizable.booklineup()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.add(), style: .plain, target: self, action: "addBook")
        setBookLineupViewLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func generateBookDataSet() {
        books.append(Book(name: "Oxford英英辞典", price: 5000, purchaseDate: "2014/11/27", imageURL: URL(string: "https://images-fe.ssl-images-amazon.com/images/I/51OEYvMOYEL._AC_US320_QL65_.jpg")!))
        books.append(Book(name: "Kotlinスタートブック -新しいAndroidプログラミング", price: 3780, purchaseDate: "2016/07/13", imageURL: URL(string: "https://images-fe.ssl-images-amazon.com/images/I/51HzwN0d1iL._AC_US320_QL65_.jpg")!))
        books.append(Book(name: "詳細!Swift 3 iPhoneアプリ開発入門ノート", price: 4000, purchaseDate: "2014/03/15", imageURL: URL(string: "https://images-fe.ssl-images-amazon.com/images/I/61wRhxNyAtL._AC_US320_QL65_.jpg")!))
        books.append(Book(name: "200点アップのTOEICテスト英単語 - 得点に大きくつながる意外な意味を持つ英単語 -", price: 2500, purchaseDate: "2006/10/13", imageURL: URL(string: "https://images-fe.ssl-images-amazon.com/images/I/513W1QHXX9L._AC_US320_QL65_.jpg")!))
        books.append(Book(name: "Accelerated C++ - 効率的なプログラミングのための新しい定跡 -", price: 3400, purchaseDate: "2009/07/19", imageURL: URL(string: "https://images-fe.ssl-images-amazon.com/images/I/51Pke5cnOZL._AC_US320_QL65_.jpg")!))
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
        editBookViewController.book = books[indexPath.row]
        self.navigationController?.pushViewController(editBookViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 100
    }
    
}

extension BookLineUpViewController {
    fileprivate func setBookLineupViewLayout() {
        self.view.addSubview(bookTableView)
        self.view.addSubview(loadButton)
        
        let tabBarHeight = CGFloat(49)
        loadButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1.0*tabBarHeight).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
