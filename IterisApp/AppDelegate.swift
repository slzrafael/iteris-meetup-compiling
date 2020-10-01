import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Iteris Anywhere and Together"

        vc.view.addSubview(label)

        label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

        return true
    }
}