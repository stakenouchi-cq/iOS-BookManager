import UIKit

extension DateFormatter {
    func adaptToForm() {
        self.dateFormat = "yyyy/MM/dd"
        self.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
    }
}
