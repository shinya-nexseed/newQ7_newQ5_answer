//
//  ContactViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/07/08.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var contMenuBtn: UIImageView!
    @IBOutlet weak var contCoverBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        super.didReceiveMemoryWarning()
        
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        
        //sideBar向け
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        
        contMenuBtn.image = UIImage(named:"menu")?.imageWithRenderingMode(.AlwaysTemplate)
        contMenuBtn.tintColor = UIColor.whiteColor()
        
        self.contCoverBtn.addTarget(SSASideMenu(), action: Selector("presentLeftMenuViewController"), forControlEvents: UIControlEvents.TouchUpInside)
        

    }

    override func didReceiveMemoryWarning() {
        
        

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
