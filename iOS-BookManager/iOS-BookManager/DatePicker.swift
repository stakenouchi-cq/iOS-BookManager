import UIKit

// TextFieldをタップすると，DatePickerとして起動します
class UIDatePickerTextField: UITextField, UITextFieldDelegate, UIPickerViewDelegate {
    
    fileprivate var datePicker = UIDatePicker()
    fileprivate let dateFormatter: DateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged) // 値が変わったら関数を呼び出す
        datePicker.datePickerMode = .date // 年月日でPickerを表示
        self.inputView = datePicker
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let selectedDate: NSString = dateFormatter.string(from: sender.date) as NSString
        self.text = selectedDate as String
    }
    
}
