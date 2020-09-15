//
//  AppDelegate.swift
//  appdocu
//
//  Created by thuylinh on 7/8/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//
import UIKit
import  Firebase
import  FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var homeviewcontroller: HomeViewController!
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        if Auth.auth().currentUser != nil {
            self.gototabbar()
        } else {
            self.gotoOnboarding()
        }
        window?.makeKeyAndVisible()
        return true
    }
    func gotoHome() {
        UIView.transition(with: self.window!, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            let viewController = HomeDetailsViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
        }, completion: nil)
    }
    func gotoOnboarding() {
        UIView.transition(with: self.window!, duration: 0.3, options: [], animations: {
            let v1 = LaucherAppViewController()
            let navi = UINavigationController(rootViewController: v1)
            self.window?.rootViewController = navi
            
        }, completion: nil)
        
    }
    func gotoSignup() {
        let SignupController = SignupViewController()
        let navigationController = UINavigationController(rootViewController: SignupController)
        self.window?.rootViewController = navigationController
    }
    
    func gotoSignin() {
           let SigninViewController = LoginViewController()
           let navigationController = UINavigationController(rootViewController: SigninViewController)
           self.window?.rootViewController = navigationController
    }
    
    func gototabbar() {
        let tabBarController = UITabBarController()
        let tabViewController2 = MenuViewController()
        let tabViewController3 = PostViewController()
        let tabViewController4 = ProfileUserViewController()
        self.homeviewcontroller = HomeViewController()
        let navi1 = UINavigationController(rootViewController: homeviewcontroller)
        let navi2 = UINavigationController(rootViewController: tabViewController2)
        let navi3 = UINavigationController(rootViewController: tabViewController3)
        let navi4 = UINavigationController(rootViewController: tabViewController4)
        
        navi1.navigationBar.isTranslucent = false
        navi2.navigationBar.isTranslucent = true
        navi3.navigationBar.isTranslucent = false
        navi4.navigationBar.isTranslucent = false
        
        
        
        let controllers = [navi1,navi2,navi3, navi4]
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.9564440846, green: 0.6086999774, blue: 0.2464883327, alpha: 1)
        tabBarController.viewControllers = controllers
        
        navi1.tabBarItem = UITabBarItem(title: "",image: UIImage(named: "home1"),tag: 1)
        navi2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), tag: 2)
        navi3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "upload"), tag: 3)
        navi4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "user1"), tag: 4)
        self.window?.rootViewController = tabBarController
    }
}

