//
//  AddFormTableViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/27.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class AddFormTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var addFormTableView: UITableView!

    var expandFlag = false
    
    var rownumber = 4
    
    var imagenumber = 0
   
    // Tableで使用する配列を定義する.
    private let basicData: NSArray = ["日時", "場所", "問題の人物", "大学名/学部・学科"]
   

    // Sectionで使用する配列を定義する.
    private let mySections: NSArray = ["basicData", "content","image"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFormTableView.registerNib(UINib(nibName: "addDataCell", bundle: nil), forCellReuseIdentifier: "addDataCell")
        
        addFormTableView.registerNib(UINib(nibName: "datePickerCell", bundle: nil), forCellReuseIdentifier: "datePickerCell")


        addFormTableView.registerNib(UINib(nibName: "addContentCell", bundle: nil), forCellReuseIdentifier: "addContentCell")

        
        addFormTableView.registerNib(UINib(nibName: "addImageCell", bundle: nil), forCellReuseIdentifier: "addImageCell")
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
    }
    
//    セクションの数を返す.

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }
    
//    テーブルの行数を指定する

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //データピッカー開くとき閉じるとき5
            
            return rownumber
            
        } else if section == 1 {
            return 1
            
        } else {
            
            //イメージデータがあったら1 そうじゃなきゃ０
            return imagenumber
        }
    }
    
