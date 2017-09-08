import UIKit

struct AlertUtil {
    static func showAlert(target: UIViewController, title: String, message: String, completion: (() -> Void)!) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style: .cancel, handler:{(action:UIAlertAction!) -> Void in completion()})
        alert.addAction(okAction)
        target.present(alert, animated: true, completion: nil)
    }
}

