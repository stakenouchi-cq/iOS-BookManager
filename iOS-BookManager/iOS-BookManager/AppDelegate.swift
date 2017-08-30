import UIKit
import APIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // 画面間でデータを受け渡す
    var price: Int? // 価格
    var boughtDate: String? // 購入日
    var imagePath: String? // 書籍のサムネイルへのパス
    var title: String? // 本のタイトル
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 初回起動のチェック
        let userDefault = UserDefaults.standard
        // 以下，初期化処理
        let dict = ["firstLaunch": true]
        userDefault.register(defaults: dict)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        if userDefault.bool(forKey: "firstLaunch") {
            userDefault.set(false, forKey: "firstLaunch")
            print("このアプリの初回起動です")
            // 初回起動の場合，ログイン画面を表示
            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        } else {
            print("初回起動ではございません")
            // 初回でない場合，書籍一覧表を表示
            self.window?.rootViewController = TabBarController()
        }
        
        // 戻るボタンの矢印画像を非表示
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}
