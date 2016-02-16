import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    enum ShortcutType: String {
        case View1 = "br.com.lucascaton.first"
        case View2 = "br.com.lucascaton.second"
    }
    
    var window: UIWindow?
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var launchedFromShortCut = false

        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedFromShortCut = true
            handleShortCutItem(shortcutItem)
        }
        
        // Returns false if application was lanched from shorcut to prevent
        // application(_:performActionForShortcutItem:completionHandler:) from being called
        return !launchedFromShortCut
    }

    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }

    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false

        if let shortcutType = ShortcutType.init(rawValue: shortcutItem.type) {
            // Get root navigation viewcontroller and its first controller
            let rootNavigationViewController = window!.rootViewController as? UINavigationController
            let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?

            // Pop to root view controller so that approperiete segue can be performed
            rootNavigationViewController?.popToRootViewControllerAnimated(false)

            switch shortcutType {
            case .View1:
                handled = true
            case.View2:
                rootViewController?.performSegueWithIdentifier("toView2", sender: nil)
                handled = true
            }
        }

        return handled
    }
}