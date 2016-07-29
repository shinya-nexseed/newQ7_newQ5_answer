//
//  ChosePostsViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/04.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class ChosePostsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var choseTableView: UITableView!
    var posts:NSMutableArray = []
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var checkBtn: UIImageView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        choseTableView.allowsMultipleSelectionDuringEditing = true
        choseTableView.setEditing(true, animated: true)
        
        choseTableView.registerNib(UINib(nibName: "postCustomCell", bundle: nil), forCellReuseIdentifier: "postCustomCell")
        
        choseTableView.registerNib(UINib(nibName: "choseCustomCell", bundle: nil), forCellReuseIdentifier: "choseCustomCell")
        
        
//        let times = FAKFontAwesome.timesIconWithSize(25)
//        
//        let timesImage = times.imageWithSize(CGSizeMake(25, 25))
//        
//        cancelBtn.setImage(timesImage, forState: .Normal)
//        
        
//        let plus = FAKFontAwesome.plusIconWithSize(25)
//        let sakura:UIColor = UIColor(red:1.0,green:0.4,blue:0.4,alpha:1.0)
//        
//        plus.addAttribute(NSForegroundColorAttributeName, value: sakura)
//        
//        let plusImage = plus.imageWithSize(CGSizeMake(25, 25))
//        
//        addBtn.setImage(plusImage, forState: .Normal)
        
        checkBtn.image = UIImage(named:"check")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        checkBtn.tintColor = sakura

        
    }
    
    override func viewWillAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray

        for data in jsonArray{
            
            //openFlag=0のものだけここのpostsには収めたい。どうする？
            var openFlag = data["openFlag"] as! String
            if (openFlag == "0"){
            
                posts.addObject(data as! NSMutableDictionary)
            }
        }
    }
    
 
    
    //行数決定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //表示内容を決定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        
        // 1. 生成するセルをカスタムクラスへダウンキャスト
        // 既存のCell生成コードの後に as! <Cellのカスタムクラス名> という記述を追加
        var cell = tableView.dequeueReusableCellWithIdentifier("postCustomCell", forIndexPath: indexPath) as! homeTableViewCell
        cell.postCreated.text = posts[indexPath.row]["created"] as! String
        
        var dateTime = posts[indexPath.row]["when"] as! String
        cell.postWhen.text = dateTime+" 頃"
        cell.postWhere.text = posts[indexPath.row]["where"] as! String
        cell.postWho.text = posts[indexPath.row]["who"] as! String
        cell.postUniversity.text = posts[indexPath.row]["university"] as! String
        cell.diaryLabel.text = posts[indexPath.row]["diary"] as! String
        
        
        
        
        
//        cell.postImageView.image = UIImage(named:(posts[indexPath.row]["picture1"] as! String))
        
        //どうやったら.xibのイメージを非表示にできる？nilで行ける？
        cell.postEllipsis.image=nil
       
        
        
        return cell
    }
    
    
    @IBAction func selectedBtn(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func cancelBtn(sender: UIButton) {
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
