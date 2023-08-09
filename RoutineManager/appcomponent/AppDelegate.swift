//
//  AppDelegate.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    private let navigator = Navigator()
    
    private let appComponent = AppComponent()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.checkNotificationPermission()
        return true
    }
    
    
    public func getNavigator() -> Navigator{
        return self.navigator
    }
    
    public func getAppComponent() -> AppComponent{
        return appComponent
    }



    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    
    private func checkNotificationPermission(){
        self.appComponent.getNotificationUtil().checkNotificationPermission {
            DispatchQueue.main.async {
                self.handleDisabledPermission()
            }
        }
    }
    
    private func handleDisabledPermission(){
    
        
        guard let sd : SceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate),
              let window = sd.window , let rootViewController = window.rootViewController else {
            return
        }
        
        let alert = self.appComponent.getAlertUtil().getPermissionAlert()
        rootViewController.blurEffect()
        rootViewController.present(alert, animated: true)
    }

}

