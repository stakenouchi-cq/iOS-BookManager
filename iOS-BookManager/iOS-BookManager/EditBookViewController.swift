import UIKit

class EditBookViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    let tabBarHeight = CGFloat(49)
    
    // フォームの初期値をセット
    // 親クラスから値渡しをする
    var book: Book! {
        didSet {
            // selfは省略可なので，省略
            bookNameTextField.text = book.name
            bookPriceTextField.text = String(book.price)
            boughtDateTextField.text = book.boughtDate
            bookImage = UIImage(named: book.imagePath)!
        }
    }
    
    let addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.addtmb(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "addThumbnail", for: .touchUpInside) // ログインボタン押下時の動作
        return button
    }()
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.bookname()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.price()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let boughtDateLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.boughtdate()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    lazy var bookNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    lazy var bookPriceTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    lazy var boughtDateTextField: UIDatePickerTextField = {
        let textField = UIDatePickerTextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    let bookImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
    var bookImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.editbook()
        
        bookImageView.image = bookImage
        setEditBookView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: "saveBookData")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    func saveBookData() {
        print("Datas of the book are saved.")
    }
    
    func addThumbnail() {
        // 書籍の画像を登録
        print("Choose book image.")
        choosePicture()
    }
    
}

extension EditBookViewController: UIImagePickerControllerDelegate {
    func choosePicture() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            if let popover = picker.popoverPresentationController {
                popover.sourceView = self.view
                popover.sourceRect = self.view.frame
                popover.permittedArrowDirections = UIPopoverArrowDirection.any
            }
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // ビューに表示する
        self.bookImageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
}

extension EditBookViewController {
    func setEditBookView() {
        
        // アドレスと入力フォーム類の位置設定
        self.view.addSubview(bookImageView)
        self.view.addSubview(bookNameLabel)
        self.view.addSubview(bookNameTextField)
        self.view.addSubview(bookPriceLabel)
        self.view.addSubview(bookPriceTextField)
        self.view.addSubview(boughtDateLabel)
        self.view.addSubview(boughtDateTextField)
        self.view.addSubview(addImageButton)
        
        let marginBtwLabTextField = CGFloat(30.0)
        let marginBtwLabels = CGFloat(self.view.frame.height*0.1)
        
        bookImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        bookImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        bookImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        addImageButton.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor).isActive = true
        addImageButton.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15.0).isActive = true
        addImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
        bookNameLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        bookNameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 20.0).isActive = true
        bookNameTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        bookNameTextField.centerYAnchor.constraint(equalTo: bookNameLabel.centerYAnchor, constant: marginBtwLabTextField).isActive = true
        bookNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor).isActive = true
        bookPriceLabel.centerYAnchor.constraint(equalTo: bookNameLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        bookPriceTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        bookPriceTextField.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor, constant: marginBtwLabTextField).isActive = true
        bookPriceTextField.widthAnchor.constraint(equalTo: bookNameTextField.widthAnchor).isActive = true
        boughtDateLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor).isActive = true
        boughtDateLabel.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        boughtDateTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        boughtDateTextField.centerYAnchor.constraint(equalTo: boughtDateLabel.centerYAnchor, constant: marginBtwLabTextField).isActive = true
        boughtDateTextField.widthAnchor.constraint(equalTo: bookNameTextField.widthAnchor).isActive = true
        
    }
    
}