//    Cellに値を設定する.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         if indexPath.section == 0 {
              if 0 == indexPath.row {
                var cell:addDataTableViewCell = tableView.dequeueReusableCellWithIdentifier("addDataCell", forIndexPath: indexPath) as! addDataTableViewCell
                
                cell.addTextField.placeholder = basicData[indexPath.row] as! String
                
                return cell
              }else if 1 == indexPath.row{
                if expandFlag{
                    
                    var Cell:datePickerTableViewCell = tableView.dequeueReusableCellWithIdentifier("datePickerCell", forIndexPath: indexPath) as! datePickerTableViewCell
                    
                    Cell.addDatePicker.addTarget(self, action: "changedDT:", forControlEvents:UIControlEvents.ValueChanged)
                    
                    return Cell

                    
                }else{
                    
                    var cell:addDataTableViewCell = tableView.dequeueReusableCellWithIdentifier("addDataCell", forIndexPath: indexPath) as! addDataTableViewCell
                    
                    cell.addTextField.placeholder = basicData[indexPath.row] as! String
                    
                    return cell
                }


              }else{
                
                if expandFlag{
                    var cell:addDataTableViewCell = tableView.dequeueReusableCellWithIdentifier("addDataCell", forIndexPath: indexPath) as! addDataTableViewCell
                
                    cell.addTextField.placeholder = basicData[indexPath.row - 1] as! String
                    
                    return cell
                
                }else{
                    var cell:addDataTableViewCell = tableView.dequeueReusableCellWithIdentifier("addDataCell", forIndexPath: indexPath) as! addDataTableViewCell
                    
                    cell.addTextField.placeholder = basicData[indexPath.row] as! String
                    
                    return cell

                   
                }
                
            }
        
        }
            
        if indexPath.section == 1 {
                
                var cell:addContentTableViewCell = tableView.dequeueReusableCellWithIdentifier("addContentCell", forIndexPath: indexPath) as! addContentTableViewCell
                
                return cell
         
        }
        
        if indexPath.section == 2 {
                
                var cell:addImageTableViewCell = tableView.dequeueReusableCellWithIdentifier("addImageCell", forIndexPath: indexPath) as! addImageTableViewCell
                
                return cell

        }
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("addImageCell", forIndexPath: indexPath) as! addImageTableViewCell
        
        return cell

        
    }
    
    
        // delegate didSelectRow
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if 0 == indexPath.row {
                //            // switching open or close
                //            sections[indexPath.section].extended = !sections[indexPath.section].extended
                
            if expandFlag {
                expandFlag = !expandFlag
                self.toContract(tableView, indexPath: indexPath)
                
            }else{
                expandFlag = !expandFlag
                self.toExpand(tableView, indexPath: indexPath)
            }
        }
            
        if 1 == indexPath.row {
            
            let AddWhere = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhereViewController") as UIViewController
            
            presentViewController(AddWhere, animated: true, completion: nil)
            
        }
        
        
        
        
        if 2 == indexPath.row {
            let AddWho = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhoViewController") as UIViewController
            
            presentViewController(AddWho, animated: true, completion: nil)
            
        }
        
        if 3 == indexPath.row{
            
            var myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            
//            myDefault.setObject(addTextField.text, forKey: "uniStr")
            
            //即反映させる
            myDefault.synchronize()
            
        }
        
        if 4 == indexPath.row{
            
            let AddDiaryVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("AddDiaryViewController") as UIViewController
            
            // showで遷移するバージョン           navigationController?.pushViewController(AddDiaryVC, animated: true)
            
            // モーダルで遷移するバージョン
            presentViewController(AddDiaryVC, animated: true, completion: nil)
            
        }
        
        if 5 == indexPath.row{
            
            
        }
        
        
            // deselec
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

        
        /// open details
        /// - parameter tableView: self.tableView
        /// - parameter indexPath: NSIndexPath
        /// - returns:
        private func toExpand(tableView: UITableView, indexPath: NSIndexPath) {
            let startRow = indexPath.row + 1
            //let endRow = sections[indexPath.section].details.count + 1
            let endRow = startRow + 1
            
            var indexPaths: [NSIndexPath] = []
            for var i = startRow; i < endRow; i++ {
                
                indexPaths.append(NSIndexPath(forRow: i, inSection: indexPath.section))
            }
            
            rownumber += 1
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
            
            // scroll to the selected cell.
            tableView.scrollToRowAtIndexPath(NSIndexPath(
                forRow: indexPath.row, inSection: indexPath.section),
                                             atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            // 0行だけ更新(addWhen.textを赤字に変更したいので）
            let row = NSIndexPath(forRow: 0, inSection: 0)
            addFormTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
            
            /// close details
            /// - parameter tableView: self.tableView
            /// - parameter indexPath: NSIndexPath
            /// - returns:
            private func toContract(tableView: UITableView, indexPath: NSIndexPath) {
                let startRow = indexPath.row + 1
                //let endRow = sections[indexPath.section].details.count + 1
                let endRow = startRow + 1
                
                var indexPaths: [NSIndexPath] = []
                for var i = startRow; i < endRow; i++ {
                    indexPaths.append(NSIndexPath(forRow: i , inSection: indexPath.section))
                }
                rownumber -= 1
                
                tableView.deleteRowsAtIndexPaths(indexPaths,
                                                 withRowAnimation: UITableViewRowAnimation.Fade)
                // 0行だけ更新(addWhen.textを黒字に変更したいので）
                let row = NSIndexPath(forRow: 0, inSection: 0)
                addFormTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }
        
        //MARK: cellの高さしてい
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        {
            if indexPath.row == 0 {
                return 30
            }
            if indexPath.row == 1 {
                if expandFlag {
                    return 250
                }else{
                    return 30
                }
            }
    
            
            
            return 550.0//ここの意味は？
        }

    
        func changedDT(sender:UIDatePicker){
            
            let df = NSDateFormatter()
            df.dateFormat = "yyyy/MM/dd HH:mm"
            sender.maximumDate = NSDate()
            var dateStr = df.stringFromDate(sender.date)
            
            //        daatePickerで取得した日時をuserDefaultにセット
            var myDefault = NSUserDefaults.standardUserDefaults()
            myDefault.setObject(dateStr, forKey: "selectedDT")
            myDefault.synchronize()
            
            
            
            // 対象行だけ更新
            let row = NSIndexPath(forRow: 0, inSection: 0)
            addFormTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
            //myTableView.reloadData()
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
