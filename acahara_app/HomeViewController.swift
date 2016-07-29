//
//  FirstViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    var countNum = 0
    var movieCountNum = 0
    var selectedIndex = -1
    @IBOutlet weak var homeTableView: UITableView!

    var myApp = UIApplication.sharedApplication()
        .delegate as! AppDelegate

    var json:NSData!
    
    
    // ボタンを用意

    @IBOutlet weak var addBtn: UIBarButtonItem!
    var posts:NSMutableArray = []
    
    //var temp:NSMutableArray
    
    //MARK:一戸追加
    // true :デバッグモード
    // false :本番モード
    var debugFlag:Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //セルの高さを可変にする設定、テキストの長さ、写真の有無で可変にしたい
        homeTableView.estimatedRowHeight = 470
        homeTableView.rowHeight = UITableViewAutomaticDimension
        
        addBtn.tintColor = UIColor.whiteColor()
        
        homeTableView.registerNib(UINib(nibName: "postCustomCell", bundle: nil), forCellReuseIdentifier: "postCustomCell")
//        homeTableView.registerNib(UINib(nibName: "homeIntroCell", bundle: nil), forCellReuseIdentifier: "homeIntroCell")
        
        
        // addBtnを設置 このやり方だとframeが使えない。UIButtonを使ってからじゃないとNavBarに設置できない
        //            var addBtn = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "onClick")
        //            self.navigationItem.rightBarButtonItem = addBtn
        
        
        
        
//        //      let rightButton = UIButton()　これではダメ。
//        let rightButton = UIButton(type: UIButtonType.System)
//        
//        rightButton.frame = CGRectMake(myBoundsize.width-18, 30, 25, 25)
//        rightButton.setImage(UIImage(named:"create"), forState: UIControlState.Normal)
//        rightButton.addTarget(self, action: "rightNavItemEditClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
//        self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
//        
//        
//        rightButton.tintColor = UIColor.whiteColor()

        
        
        
//        self.title = "Home"
        
        // addBtnを設置
//        addBtn = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "onClick")
//        self.navigationItem.rightBarButtonItem = addBtn

//       
//        let write = FAKFontAwesome.pencilSquareOIconWithSize(25)
//        //下記でアイコンの色も変えられます
//        write.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
//        
//        let writeImage = write.imageWithSize(CGSizeMake(25, 25))
//        
//        homeWrite.setImage(writeImage, forState: .Normal)
        
        if debugFlag == false{
        
            //ここをAPI取得に切り替える
            var url = NSURL(string: "http://acahara.angry.jp/get.post_json.php")
            var request = NSURLRequest(URL:url!)
            var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil))
            let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata, options: [])) as! NSArray
            print("jsonArray.count = \(jsonArray.count)")
            
            for (var i = 0; i < jsonArray.count; i++) {
                let jsonDict: NSDictionary =  NSDictionary(dictionary: jsonArray[i] as! NSDictionary)
                print("jsonDict openFlag = \(jsonDict["openFlag"])")
                
                // picutureを分割し再度入れなおす処理
                
                let intStr = String(jsonDict["openFlag"]!)
                let openFlag = Int(intStr)
                
                if openFlag == 0 { // postsに追加
                    posts.addObject(jsonDict)
                }
            }
            
            print("posts.count = \(posts.count)")
            print("posts = \(posts)")

        
        }else{
                  let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
                  let jsondata = NSData(contentsOfFile: path!)
            
            
                        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
            
                        //データがちゃんと来ているか、urlに切り替えた場合に確認する
                        print(jsonArray)
            
                        for data in jsonArray{
                            //ここの形がどうなる？
                            posts.addObject(data as! NSMutableDictionary)
                            
                        }

        
        }
        
    

        
    }
    
    


    
    
    
    override func viewWillAppear(animated: Bool) {
        
        // ナビゲーションを透明にする処理
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        //データ記録画面で保存した後に表示されたとわかったとき
        var myDefault = NSUserDefaults.standardUserDefaults()
        var afterSaved = myDefault.objectForKey("saveSuccess")
        //保存成功のアラートを表示
            if( afterSaved != nil){
                let alert: UIAlertController = UIAlertController(title: "記録成功", message: "負けないで！", preferredStyle: .Alert)
                self.presentViewController(alert, animated: true) { () -> Void in
                let delay = 1.0 * Double(NSEC_PER_SEC)
                    let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                
        myDefault.removeObjectForKey("saveSuccess")
        myDefault.synchronize()

        //最新情報をリロード
//      self.homeTableView.reloadData()//これ何の意味？
            }
        }


    }

    
    
    
    //行数決定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    //表示内容を決定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        
