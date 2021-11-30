//
//  AppDelegate.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/02.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        guard let bundleURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist") else {
            return false
        }
        let documentPlistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
        
        if !FileManager.default.fileExists(atPath: documentPlistURL.path) {
            do {
                try FileManager.default.copyItem(at: bundleURL, to: documentPlistURL)
            } catch let error {
                print("ERROR", error.localizedDescription)
            }
        }
        
        let beforeDocumentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let PathWithFolderName = beforeDocumentURL.appendingPathComponent("UserImage").path
        
        if !FileManager.default.fileExists(atPath: PathWithFolderName)
        {
            try! FileManager.default.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        reloadwidgetData()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

