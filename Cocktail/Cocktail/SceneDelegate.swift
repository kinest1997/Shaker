//
//  SceneDelegate.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let bundleURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist") else {
                    return
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
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = MainViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

