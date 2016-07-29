//
//  AppDelegate.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SSASideMenuDelegate  {
    

    var userName = "Hanako Yamada"//ここをどうして良いかわからないので、ひとまず置いておく
    var userID = "1" //ここをどうして良いかわからないので、ひとまず置いておく
    
    var photoURLArray = false
    var movieURLArray = false
    
 

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //MARK : Setup SSASideMenu
        
        var myTabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
        
        
        var howToUseView = storyboard.instantiateViewControllerWithIdentifier("HowToUseViewController") as! HowToUseViewController
        
        var assistView = storyboard.instantiateViewControllerWithIdentifier("AssistTableViewController") as! AssistTableViewController
        
        var homeNavView = storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController") as! HomeNavigationController
        
        var LeftMenuView = storyboard.instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        

        

        howToUseView.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named: "home"), tag: 1)//アイコン
        homeNavView.tabBarItem = UITabBarItem(title: "記録", image: UIImage(named: "openFolder"), tag: 2)
        assistView.tabBarItem = UITabBarItem(title: "相談", image: UIImage(named: "contact"), tag: 3)


        
        myTabBarController.setViewControllers([howToUseView,homeNavView,assistView], animated: false)
        //MARK:ここを平井先生のコメントで追加　下記のselectedIndexが起動時に表示されるVCを指定
        myTabBarController.selectedIndex=0
//        ここ変更。。var myTabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
        
        
//        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: StepViewController()), leftMenuViewController: LeftMenuViewController())ここを下記のように変更
        let sideMenu = SSASideMenu(contentViewController: myTabBarController, leftMenuViewController: LeftMenuView)
        sideMenu.backgroundImage = UIImage(named: "wall.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.blackColor(), opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
       
        
        return true
    }
    
    func sideMenuWillShowMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Will Show \(menuViewController)")
    }
    
    func sideMenuDidShowMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Did Show \(menuViewController)")
    }
    
    func sideMenuDidHideMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Did Hide \(menuViewController)")
    }
    
    func sideMenuWillHideMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Will Hide \(menuViewController)")
    }
    func sideMenuDidRecognizePanGesture(sideMenu: SSASideMenu, recongnizer: UIPanGestureRecognizer) {
        print("Did Recognize PanGesture \(recongnizer)")
    }
    

       
    //上までsideBar
    
   
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