//        if indexPath.row == 0{
//            
//            //cellを生成？
//            var cell:homeIntroTableViewCell = tableView.dequeueReusableCellWithIdentifier("homeIntroCell", forIndexPath: indexPath) as! homeIntroTableViewCell
//            
//
//            return cell
//        }else{

            
        // 1. 生成するセルをカスタムクラスへダウンキャスト
        // 既存のCell生成コードの後に as! <Cellのカスタムクラス名> という記述を追加
        var cell = tableView.dequeueReusableCellWithIdentifier("postCustomCell", forIndexPath: indexPath) as! homeTableViewCell
        cell.postCreated.text = posts[indexPath.row]["created"] as! String
        
        
        //MARK:一戸追加
//        
//        var dateTime = posts[indexPath.row]["time"] as! String
//        cell.postWhen.text = dateTime+" 頃"
//        cell.postWhere.text = posts[indexPath.row]["place"] as! String
//        cell.postWho.text = posts[indexPath.row]["person"] as! String
//        cell.postUniversity.text = posts[indexPath.row]["university"] as! String
//        
//        
//        var diary = posts[indexPath.row]["description"] as! String
//        var charCount = diary.characters.count
//        
//        if (charCount >= 106){
//            var abstractDiary =  (diary as NSString).substringToIndex(106)
//            cell.diaryLabel.text = abstractDiary + "..."
//        }else{
//            cell.diaryLabel.text = diary
//        }
        
        var dateTime:String = ""
        var diary:String = ""
        var charCount:Int = -1
        var abstractDiary:String = ""
        
        if debugFlag {
            //デバッグモード
            dateTime = posts[indexPath.row]["when"] as! String
            cell.postWhen.text = dateTime+" 頃"
            cell.postWhere.text = posts[indexPath.row]["where"] as! String
            cell.postWho.text = posts[indexPath.row]["who"] as! String
            cell.postUniversity.text = posts[indexPath.row]["university"] as! String
            
            diary = posts[indexPath.row]["diary"] as! String
            charCount = diary.characters.count
            
            if (charCount >= 106){
                abstractDiary =  (diary as NSString).substringToIndex(106)
                cell.diaryLabel.text = abstractDiary + "..."
            }else{
                cell.diaryLabel.text = diary
            }

        }else{
            //本番モード
            dateTime = posts[indexPath.row]["time"] as! String
            cell.postWhen.text = dateTime+" 頃"
            cell.postWhere.text = posts[indexPath.row]["place"] as! String
            cell.postWho.text = posts[indexPath.row]["person"] as! String
            cell.postUniversity.text = posts[indexPath.row]["university"] as! String
            
            diary = posts[indexPath.row]["description"] as! String
            charCount = diary.characters.count
            
            if (charCount >= 106){
                abstractDiary =  (diary as NSString).substringToIndex(106)
                cell.diaryLabel.text = abstractDiary + "..."
            }else{
                cell.diaryLabel.text = diary
            }
        }
        
        //冒頭から106取ってくる設定
//        var abstractDiary = (diary as NSString).substringToIndex(106)
        
        
        
        //フォントサイズの調整
   
        //cell.postDiary.font = UIFont(name: "System", size: 40)
        cell.postWho.font = UIFont.systemFontOfSize(12)
        cell.postUniversity.font = UIFont.systemFontOfSize(12)
        
        //行間の設定 ここで大きさがリセットされているから、リセット後にサイズを指定しないといけない
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSParagraphStyleAttributeName : style]
        cell.diaryLabel.attributedText = NSAttributedString(string: cell.diaryLabel.text!,
                                                      attributes: attributes)
        
        cell.diaryLabel.font = UIFont.systemFontOfSize(15)
        
        // Add tap gesture recognizer to Text View

        //MARK:一戸削除
        //cell.labelCoverBtn.addTarget(self, action:"showMore:", forControlEvents:.TouchUpInside)
//        cell.labelCoverBtn.tag = indexPath.row
        
        
//選択された写真サムネイルを表示するための処理
        //picture : [url,url,url,"","",""]のとき jsonデータの形がこれだと
        
                // 写真データ全件取得
        var picArray = posts[indexPath.row]["picture"] as! NSMutableArray
        print("picArrayのカウント = \(picArray.count)")
        
        //これで一緒？
        
