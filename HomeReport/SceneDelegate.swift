//
//  SceneDelegate.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        checkDataStore()
        guard let rootTabBarController = window?.rootViewController as? UITabBarController,
              let homeListNavigationController = rootTabBarController.viewControllers?.first as? UINavigationController,
              let summaryNavigationController = rootTabBarController.viewControllers?[1] as? UINavigationController,
              let homeListViewController = homeListNavigationController.viewControllers.first as? HomeListViewController,
              let summaryTableViewController = summaryNavigationController.viewControllers.first as? SummaryTableViewController  else { return }
        let managedObjectContext = coreData.persistentContainer.viewContext
        homeListViewController.managedObjectContext = managedObjectContext
        summaryTableViewController.managedObjectContext = managedObjectContext
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
        coreData.saveContext()
    }

    private func checkDataStore() {
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        
        let moc = coreData.persistentContainer.viewContext
        
        do {
            let mocCount = try moc.count(for: request)
            if mocCount == 0 {
                uploadSampleData()
            }
        } catch {
            fatalError("Error in counting home record")
        }
    }
    
    private func uploadSampleData() {
        
    }

}

