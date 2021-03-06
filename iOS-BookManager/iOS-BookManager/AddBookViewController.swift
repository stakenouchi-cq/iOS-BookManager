import UIKit
import APIKit
import Kingfisher

class AddBookViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    fileprivate let addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.addtmb(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(choosePicture), for: .touchUpInside) // ログインボタン押下時の動作
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
    
    fileprivate let purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.purchaseDate()
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
    
    fileprivate lazy var purchaseDateTextField: UIDatePickerTextField = {
        let textField = UIDatePickerTextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    fileprivate let bookImageView: UIImageView = {
        let view = UIImageView()
        view.kf.setImage(with: URL(string: "https://cdn1.iconfinder.com/data/icons/social-17/48/photos2-512.png"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.addbook()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: #selector(closeView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: #selector(saveBookData))
        
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
        
        guard let imageData = self.bookImageView.image else {
            AlertUtil.showAlert(target: self, title: R.string.localizable.failed(), message: R.string.localizable.failBookSaved(), completion: {})
            return
        }
        let data = UIImagePNGRepresentation(imageData)
        
        guard
            let name = bookNameTextField.text,
            let price = Int(bookPriceTextField.text!),
            let purchaseDate = purchaseDateTextField.text,
            let encodeString = data?.base64EncodedString()
            else {
                return
        }
        
        let request = AddBookRequest(name: name, image: encodeString, price: price, purchaseDate: purchaseDate)
        Session.send(request) { result in
            switch result {
            case .success(let responce):
                print(responce)
                AlertUtil.showAlert(target: self, title: R.string.localizable.success(), message: R.string.localizable.bookSaved(), completion: {})
            case .failure(let error):
                print(error)
                AlertUtil.showAlert(target: self, title: R.string.localizable.error(), message: R.string.localizable.failBookSaved(), completion: {})
            }
        }
    }
    
}

extension AddBookViewController: UIImagePickerControllerDelegate {
    
    func choosePicture() {
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
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
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
        self.view.addSubview(purchaseDateLabel)
        self.view.addSubview(purchaseDateTextField)
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
        purchaseDateLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor).isActive = true
        purchaseDateLabel.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor, constant: marginBtwLabels).isActive = true
        purchaseDateTextField.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        purchaseDateTextField.centerYAnchor.constraint(equalTo: purchaseDateLabel.centerYAnchor, constant: marginBtwLabForm).isActive = true
        purchaseDateTextField.widthAnchor.constraint(equalTo: bookNameTextField.widthAnchor).isActive = true
    }
    
}