//        var pic1 = posts[indexPath.row]["picture1"] as! String
//        var pic2 = posts[indexPath.row]["picture2"] as! String
//        var pic3 = posts[indexPath.row]["picture3"] as! String
//        var pic4 = posts[indexPath.row]["picture4"] as! String
//        var pic5 = posts[indexPath.row]["picture5"] as! String
        
//        var picArray = [pic1,pic2,pic3,pic4,pic5]
        
        var selectedPictures = [] as! NSMutableArray
        
        
        //空でない写真を配列selectedPicturesにセット
        for selectedPic in picArray{
            
            if selectedPic as! String != ""{
                selectedPictures.addObject(selectedPic)
            }
            
        }

        
        //スクロールビューから追加したビューを一旦削除

        removeAllSubviews(cell.pictureScrView)
        
        
        //選択されている写真の数
        var picNum = selectedPictures.count
        
        if picNum > 0{
            print("============ 写真が存在するとき ============")
            print(picNum)
            //スクロールが走る表示全体サイズを指定。写真の120幅に、10の余白で130
            let scrViewWidth:CGFloat = CGFloat(130 * picNum )
                
            cell.pictureScrView.contentSize = CGSizeMake(scrViewWidth, 120)
            
            //MARK:一戸追加
            cell.imageHeightLC.constant = 120
                
            self.countNum = 0
            for strURL in selectedPictures{
                print("画像のassetURL:\(strURL)")
                
                var url = NSURL(string: strURL as! String)
                
                let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                
                if fetchResult.firstObject != nil{
                    
                    let asset: PHAsset = fetchResult.firstObject as! PHAsset
                    
                    
                    print("pixelWidth:\(asset.pixelWidth)");
                    print("pixelHeight:\(asset.pixelHeight)");
                    
                    let manager: PHImageManager = PHImageManager()
                    manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                        
                        //imageViewのaspectFitをつける必要がある？このままで良いかも
                        var imageView = UIImageView()
                        
                        //各写真イメージのX座標開始位置をpositionXとする。120幅に、10の余白で130
                        var positionX:CGFloat = CGFloat(130 * self.countNum)
                        
                        //写真の位置サイズ指定
                        imageView.frame = CGRectMake(positionX, 0, 120, 120)
                        imageView.image = image
                        
                        cell.pictureScrView.addSubview(imageView)
                            
                
                            
                        //写真の上に選択時の透明ボタンを被せて配置する
                        var picSelectBtn = UIButton()
                        picSelectBtn.setTitle("", forState: .Normal)
                        picSelectBtn.frame = CGRectMake(positionX, 0, 120, 120)
                        picSelectBtn.addTarget(self, action: "showPicture:", forControlEvents:.TouchUpInside)
                        cell.pictureScrView.addSubview(picSelectBtn)
                        
                        picSelectBtn.tag = indexPath.row
                        
                        self.countNum++
                        
                        
                            //                              cell.picCancelBtn.hidden = false
                        }
                    }
                    
                }
            
            
            
//                return cell // problem1

            
        }else{
            print("============ 写真が存在しないとき ============")
            //MARK:一戸追加
            cell.imageHeightLC.constant = 0
            
            //選択写真が存在しない場合、画像表示箇所が縮まるように
            removeAllSubviews(cell.pictureScrView)
            cell.pictureScrView.frame.size.height = 0
            cell.pictureScrView.frame.size.width = 0
            print(cell.pictureScrView.frame.size.height)
            
//            return cell
            
        }
        

        
//選択された動画サムネイルを表示するための処理
        
        var movArray = posts[indexPath.row]["movie"] as! NSMutableArray
         print("movArrayのカウント = \(movArray.count)")
        
