//
//  AddWhereViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/27.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class AddWhereViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var placeTextField: UITextField!

    @IBOutlet weak var cancelBtn: UIButton!

    
    var placeList = ["日吉協生館３階ミーティングルーム","日吉協生館委員長室","荻窪自宅"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         placeTextField.becomeFirstResponder()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        //履歴全件削除の設定 1回使ったらコメントアウト
//                var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
//                myDefault.removePersistentDomainForName(appDomain)
//        
//                myDefault.removeObjectForKey("diary")
//                myDefault.synchronize()
        
        
        if(myDefault.objectForKey("placeList") != nil){
            //データを呼び出して
            placeList = myDefault.objectForKey("placeList") as! Array
            }
            print(placeList)
        }

    
    
    //行数を設定する
    
    func tableView (tableView:UITableView, numberOfRowsInSection section:Int)->Int{
        return placeList.count
    }
    
    
    //行の中身を設定する
    func tableView (tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "whereCell")
        //cell.textLabel!.text = "\(indexPath.row)行目"
        
        //文字色を茶色にする
        cell.textLabel?.textColor = UIColor.grayColor()
        
        
        var place = placeList[indexPath.row] as! String
        
        cell.textLabel?.text = "\(place)"
        
        return cell
    }
    
    //行を選択した時の処理
        func tableView (tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)を選択")
        
            var place = placeList[indexPath.row]
            
            //ユーザーデフォルトを用意する
            var myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            myDefault.setObject(place, forKey: "selectedPlace")
            
            //即反映させる
            myDefault.synchronize()
            
            self.view.endEditing(true)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    
    //セルの削除許可を与える
    func tableView(tableView: UITableView,canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    //削除ボタンが押された時の処理
    func tableView (tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            placeList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            
            
            //ユーザーデフォルトを用意する
            var myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            myDefault.setObject(placeList, forKey: "placeList")
            
            //即反映させる
            myDefault.synchronize()

        }
     }

    

    @IBAction func returnPlace(sender: UITextField) {
        
        var place = placeTextField.text
        if place?.characters.count != 0{
            
            placeList.append(place!)
            
            print(placeList)
          
            //ユーザーデフォルトに保存
            //ユーザーデフォルトを用意する
            let myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            myDefault.setObject(placeList, forKey: "placeList")
            
            myDefault.setObject(place, forKey: "selectedPlace")
            
            
            //即反映させる
            myDefault.synchronize()
            
            //画面を落とす
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }

    
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        placeTextField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
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
