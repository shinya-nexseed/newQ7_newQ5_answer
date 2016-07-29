//
//  SelectViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/07/04.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController,QBImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var obj = QBImagePickerController()
        obj.delegate = self
        
        presentViewController(obj, animated: true, completion: nil)
    }
//    
//    func qb_imagePickerController(imagePickerController: QBImagePickerController, didFinishPickingAssets assets: [NSURL]) {
//        for asset: PHAsset in assets {
//            
//        }
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }

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
