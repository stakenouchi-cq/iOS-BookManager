import UIKit

class AddBookViewController: UIViewController,  UINavigationControllerDelegate {
    
    let addImageButton = UIButton() // 書籍画像添付ボタン
    let bookNameLabel = UILabel()
    let bookNameTextField = UITextField()
    let bookPriceLabel = UILabel()
    let bookPriceTextField = UITextField()
    let boughtDateLabel = UILabel()
    let boughtDateTextField = UIDatePickerTextField()
    // 写真を表示するビュー
    var bookImage: UIImage?
    var bookImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        self.navigationItem.title = R.string.localizable.addbook()
        
        let closeButton = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: #selector(buttonTapped(sender:)))
        closeButton.tag = ButtonTags.close.rawValue
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        
        let saveButton = UIBarButtonItem(title: R.string.localizable.save(), style: .plain, target: self, action: #selector(saveBookData(sender:)))
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        bookImage = UIImage(named: "no_image.png")
        bookImageView = UIImageView(image: bookImage)
        
        saveButton.tag = ButtonTags.save.rawValue
        addImageButton.tag = ButtonTags.addtmb.rawValue
        
        setTextViewRules()
        setAddBookViewLayout()
        
    }
    
    // ボタン押下時の分岐
    func buttonTapped(sender: UIButton) {
        var btag = ButtonTags(rawValue: sender.tag)!
        switch btag {
        case .close:
            print("書籍追加画面を閉じます")
            self.dismiss(animated: true, completion: nil)
        case .save:
            print("書籍データを保存しました")
        case .addtmb:
            print("画像登録を行います")
            choosePicture()
        default:
            break
        }
    }
    
    func saveBookData(sender: UIBarButtonItem){
        print("書籍情報を保存しました")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AddBookViewController: UIImagePickerControllerDelegate {
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
        self.bookImageView?.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
}

extension AddBookViewController {
    // キーボード入力終了のルールを定義
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
}

extension AddBookViewController: UITextFieldDelegate {
    func setTextViewRules() {
        // 入力フォームの自動補完およびShiftキーを無効化
        bookNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        bookPriceTextField.autocapitalizationType = UITextAutocapitalizationType.none
        boughtDateTextField.autocapitalizationType = UITextAutocapitalizationType.none
        bookNameTextField.autocorrectionType = UITextAutocorrectionType.no
        bookPriceTextField.autocorrectionType = UITextAutocorrectionType.no
        boughtDateTextField.autocorrectionType = UITextAutocorrectionType.no
        bookNameTextField.returnKeyType = .done
        bookPriceTextField.returnKeyType = .done
        boughtDateTextField.returnKeyType = .done
        
        // 価格は，数字のみ入力できるようにする
        bookPriceTextField.keyboardType = .numberPad
        
        // ラベルの中身をセット
        bookNameLabel.text = R.string.localizable.bookname()
        bookPriceLabel.text = R.string.localizable.price()
        boughtDateLabel.text = R.string.localizable.boughtdate()
        // フォームの初期値をセット
        bookNameTextField.text = ""
        bookPriceTextField.text = ""
        boughtDateTextField.text = ""
        
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bookPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bookPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        boughtDateLabel.translatesAutoresizingMaskIntoConstraints = false
        boughtDateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // ツールバーを定義
        bookNameTextField.delegate = self as? UITextFieldDelegate
        bookPriceTextField.delegate = self as? UITextFieldDelegate
        boughtDateTextField.delegate = self as? UITextFieldDelegate
    }
}

extension AddBookViewController {
    func setAddBookViewLayout() {
        self.view.addSubview(bookImageView!)
        self.view.addSubview(bookNameLabel)
        self.view.addSubview(bookNameTextField)
        self.view.addSubview(bookPriceLabel)
        self.view.addSubview(bookPriceTextField)
        self.view.addSubview(boughtDateLabel)
        self.view.addSubview(boughtDateTextField)
        self.view.addSubview(addImageButton)
        
        bookNameTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        bookPriceTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        boughtDateTextField.frame = CGRect(x: 0,y: 0,width: 200,height: 30)
        
        bookImageView?.frame = CGRect(x: self.view.frame.width*0.1, y: self.view.frame.height*(4/30), width: self.view.frame.width*0.3, height: self.view.frame.height*0.2)
        bookImageView?.layer.borderColor = UIColor.cyan.cgColor
        bookImageView?.layer.borderWidth = 2.5
        
        bookNameTextField.borderStyle = UITextBorderStyle.roundedRect
        bookPriceTextField.borderStyle = UITextBorderStyle.roundedRect
        boughtDateTextField.borderStyle = UITextBorderStyle.roundedRect
        
        addImageButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside) // ボタン押下時の動作
        addImageButton.frame = CGRect(x: 170, y: 115, width: 120, height: 60) // ボタン枠サイズの設定
        addImageButton.setTitle(R.string.localizable.addtmb(), for: .normal)
        addImageButton.setTitleColor(UIColor.white, for: .normal)
        addImageButton.setTitle(R.string.localizable.addtmb(), for: .highlighted)
        addImageButton.setTitleColor(UIColor.black, for: .highlighted)
        addImageButton.backgroundColor = UIColor.blue // 背景色
        addImageButton.layer.borderWidth = 2.0 // 枠線の幅
        addImageButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        // アドレスと入力フォーム類の位置設定
        let marginBtwLabTextField: CGFloat = 5.0
        let marginBtwLabels: CGFloat = self.view.frame.height*0.1
        
        bookImageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width*0.1).isActive = true
        bookImageView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (2/30)*self.view.frame.height).isActive = true
        bookImageView?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        bookImageView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        
        bookNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookNameLabel.topAnchor.constraint(equalTo: (self.bookImageView?.bottomAnchor)!, constant: 50).isActive = true
        bookNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookNameTextField.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        bookPriceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookPriceLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        bookPriceTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bookPriceTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        bookPriceTextField.topAnchor.constraint(equalTo: bookPriceLabel.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        
        boughtDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boughtDateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        boughtDateLabel.topAnchor.constraint(equalTo: bookPriceLabel.bottomAnchor, constant: marginBtwLabels).isActive = true
        
        boughtDateTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boughtDateTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        boughtDateTextField.topAnchor.constraint(equalTo: boughtDateLabel.bottomAnchor, constant: marginBtwLabTextField).isActive = true
        
        addImageButton.centerYAnchor.constraint(equalTo: (bookImageView?.centerYAnchor)!).isActive = true
        addImageButton.leftAnchor.constraint(equalTo: (bookImageView?.rightAnchor)!, constant: 10.0).isActive = true
    }
}
