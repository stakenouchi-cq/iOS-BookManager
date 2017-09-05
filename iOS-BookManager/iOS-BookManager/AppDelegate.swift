import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
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
            print("It is the 1st launch")
            // 初回起動の場合，ログイン画面を表示
            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        } else {
            print("It is not the 1st launch")
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
