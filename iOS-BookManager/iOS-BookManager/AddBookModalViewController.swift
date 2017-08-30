import UIKit

class AddBookModalViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let addImageButton = UIButton() // 書籍画像添付ボタン
    
    let bookNameLabel = UILabel()
    @IBOutlet weak var bookNameTextField: UITextField!
    let bookPriceLabel = UILabel()
    @IBOutlet weak var bookPriceTextField: UITextField!
    let boughtDateLabel = UILabel()
    @IBOutlet weak var boughtDateTextField: UITextField!
    
    // 写真を表示するビュー
    var bookImage: UIImage?
    var bookImageView: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面のサイズを取得
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.view.backgroundColor = UIColor.white
        
        // ナビゲーションバーの表示
        self.navigationController?.navigationBar // ナビゲーションバーを取得
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ナビゲーションバーを表示
        
        let navigationBarTiltle = NSLocalizedString("addbook", comment: "")
        self.navigationItem.title = navigationBarTiltle
        
        let closeTitle = NSLocalizedString("close", comment: "")
        let closeButton = UIBarButtonItem(title: closeTitle, style: .plain, target: self, action: #selector(onClick(sender:)))
        closeButton.tag = 0
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        
        let saveTitle = NSLocalizedString("save", comment: "")
        let saveButton = UIBarButtonItem(title: saveTitle, style: .plain, target: self, action: #selector(onClick(sender:)))
        saveButton.tag = 1
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        bookImage = UIImage(named: "no_image.png")
        bookImageView = UIImageView(image: bookImage)
        bookImageView?.frame = CGRect(x: displayWidth*0.1, y: displayHeight*(4/30), width: displayWidth*0.3, height: displayHeight*0.2)
        bookImageView?.layer.borderColor = UIColor.cyan.cgColor
        bookImageView?.layer.borderWidth = 2.5
        
        let addTmbTiltle = NSLocalizedString("addtmb", comment: "")
        let addImageText: String = addTmbTiltle
        addImageButton.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside) // ボタン押下時の動作
        addImageButton.frame = CGRect(x: 170, y: 115, width: 120, height: 60) // ボタン枠サイズの設定
        addImageButton.setTitle(addImageText, for: .normal)
        addImageButton.setTitleColor(UIColor.white, for: .normal)
        addImageButton.setTitle(addImageText, for: .highlighted)
        addImageButton.setTitleColor(UIColor.black, for: .highlighted)
        addImageButton.backgroundColor = UIColor.blue // 背景色
        addImageButton.layer.borderWidth = 2.0 // 枠線の幅
        addImageButton.layer.borderColor = UIColor.cyan.cgColor // 枠線の色
        addImageButton.tag = 2
        
        bookNameTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        bookPriceTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        boughtDateTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        
        bookNameTextField.borderStyle = UITextBorderStyle.roundedRect
        bookPriceTextField.borderStyle = UITextBorderStyle.roundedRect
        boughtDateTextField.borderStyle = UITextBorderStyle.roundedRect
        
        // 各TextFieldにタグを制定
        bookNameTextField.tag = 1
        bookPriceTextField.tag = 2
        boughtDateTextField.tag = 3
        
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
        
        let bookNameTitle = NSLocalizedString("bookname", comment: "")
        let bookPriceTitle = NSLocalizedString("price", comment: "")
        let boughtDateTitle = NSLocalizedString("boughtdate", comment: "")
        
        
        // ラベルの中身をセット
        bookNameLabel.text = bookNameTitle
        bookPriceLabel.text = bookPriceTitle
        boughtDateLabel.text = boughtDateTitle
        // フォームの初期値をセット
        bookNameTextField.text = ""
        bookPriceTextField.text = ""
        boughtDateTextField.text = ""
        
        // closeButton.center = self.view.center
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bookPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bookPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        boughtDateLabel.translatesAutoresizingMaskIntoConstraints = false
        boughtDateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // ツールバーを定義
        
        self.view.addSubview(bookImageView!)
        self.view.addSubview(bookNameLabel)
        self.view.addSubview(bookNameTextField)
        self.view.addSubview(bookPriceLabel)
        self.view.addSubview(bookPriceTextField)
        self.view.addSubview(boughtDateLabel)
        self.view.addSubview(boughtDateTextField)
        self.view.addSubview(addImageButton)
        
        bookNameTextField.delegate = self as? UITextFieldDelegate
        bookPriceTextField.delegate = self as? UITextFieldDelegate
        boughtDateTextField.delegate = self as? UITextFieldDelegate
        
        // アドレスと入力フォーム類の位置設定
        
        let marginBtwLabTextField: CGFloat = 5.0
        let marginBtwLabels: CGFloat = displayHeight*0.1
        
        bookImageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: displayWidth*0.1).isActive = true
        bookImageView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (2/30)*displayHeight).isActive = true
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1,2:
            return
        case 3:
            print("日付編集します")
            dateEditing(sender: textField)
        default:
            break
        }
    }
    
    func dateEditing(sender: UITextField){

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        boughtDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Enter押したら入力おしまい
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // キーボードの外に触れたら入力おしまい
    }
    
    // ボタン押下時の分岐
    func onClick(sender: UIButton){
        switch sender.tag {
        case 0:
            print("書籍追加画面を閉じます")
            self.dismiss(animated: true, completion: nil)
        case 1:
            print("書籍データを保存しました")
            break
        case 2:
            print("画像登録を行います")
            choosePicture()
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
