//
//  HelpViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/29.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var helpTableView: UITableView!
    var posts:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        helpTableView.registerNib(UINib(nibName: "postCustomCell", bundle: nil), forCellReuseIdentifier: "postCustomCell")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        
        for data in jsonArray{
            
            var openFlag:String = data["openFlag"] as! String
            
            if openFlag == "0"{
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
        cell.postWhen.text = posts[indexPath.row]["when"] as! String
        cell.postWhere.text = posts[indexPath.row]["where"] as! String
        cell.postWho.text = posts[indexPath.row]["who"] as! String
        cell.postUniversity.text = posts[indexPath.row]["university"] as! String
        cell.postDiary.text = posts[indexPath.row]["diary"] as! String
        cell.postImageView.image = UIImage(named:(posts[indexPath.row]["picture"] as! String))
        
        
        //postsのopenFlag==1のセルだけ下のようにしたい
        
        var openFlag:String = posts[indexPath.row]["openFlag"] as! String
        
//        if (openFlag == "1"){
//            
//            //セルを見せない？消す？どうする？
//            cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
//            cell.postDiary.backgroundColor = UIColor.groupTableViewBackgroundColor()
//            
//        }else{
//            cell.backgroundColor = UIColor.whiteColor()
//            cell.postDiary.backgroundColor = UIColor.whiteColor()
//            
//        }
//        
        //settingBtnの後に：をつけることで、sender情報を使える
        cell.postEllipsisBtn.addTarget(self, action:"settingBtn:", forControlEvents:.TouchUpInside)
        cell.postEllipsisBtn.tag = indexPath.row
        
        
        cell.postMoreBtn.addTarget(self, action:"detailVC:",forControlEvents:.TouchUpInside)
        
        return cell
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
