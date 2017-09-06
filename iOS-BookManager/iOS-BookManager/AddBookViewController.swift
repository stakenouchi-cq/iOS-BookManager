import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    fileprivate let addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.addtmb(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "addThumbnail", for: .touchUpInside) // ログインボタン押下時の動作
        return button
    }()
    
    fileprivate let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.bookname()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.price()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let boughtDateLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.boughtdate()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate lazy var bookNameTextField: UITextField = {
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
    
    fileprivate lazy var bookPriceTextField: UITextField = {
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
    
    fileprivate lazy var boughtDateTextField: UIDatePickerTextField = {
        let textField = UIDatePickerTextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    fileprivate let bookImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
    fileprivate var bookImage = UIImage(named: "no_image.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.addbook()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: "saveBookData")
        
        bookImageView.image = bookImage
        setAddBookView()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    func closeView() {
        print("Close add book screen.")
        self.dismiss(animated: true, completion: nil)
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

extension AddBookViewController: UIImagePickerControllerDelegate {
    
    fileprivate func choosePicture() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = .popover
            picker.delegate = self
            picker.sourceType = .photoLibrary
            
            if let popover = picker.popoverPresentationController {
                popover.sourceView = self.view
                popover.sourceRect = self.view.frame
                popover.permittedArrowDirections = .any
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

extension AddBookViewController {
    fileprivate func setAddBookView() {
        // アドレスと入力フォーム類の位置設定
        self.view.addSubview(bookImageView)
        self.view.addSubview(bookNameLabel)
        self.view.addSubview(bookNameTextField)
        self.view.addSubview(bookPriceLabel)
        self.view.addSubview(bookPriceTextField)
        self.view.addSubview(boughtDateLabel)
        self.view.addSubview(boughtDateTextField)
        self.view.addSubview(addImageButton)
        
        let marginBtwLabForm = CGFloat(30.0)
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
        bookNameTextField.centerYAnchor.constraint(equalTo: bookNameLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        bookNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor).isActive = true
        bookPriceLabel.centerYAnchor.constraint(equalTo: bookNameLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        bookPriceTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        bookPriceTextField.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        bookPriceTextField.widthAnchor.constraint(equalTo: bookNameTextField.widthAnchor).isActive = true
        boughtDateLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor).isActive = true
        boughtDateLabel.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        boughtDateTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        boughtDateTextField.centerYAnchor.constraint(equalTo: boughtDateLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        boughtDateTextField.widthAnchor.constraint(equalTo: bookNameTextField.widthAnchor).isActive = true
    }
    
}
