//
//  HomeNavigationController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/09.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //高さを変更する
        self.navigationBar.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width, 65)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()
        ]
        
        
        
        // addBtnを設置 このやり方だとframeが使えない。UIButtonを使ってからじゃないとNavBarに設置できない
//        var addBtn = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "onClick")
//        
//        self.navigationItem.rightBarButtonItem = addBtn
        
        
        
        
        
        //      let rightButton = UIButton()　これではダメ。
//        let rightButton = UIButton(type: UIButtonType.System)
//        
//        rightButton.frame = CGRectMake(myBoundsize.width-18, 30, 25, 25)
//        rightButton.setImage(UIImage(named:"create"), forState: UIControlState.Normal)
//        rightButton.addTarget(self, action: "rightNavItemEditClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
//        self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
//        
        
//        rightButton.tintColor = UIColor.whiteColor()

        
        
        
        
        
        
        
    }
    
    //画面遷移後の呼び出しメソッド
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        self.navigationBar.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width, 65)
        
        //ナビゲーションバーの背景画像を設定する。
//        self.navigationBar.setBackgroundImage(UIImage(named: "bgImage.JPG"), forBarMetrics: .Default)
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
//        
        self.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
        
        
    

        
        self.navigationBar.barTintColor = sakura
//        self.navigationBar.items.
        //ナビゲーションバーのシャドウイメージを設定する。
//        self.navigationBar.shadowImage = UIImage(named: "mokume_test2.png")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
