//
//  LeftMenuViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/15.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import Foundation
import UIKit

class LeftMenuViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.frame = CGRectMake(20, (self.view.frame.size.height - 54 * 5) / 2.0, self.view.frame.size.width, 54 * 5)
        tableView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.opaque = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let titles: [String] = ["ホーム","設定", "基本対策", "コンタクト", "利用規約","ログアウト"]
        
//        let images: [String] = ["IconSettings", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 19)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .None
//        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.row {
        case 0:
            
            //sideMenuViewController?.contentViewController = UINavigationController(rootViewController: StepViewController())
            
            
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
            //MARK:下記を追加。AppDelegateの同じ箇所５０行目あたりと同様の対処。
            myTabBarController.selectedIndex = 0
           
            
            sideMenuViewController?.contentViewController = myTabBarController
            
            sideMenuViewController?.hideMenuViewController()
            
            break
        
        
        case 1:
            
            var settingView = storyboard.instantiateViewControllerWithIdentifier("SettingViewController") as! SettingViewController
            
            sideMenuViewController?.contentViewController =  settingView
            sideMenuViewController?.hideMenuViewController()
            break

        
        case 2:
            
            var stepView = storyboard.instantiateViewControllerWithIdentifier("StepViewController") as! StepViewController
            
            sideMenuViewController?.contentViewController =  stepView
            sideMenuViewController?.hideMenuViewController()
            break
            
        
        case 2:
            
            var settingView = storyboard.instantiateViewControllerWithIdentifier("SettingViewController") as! SettingViewController
            
            sideMenuViewController?.contentViewController =  settingView
            sideMenuViewController?.hideMenuViewController()
            break


        case 3:
            
            var contactView = storyboard.instantiateViewControllerWithIdentifier("ContactViewController") as! ContactViewController
            
            sideMenuViewController?.contentViewController =  contactView
            sideMenuViewController?.hideMenuViewController()
            break
            
            
        case 4:
            
            var TOUView = storyboard.instantiateViewControllerWithIdentifier("TOUViewController") as! TOUViewController
            
            sideMenuViewController?.contentViewController =  TOUView
            sideMenuViewController?.hideMenuViewController()
            break

        
        default:
            break
        }
        
        
    }
    
}

