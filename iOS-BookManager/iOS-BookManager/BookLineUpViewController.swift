import UIKit
import APIKit
import Himotoki

class BookLineUpViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var books = [Book]()
    fileprivate let limit = 3
    fileprivate var page = 1

    fileprivate let loadButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.loadmore(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loadMoreBooks), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var bookTableView: UITableView = {
        let tableView = UITableView()
        let tabBarHeight: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - tabBarHeight)
        tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        return tableView
    }()
    
    fileprivate let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = R.string.localizable.back()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // ナビゲーションバーのタイトルを設定
        self.navigationItem.title = R.string.localizable.booklineup()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.add(), style: .plain, target: self, action: #selector(addBook))
        
        setBookLineupViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 他画面から戻ってきた後は，ページ番号を振り出しに戻す
        self.page = 1
        self.books = []
        self.bookTableView.reloadData()
        loadBookData(page: self.page) // 1ページ目の書籍リストのみ取得
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func loadBookData(page: Int) {
        let request = GetBookRequest(limit: limit, page: page)
        Session.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
                self.books.append(contentsOf: response.result) // 要素を複数個appendするので，contentsOfを使う
                self.bookTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreBooks() {
        // 「もっと読み込む」ボタンを押下時に，読み込む書籍を追加
        self.page += 1
        loadBookData(page: self.page)
    }

    func addBook() {
        // 書籍追加ボタン押下時の処理を追加
        let addBookViewController = AddBookViewController()
        let navi = UINavigationController(rootViewController: addBookViewController) // モーダル画面でもナビゲーションバーが出るようにする
        print("Open add book screen.")
        addBookViewController.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
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
    
}

extension BookLineUpViewController {
    
    fileprivate func setBookLineupViewLayout() {
        self.view.addSubview(bookTableView)
        self.view.addSubview(loadButton)
        
        let tabBarHeight: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        
        loadButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1.0*tabBarHeight).isActive = true
        loadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