//        var mov1 = posts[indexPath.row]["movie1"] as! String
//        var mov2 = posts[indexPath.row]["movie2"] as! String
//        var mov3 = posts[indexPath.row]["movie3"] as! String
//        var mov4 = posts[indexPath.row]["movie4"] as! String
//        var mov5 = posts[indexPath.row]["movie5"] as! String
//        
//        var movArray = [mov1,mov2,mov3,mov4,mov5]
        
        var selectedMovies = [] as! NSMutableArray
        
        
        //空でない動画を配列selectedPicturesにセット
        for selectedMov in movArray{
            
            if selectedMov as! String != ""{
                selectedMovies.addObject(selectedMov)
            }
            
        }
        
        //スクロールビューから追加したビューを一旦削除
        removeAllSubviews(cell.movieScrView)
        
        
        
        //選択されている動画の数
        var movNum = selectedMovies.count
        
        if movNum > 0{
            print("============ 動画が存在するとき ============")
            
            //MARK:一戸追加
            cell.movieHeightLC.constant = 120

            print(movNum)
            //スクロールが走る表示全体サイズを指定。写真の120幅に、10の余白で130
            let scrViewWidth:CGFloat = CGFloat(130 * picNum )
            
            cell.movieScrView.contentSize = CGSizeMake(scrViewWidth, 120)
            
            
            self.movieCountNum = 0
            print("self.movieCountNum = \(self.movieCountNum)")
            for strURL in selectedMovies{
                print("動画のassetURL:\(strURL)")
                
                var url = NSURL(string: strURL as! String)
                
                let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                
                if fetchResult.firstObject != nil{
                    
                    let asset: PHAsset = fetchResult.firstObject as! PHAsset
                    
                    
                    print("pixelWidth:\(asset.pixelWidth)");
                    print("pixelHeight:\(asset.pixelHeight)");
                    
                    let manager: PHImageManager = PHImageManager()
                    manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                        
                        //imageViewのaspectFitをつける必要がある？このままで良いかも
                        var imageView = UIImageView()
                        
                        //各動画イメージのX座標開始位置をpositionXとする。120幅に、10の余白で130
                        
                        var positionX:CGFloat = CGFloat(130 * self.movieCountNum)
                        print("positionX = \(positionX)")
                        //写真の位置サイズ指定
                        imageView.frame = CGRectMake(positionX, 0, 120, 120)
                        imageView.image = image
                        
                        cell.movieScrView.addSubview(imageView)
                        
                        
                        
                        //動画サムネイルの上に選択時の透明ボタンを被せて配置する
                        var movSelectBtn = UIButton()
                        movSelectBtn.setTitle("", forState: .Normal)
                        movSelectBtn.frame = CGRectMake(positionX, 0, 120, 120)
                        movSelectBtn.addTarget(self, action: "showMovie:", forControlEvents:.TouchUpInside)
                        cell.movieScrView.addSubview(movSelectBtn)
                        
                        movSelectBtn.tag = indexPath.row
                        
                        self.movieCountNum++
                        
                        
                        //                              cell.picCancelBtn.hidden = false
                    }
                }
                
            }
            
//            return cell // problem2
            
            
        }else{
            print("============ 動画が存在しないとき ============")
            //MARK:一戸追加
            cell.movieHeightLC.constant = 0
            
            //選択写真が存在しない場合、画像表示箇所が縮まるように
            cell.movieScrView.frame.size.height = 0
            cell.movieScrView.frame.size.width = 0
            print(cell.movieScrView.frame.size.height)
        
//            return cell
        }   // if movNum > 0　の終わり
  
        
        
        //postsのopenFlag==1のセルだけ下のようにしたい
        
        var openFlag:String = posts[indexPath.row]["openFlag"] as! String
        
        if (openFlag == "1"){
            
            //色を使って指定する
            let paleBlue:UIColor = UIColor(red:0.914,green:0.941,blue:0.980,alpha:1.0)

            cell.backgroundColor = paleBlue
            cell.diaryLabel.backgroundColor = paleBlue
        
        }else{
            cell.backgroundColor = UIColor.whiteColor()
            cell.diaryLabel.backgroundColor = UIColor.whiteColor()
            
        }
        
        //.xibファイルのボタンがタップされ時の処理
        
        //postEllipsisBtn等の後に：をつけることで、sender情報を使える
        cell.postEllipsisBtn.addTarget(self, action:"postEllipsisBtn:", forControlEvents:.TouchUpInside)
        cell.postEllipsisBtn.tag = indexPath.row
        
        
        cell.postMoreBtn.addTarget(self, action:"showMore:",forControlEvents:.TouchUpInside)
        cell.postMoreBtn.tag = indexPath.row
        
