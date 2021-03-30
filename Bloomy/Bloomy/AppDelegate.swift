//
//  AppDelegate.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 12/11/20.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupStyles()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.setInitalViewController()
        
        /*
         * Conecta o Firebase quando o app for inicializado
         * Descomentar a linha a baixo para enviar informações para o Firebase
         */
        
        //FirebaseApp.configure()
        
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Bloomy")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Elements global style
    
    private func setupStyles() {
        self.setupPageControlStyle()
        self.setupTabBarStyle()
        self.setupNagivationBarStyle()
    }
    
    private func setupNagivationBarStyle() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for:.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().topItem?.title = ""
        UINavigationBar.appearance().backItem?.title = ""
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    private func setupPageControlStyle() {
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2431372549, green: 0.2470588235, blue: 0.2745098039, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    private func setupTabBarStyle() {
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2431372549, green: 0.2470588235, blue: 0.2745098039, alpha: 1)
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    // MARK: - Window auxiliars
    
    private func setInitalViewController() {
        let defaults = UserDefaults.standard
        let didUserSelectedIslands = defaults.bool(forKey: DefaultsConstants.auxiliarToRootWindow.rawValue)
        
        if (UserManager.shared.getUser() == nil || !didUserSelectedIslands) {
            self.window?.rootViewController = OnboardingContainerViewController()
        } else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()!
            self.window?.rootViewController = initialViewController
        }
    }
}
