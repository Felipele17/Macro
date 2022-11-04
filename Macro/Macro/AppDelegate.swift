import UIKit
import CoreData
import CloudKit
import OSLog

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.registerForRemoteNotifications()
        
        let option: UNAuthorizationOptions = []
        UNUserNotificationCenter.current().requestAuthorization(options: option) {_, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        // Create a scene configuration object for the
        // specified session role.
        let config = UISceneConfiguration(name: nil,
            sessionRole: connectingSceneSession.role)

        // Set the configuration's delegate class to the
        // scene delegate that implements the share
        // acceptance method.
        config.delegateClass = SceneDelegate.self

        return config
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("pushNotification")
        if let notification = CKNotification(fromRemoteNotificationDictionary: userInfo) {
            completionHandler(.newData)
            if let subscriptionID = notification.subscriptionID {
                let enumPushNotifications = EnumPushNotifications(rawValue: subscriptionID)
                switch enumPushNotifications {
                case .share:
                    Task {
                        print("isSendInviteAccepted")
                        let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
                        DispatchQueue.main.async {
                           Invite.shared.isSendInviteAccepted = isSendInviteAccepted
                       }
                    }
                case .goal:
                    print("goal notification")
                    ObservableDataBase.shared.needFetchGoal = true
                case .spent:
                    print("spent notification")
                    ObservableDataBase.shared.needFetchSpent = true
                case .none:
                    print("none")
                }
            }
        }
        
    }
       
}
