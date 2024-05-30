//
//  SceneDelegate.swift
//  appleScreenTimeApp
//
//  Created by apple on 5/30/24.
//

import UIKit

 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//
//
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//               window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//
//        let mainView = ViewController() //Vi
//               window?.windowScene = windowScene
//        window?.rootViewController = mainView
//               window?.makeKeyAndVisible()
//
//
//        let nav1 = UINavigationController()
//
//        nav1.viewControllers = [mainView]
//
//        self.window?.makeKeyAndVisible()
//    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        let mainView = ViewController()
        let navController = UINavigationController(rootViewController: mainView)
        
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    func promptForScreenTimeAccess() {
            let alert = UIAlertController(
                title: "Screen Time Access Required",
                message: "This app needs Screen Time access to function properly. Please enable it in the Settings.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            if let topController = window?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