//        cell.postTextViewBtn.addTarget(self, action:"showMore:",forControlEvents: .TouchUpInside)
//        cell.postTextViewBtn.tag = indexPath.row
        
        
        //動的にセルの高さを変えたい
        cell.layoutIfNeeded()
        
        return cell //これが発動すれば上のはいらない
        
        }
    
    
    //各行の高さを指定する
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        if indexPath.row == 0 {
//            return 110
//        }else{
//      
//            return 355
//        }
//        
//        return 80//ここの意味は？とりあえず全部のケースを網羅する。
//    }
    
    
    
    //削除が選択された時の関数
    func postEllipsisBtn(sender: UIButton) {
        
        print("\(sender.tag)番目")
        
        var postEllipsisController = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
        postEllipsisController.addAction(UIAlertAction(title: "削除", style: .Default, handler: { action in self.confirm(sender.tag)}))
        
        
        
        //openFlagが１の時は「念のため記述」にしたい、０の時は「相談に利用予定」 = posts[indexPath.row][openFlag]どう書く？if、ここに書ける？
        
        var tempStr:String = ""
        var openFlag:String = posts[sender.tag]["openFlag"] as! String
        
        

        if(openFlag == "1"){
            tempStr = "「相談に利用予定」へ変更"
        }else{
            tempStr = "「念のため記録」へ変更"
        }
        postEllipsisController.addAction(UIAlertAction(title: tempStr, style: .Default, handler:{ action in self.changeMode(sender.tag)}))
        
        
        postEllipsisController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: { action in
            print("cancel")
        }))
        
        
        presentViewController(postEllipsisController, animated: true, completion: nil)
    }

    //moreボタンpostTextViewBtnでdetailVCに遷移する
    func showMore(sender: UIButton){
        
        let detailVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailVC.dtSelectedIndex = sender.tag
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
    
    //picSelectBtnをタップするとpictureVCに遷移する
    func showPicture(sender: UIButton){
        
        var xPosition = sender.frame.origin.x
        
        //配列selectedPicturesの何番目の写真が選択されたか
//        var numOfPic = xPosition/130 as! Int
//        xPositionに0が入っているとエラーになる
        var numOfPic = -1
        
        if xPosition == 0 {
            numOfPic = 0
        }else{
            numOfPic = Int(xPosition/130)
        }
        
        

        let pictureVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("PictureViewController") as! PictureViewController
    
        pictureVC.picSelectedIndex = sender.tag
        pictureVC.numOfSelectedPicture = numOfPic
            
        navigationController?.pushViewController(pictureVC, animated: true)

    
        }
    
    //movSelectBtnをタップするとpictureVCに遷移する
    func showMovie(sender: UIButton){
        
        var xPosition = sender.frame.origin.x
        
        //配列selectedPicturesの何番目の動画が選択されたか
        var numOfMov = xPosition/130 as! Int
        
        
        let movieVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("MovieViewController") as! MovieViewController
        
        movieVC.movSelectedIndex = sender.tag
        movieVC.numOfSelectedMovie = numOfMov
        
        navigationController?.pushViewController(movieVC, animated: true)
        
        
    }


    
    
    func changeMode(tag:Int){
        
        var openFlag:String = posts[tag]["openFlag"] as! String
        
        //NSMutableDictionaryをコピーしてから変更を加えないとエラーが出る
        var dic:NSMutableDictionary = posts[tag].mutableCopy() as! NSMutableDictionary
        
        //サーバーにデータ送信するための準備
        var url = NSURL(string: "http://localhost/json/change_mode.php")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
    if (openFlag=="0"){
        
        //swiftで表示される辞書配列の情報を上書きする
        dic.setValue("1", forKey: "openFlag")
        
        //サーバー側のデータを変更するためのAPIにアクセスする

        //送りたい２つの情報を集める
        var id = posts[tag]["id"]!!.dataUsingEncoding(NSUTF8StringEncoding)
        var openFlag = String(1).dataUsingEncoding(NSUTF8StringEncoding)

        
        // dictionaryで送信する辞書配列を生成
        var myDict:NSMutableDictionary = NSMutableDictionary()
        myDict.setObject("id", forKey: "id")
        myDict.setObject("openFlag", forKey: "openFlag")
        
        // 作成したdictionaryがJSONに変換可能かチェック.
        if NSJSONSerialization.isValidJSONObject(myDict){
            
            // DictionaryからJSON(NSData)へ変換.
            
            do {
                json = try NSJSONSerialization.dataWithJSONObject(myDict, options: NSJSONWritingOptions.PrettyPrinted) as NSData
                // here "jsonData" is the dictionary encoded in JSON data
                // 生成したJSONデータの確認.
                print(NSString(data: json, encoding: NSUTF8StringEncoding)!)
                
            } catch let error as NSError {
                print(error)
            }
            catch{
                print("Unknown Error")
            }
        }
       

        var req1 = NSMutableURLRequest(URL: url!)
        req1.HTTPMethod = "POST"
        // jsonのデータを一度文字列にして、キーと合わせる.
        var myData:NSString = "json=\(NSString(data: json, encoding: NSUTF8StringEncoding)!)"
        
        // jsonデータのセット.
        req1.HTTPBody = myData.dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(req1, completionHandler: {
            (data, resp, err) in
            print(resp!.URL!)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        })
        task.resume()
   

    

    
    }else{
        //swiftで表示される辞書配列の情報を上書きする
        dic.setValue("0", forKey: "openFlag")
        
        //サーバー側のデータを変更するためのAPIにアクセスする
        var id = posts[tag]["id"]!!.dataUsingEncoding(NSUTF8StringEncoding)
        var openFlag = String(0).dataUsingEncoding(NSUTF8StringEncoding)
        
        
        // dictionaryで送信する辞書配列を生成
        var myDict:NSMutableDictionary = NSMutableDictionary()
        myDict.setObject("id", forKey: "id")
        myDict.setObject("openFlag", forKey: "openFlag")
        
        // 作成したdictionaryがJSONに変換可能かチェック.
        if NSJSONSerialization.isValidJSONObject(myDict){
            
            // DictionaryからJSON(NSData)へ変換.
            
            do {
                json = try NSJSONSerialization.dataWithJSONObject(myDict, options: NSJSONWritingOptions.PrettyPrinted) as NSData
                // here "jsonData" is the dictionary encoded in JSON data
                // 生成したJSONデータの確認.
                print(NSString(data: json, encoding: NSUTF8StringEncoding)!)
                
            } catch let error as NSError {
                print(error)
            }
            catch{
                print("Unknown Error")
            }
        }
        
        
        var req1 = NSMutableURLRequest(URL: url!)
        req1.HTTPMethod = "POST"
        // jsonのデータを一度文字列にして、キーと合わせる.
        var myData:NSString = "json=\(NSString(data: json, encoding: NSUTF8StringEncoding)!)"
        
        // jsonデータのセット.
        req1.HTTPBody = myData.dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(req1, completionHandler: {
            (data, resp, err) in
            print(resp!.URL!)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        })
        task.resume()
        }
        
    
        //コピーして書き換えた辞書配列データを元のものに上書きする
        posts[tag] = dic
        
        homeTableView.reloadData()
    
    }
    
    
    //削除が選択された時の、確認アラート
    func confirm(tag:Int){
        
        var alertController = UIAlertController(title:"ご注意", message: "本当に削除しますか？", preferredStyle: .Alert)
        
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in self.deletePost(tag
            )}))
        
        alertController.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: {action in print("cancel")}))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func deletePost(tag:Int){
//        論理削除を記述したいけど、どうやる？以下は物理削除だけれど書き方は？サーバー
//        ここでAPIに接続
        
        var url = NSURL(string: "http://localhost/json/delete.php")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        var req = NSMutableURLRequest(URL: url!)
        req.HTTPMethod = "POST"
        
        //投稿データのidを取得する
        //このtagでindexPath.rowは渡ってきてる？
        var id = posts[tag]["id"]
        req.HTTPBody = "id=\(id)".dataUsingEncoding(NSUTF8StringEncoding)
        var task = session.dataTaskWithRequest(req, completionHandler: {
            (data, resp, err) in
            print(resp!.URL!)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        })
        task.resume()
        
        
        posts.removeObjectAtIndex(tag)
        self.homeTableView.reloadData()
    }
    
    


    @IBAction func addBtn(sender: UIBarButtonItem) {
           
        let AddTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddTableViewController") as UIViewController
        
        presentViewController(AddTableView, animated: true, completion: nil)

        
        
    }


    // addBtnをタップしたときのアクション
//    func onClick() {
//        
//        
//        let AddTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddTableViewController") as UIViewController
//        
//        presentViewController(AddTableView, animated: true, completion: nil)
//        
        //ナビゲーションコントローラによる遷移
        //  let second = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddViewController") as UIViewController

        // 　self.navigationController?.pushViewController(second, animated: true)
        
        // その際に、次の画面でタブを消す設定、エラーが出る
        //        var add = AddViewController(nibName:"AddViewController",bundle:nil)
        //        add.hidesBottomBarWhenPushed = true
        //
        //        self.navigationController?.pushViewController(add,animated:true)
//    }

    
//subViewを親ビューから全て削除
    func removeAllSubviews(parentView: UIView){
        var subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

