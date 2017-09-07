import UIKit

extension DateFormatter {
    func adaptToLocale() {
        self.dateFormat = "yyyy/MM/dd"
        self.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
    }
}

func adaptToForm(date: String) -> String {
    return date.replacingOccurrences(of: "-", with: "/")
}
