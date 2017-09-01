import UIKit

class BookLineUpViewController: UIViewController, UINavigationBarDelegate {
    let loadButton = UIButton()
    let tabBarHeight: CGFloat = 49
    let loadButtonHeight: CGFloat = 20
    let tableView = UITableView()
    var books: [Book] = []
    
    // 以下，テスト用のデータ(API作成後，削除予定)
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
        books = generateBookObjects() // 書籍のデータオブジェクトの配列
        // ナビゲーションバーのタイトルを設定
        self.navigationItem.title = R.string.localizable.booklineup()
        // ボタン押下時の処理
        loadButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        loadButton.tag = ButtonTags.load.rawValue
        // 追加ボタン押下時の動作定義
        let bookAddButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.add(), style: .plain, target: self, action: #selector(buttonTapped(sender:)))
        bookAddButton.tag = ButtonTags.addbook.rawValue
        // 戻るボタンの表示内容の設定
        let backButton = UIBarButtonItem()
        backButton.title = R.string.localizable.back()
        self.navigationItem.backBarButtonItem = backButton
        // 左上部の戻るボタンを非表示
        self.navigationItem.hidesBackButton = true
        // ナビゲーションバーの右側に書籍追加ボタン付与
        self.navigationItem.setRightBarButtonItems([bookAddButton], animated: true)
        setTableView()
        setBookLineupViewLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func touchBookAddButton() {
        // 書籍追加ボタン押下時の処理を追加
        let addBookModalView = AddBookModalViewController()
        let navi = UINavigationController(rootViewController: addBookModalView) // モーダル画面でもナビゲーションバーが出るようにする
        print("書籍追加のモーダル画面をopen")
        addBookModalView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navi, animated: true, completion: nil)
    }
    
    func buttonTapped(sender: UIButton) {
        var btag = ButtonTags(rawValue: sender.tag)!
        switch btag {
        case .load:
            print("書籍をさらに読み込みます")
        case .addbook:
            print("書籍の追加を行います")
            touchBookAddButton()
        default:
            break
        }
    }
    
}

extension BookLineUpViewController: UITableViewDelegate, UITableViewDataSource {
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
    }
    
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
        print("\(indexPath.row)番目の書籍編集画面に入ります")
        let editBookViewController: EditBookViewController = EditBookViewController()
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
    func setBookLineupViewLayout() {
        automaticallyAdjustsScrollViewInsets = false
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        // TableViewがステータスバーに埋もれないよう，先頭部分を調整
        let headBarHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        let edgeInsets = UIEdgeInsets(top: headBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = edgeInsets
        tableView.scrollIndicatorInsets = edgeInsets
        
        self.view.addSubview(tableView)
        self.view.addSubview(loadButton)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        
        loadButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        loadButton.backgroundColor = UIColor.white
        loadButton.layer.borderWidth = 2.0
        loadButton.layer.borderColor = UIColor.gray.cgColor
        
        loadButton.setTitle(R.string.localizable.loadmore(), for: .normal)
        loadButton.setTitleColor(UIColor.green, for: .normal)
        loadButton.setTitle(R.string.localizable.loadmore(), for: .highlighted)
        loadButton.setTitleColor(UIColor.red, for: .highlighted)
        // 以下，NSLayoutAnchorでのレイアウト設定
        loadButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -49.0).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
