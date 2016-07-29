//
//  AddTableViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos
import AVFoundation

class AddTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate{
    
    var json:NSData!

    @IBOutlet weak var saveBtn: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    
  
    var countNum = 0
    var expandflag = false
    var rownumber = 2
    
    var openFlag = 0
    
    var rownumberFlag = false
    
    var cellHeights = []
    
    var firstTime = true
    
//    let AddDiaryVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("AddDiaryViewController") as UIViewController
    
    var myApp = UIApplication.sharedApplication()
    .delegate as! AppDelegate
    
    
    @IBOutlet weak var addTableView: UITableView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.redColor()

        addTableView.registerNib(UINib(nibName: "dateTimeCell", bundle: nil), forCellReuseIdentifier: "dateTimeCell")
        
        addTableView.registerNib(UINib(nibName: "datePickerCell", bundle: nil), forCellReuseIdentifier: "datePickerCell")
        
        addTableView.registerNib(UINib(nibName: "bottomCell", bundle: nil), forCellReuseIdentifier: "bottomCell")
        
        addTableView.registerNib(UINib(nibName: "photoCell", bundle: nil), forCellReuseIdentifier: "photoCell")
        
        addTableView.registerNib(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        //テーブルビューの罫線を消す
        addTableView.separatorColor = UIColor.clearColor()
        
        //記入必須項目が未記入のうちは保存ボタンはhiddenにしておく
//        var myDefault = NSUserDefaults.standardUserDefaults()
//        var sWhen = myDefault.stringForKey("selectedDT")
//        var sWhere = myDefault.stringForKey("selectedPlace")
//        var sWho = myDefault.stringForKey("selectedName")
//        var sUni = myDefault.stringForKey("uniStr")
//        var sDiary = myDefault.stringForKey("diary")
        
        
        
        //myDefaulの各項目がnilでなかったら保存ボタンを表示したい。。。ん
//       if (sWhen==nil || sWhere==nil || sWho==nil || sUni==nil || sDiary == nil){
//        
//            self.addSaveBtn.hidden = true
//        }else{
//            self.addSaveBtn.hidden = false
//        }
        
        
//        let times = FAKFontAwesome.timesIconWithSize(25)
//        
//        let timesImage = times.imageWithSize(CGSizeMake(25, 25))
//        
//        cancelBtn.setImage(timesImage, forState: .Normal)
        
        saveBtn.image = UIImage(named:"dataBase")?.imageWithRenderingMode(.AlwaysTemplate)
        
//        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        saveBtn.tintColor = UIColor.whiteColor()
        
        let sakuraPale:UIColor = UIColor(red:1.0,green:0.953,blue:0.910,alpha:1.0)

        self.view.backgroundColor = sakuraPale
        
        // 


    }
    
    
    override func viewWillAppear(animated: Bool) {
        //ここは何の意味があるの？
        print("再表示")

        addTableView.reloadData()
        
        //キーボードの制御
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    //キーボードの制御
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        var boundSize: CGSize = UIScreen.mainScreen().bounds.size
        let addUnivTextFieldBottomHeight: CGFloat = 191+40
        let dateTimeCellHeight: CGFloat = 140
        let datePickerCellHeight: CGFloat = expandflag ? 250 : 0
        let textFieldLimit = dateTimeCellHeight + datePickerCellHeight + addUnivTextFieldBottomHeight
        var keyboardLimit = boundSize.height - keyboardScreenEndFrame.size.height - 80
        
        if textFieldLimit >= keyboardLimit {
            addTableView.contentOffset.y = textFieldLimit - keyboardLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        addTableView.contentOffset.y = 0
    }
//
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        addTextField = textField
//        return true
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        
//        return true
//    }
    

    
    
    //行数決定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            var myDefault = NSUserDefaults.standardUserDefaults()
            var photoURLArray = myDefault.objectForKey("photoURLArray")
            var movieURLArray = myDefault.objectForKey("movieURLArray")

            if (photoURLArray != nil && self.myApp.photoURLArray == false && photoURLArray!.count > 0) {
                
                self.rownumber++
                
                self.myApp.photoURLArray = true
                
            }
            
            if (movieURLArray != nil && self.myApp.movieURLArray == false && movieURLArray!.count > 0){
                
                self.rownumber++
                
                self.myApp.movieURLArray = true
            }
        
       
        
        
        return rownumber
    }


        
  

    //表示内容を決定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell: UITableViewCell?
    
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        
        if indexPath.row == 0{
            
            //cellを生成？
            var cell:dateTimeTableViewCell = tableView.dequeueReusableCellWithIdentifier("dateTimeCell", forIndexPath: indexPath) as! dateTimeTableViewCell

            
            //datePickerの値をuserDefaultから取り出す
            
            var selectedDT = myDefault.stringForKey("selectedDT")
  
            //userDefaultから取り出されたdatePickerの日時をセット

            
            if selectedDT == nil{
                
                if expandflag{
                    let df = NSDateFormatter()
                    df.dateFormat = "yyyy/MM/dd HH:mm"
                    var today = NSDate()
                    var todayStr = df.stringFromDate(today)
                    
                    
                    //現在日付をユーザーデフォルトにこの段階で入れておいてあげる。そうすると上書きされるけど、デートピッカーを動かさない場合にも空にならない。
                    var myDefault = NSUserDefaults.standardUserDefaults()
                    myDefault.setObject(todayStr, forKey: "selectedDT")
                    myDefault.synchronize()
                    
                    cell.addWhen.text = todayStr + "   頃"
                }else{
                   cell.addWhen.text = ""
                }
                
                
            }else{
                
                cell.addWhen.text = selectedDT! + "   頃"
                }
            
                if expandflag{
                    cell.addWhen.textColor = UIColor.redColor()
              
                }else{
                    cell.addWhen.textColor = UIColor.blackColor()
                }
        

            let dateExist = selectedDT != nil && selectedDT != "" ? true : false

            
            if !dateExist && !firstTime {
                
                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
                
                cell.addWhen.backgroundColor = honeyDew
            }
            
            
            cell.addName.text = "uminonar"
            
            cell.addWhen.delegate = self //なぜここでいる？
            
            
            // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
            cell.addSwitch.addTarget(self, action: "changeSwitch:", forControlEvents: UIControlEvents.ValueChanged)
            
            var changedSwitch = myDefault.stringForKey("switch")
            
            if ( changedSwitch != nil ){
                cell.addImportance.text = "相談に利用予定"
                cell.addSwitch.on = true
            }else{
                cell.addImportance.text = "念のため記録"
                cell.addSwitch.on = false
            }
            
            
            
            
            return cell
            

        }
        
       
        
        var adjustrow_no = indexPath.row
        
        if expandflag{
            if indexPath.row == 1{


                
                var cell:datePickerTableViewCell = tableView.dequeueReusableCellWithIdentifier("datePickerCell", forIndexPath: indexPath) as! datePickerTableViewCell
                
                cell.addDatePicker.addTarget(self, action: "changedDT:", forControlEvents:UIControlEvents.ValueChanged)
                
                cell.decideBtn.addTarget(self, action: "decideBtn:", forControlEvents:UIControlEvents.TouchUpInside)
                
                return cell
                
            }
            
                adjustrow_no--
            
        }
        
        if adjustrow_no == 1{
                
            var cell:bottomTableViewCell = tableView.dequeueReusableCellWithIdentifier("bottomCell", forIndexPath: indexPath) as! bottomTableViewCell
                
                cell.addWhere.delegate = self
                cell.addWho.delegate = self
                cell.addUniversity.delegate = self
                
            //ユーザーデフォルトを取り出す
            var myDefault = NSUserDefaults.standardUserDefaults()
            
            //大学、データを呼び出して文字列が入っていたら、表示する
            var uniStr = myDefault.stringForKey("uniStr")
            
            if ( uniStr != nil){
                cell.addUniversity.text = uniStr
                cell.addUniversity.textColor = UIColor.darkGrayColor()}
            
            
//            var uniSaveAlert = myDefault.stringForKey("uniSaveAlert")
            let uniExist = uniStr != nil && uniStr != "" ? true : false
            
            if !uniExist && !firstTime {
                
                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
                
                cell.addUniversity.backgroundColor = honeyDew
            }

                
            
            
            
            //場所、データを呼び出して文字列が入っていたら表示する
            var selectedPlace = myDefault.stringForKey("selectedPlace")
            
            if( selectedPlace != nil){
                print(selectedPlace)
                cell.addWhere.text = selectedPlace
                
            }
            
          
//            var placeSaveAlert = myDefault.stringForKey("placeSaveAlert")
            let placeExist = selectedPlace != nil && selectedPlace != "" ? true : false
            
            if !placeExist && !firstTime {
                
                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
                
                cell.addWhere.backgroundColor = honeyDew
            }
            
            
            
            //名前、データを呼び出して文字列が入っていたら表示する
            var selectedName = myDefault.stringForKey("selectedName")
            
            if( selectedName != nil){
                print(selectedName)
                cell.addWho.text = selectedName
            }
            
//            var nameSaveAlert = myDefault.stringForKey("nameSaveAlert")
//            
////            if nameSaveAlert != nil {
//
//                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
//                
//                cell.addWho.backgroundColor = honeyDew
//            }
            
            let nameExist = selectedName != nil && selectedPlace != "" ? true : false
            
            if !nameExist && !firstTime {
                
                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
                
                cell.addWho.backgroundColor = honeyDew
            }
//
            
            
            //Diaryデータを呼び出して文字列が入っていたら表示する
            var diaryText =
                myDefault.stringForKey("diary")
            if((diaryText != nil) && (diaryText != "")){
                print(diaryText)
                cell.addDiary.text = diaryText
                
                cell.addDiary.textColor = UIColor.blackColor()
            }else{
                cell.addDiary.text = "test\ntest2"
                
                
                //行間設定
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 6
                let attributes = [NSParagraphStyleAttributeName : style]
                cell.addDiary.attributedText = NSAttributedString(string: cell.addDiary.text,
                                                                  attributes: attributes)
                //フォントサイズの指定
                cell.addDiary.font = UIFont.systemFontOfSize(15)
                
                //テキストの色指定
                
                // cell.addDiary.textColor = UIColor.lightGrayColor()
                
                
                let silver:UIColor = UIColor(red:0.78,green:0.78,blue:0.78,alpha:1.0)
                
                cell.addDiary.textColor = silver
                
                cell.addDiary.text = ""
                
                
            }
            
//            var diarySaveAlert = myDefault.stringForKey("diarySaveAlert")
//            
//            if diarySaveAlert != nil {
//                
//                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
//                
//                cell.addWho.backgroundColor = honeyDew
//            }
            let diaryExist = diaryText != nil && diaryText != "" ? true : false
            
            if !diaryExist && !firstTime {
                
                let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
                
                cell.addDiary.backgroundColor = honeyDew
            }
            

            //.xibファイルのボタンなどがタップされ時の処理
            
            //postEllipsisBtn等の後に：をつけることで、sender情報を使える
            cell.addWhere.addTarget(self, action:Selector("setWhere:"), forControlEvents:UIControlEvents.EditingDidBegin)
            
            cell.addWho.addTarget(self, action: Selector("setWho:"), forControlEvents:UIControlEvents.EditingDidBegin)
            
            cell.addUniversity.addTarget(self, action: "setUniversity:", forControlEvents: UIControlEvents.EditingDidEndOnExit)//EditingDidEnd?違いは,カーソル離れたとき
            
            //TODO:何がダメ？
            //                cell.addUniversity.tag = sender.text  tagじゃなく(sender.UITextFeield)で。。
            
            
                
            // Add tap gesture recognizer to Text View
            let tap = UITapGestureRecognizer(target: self, action: "setDiary")
            //                tap.delegate = self
            cell.addDiary.addGestureRecognizer(tap)
            
            
            return cell
        }
        
        
        if adjustrow_no == 2{
            var myDefault = NSUserDefaults.standardUserDefaults()
            var photoURLArray:NSMutableArray
            if myDefault.objectForKey("photoURLArray") == nil {
                photoURLArray = []
            } else {
                photoURLArray = myDefault.objectForKey("photoURLArray") as! NSMutableArray
            }
            
            var movieURLArray:NSMutableArray
            if myDefault.objectForKey("photoURLArray") == nil {
                movieURLArray = []
            } else {
                movieURLArray = myDefault.objectForKey("movieURLArray") as! NSMutableArray
            }
            
            
            // if strURL != nil{
            
            if photoURLArray.count > 0 {
                
                var cell:photoTableViewCell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoTableViewCell
                
                
                var arrayNum = photoURLArray.count
                
                //スクロールが走る表示全体サイズを指定。写真の150幅に、20の余白で170
                let scrViewWidth:CGFloat = CGFloat(170 * arrayNum )
                
                
                
                
                //スクロールビューから追加したビューを一旦削除
                removeAllSubviews(cell.scrView)
                
                var subviews = cell.scrView.subviews
                for subview in subviews{
                    subview.removeFromSuperview()
                }
                
                
                
                cell.scrView.contentSize = CGSizeMake(scrViewWidth, 150)
                
                
                countNum = 0
                for strURL in photoURLArray{
                    print(strURL)
                    
                    var url = NSURL(string: strURL as! String)
                    
                    let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                    
                    if fetchResult.firstObject != nil{
                        
                        let asset: PHAsset = fetchResult.firstObject as! PHAsset
                        
                        
//                      print("pixelWidth:\(asset.pixelWidth)");
//                      print("pixelHeight:\(asset.pixelHeight)");
//                        
                        let manager: PHImageManager = PHImageManager()
                        manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                            
                            //imageViewのaspectFitをつける必要がある？このままで良いかも
                            var imageView = UIImageView()
                            
                            //各写真イメージのX座標開始位置をpositionXとする。150幅に、20の余白で170
                            var positionX:CGFloat = CGFloat(170 * self.countNum)
                            
                            //写真の位置サイズ指定
                            imageView.frame = CGRectMake(positionX, 0, 150, 150)
                            imageView.image = image
                            cell.scrView.addSubview(imageView)
                            
                            //写真をキャンセルするボタンイメージを各写真に設置する
                            var picCancelImage = UIImageView()
                            
                            picCancelImage.frame = CGRectMake(positionX+125,0,25,25)
                            picCancelImage.image = UIImage(named:"cancel-red")
                            cell.scrView.addSubview(picCancelImage)
                            
                            //キャンセルボタンの位置に透明ボタンを被せて配置する
                            var picCancelBtn = UIButton()
                            picCancelBtn.setTitle("", forState: .Normal)
                            picCancelBtn.frame = CGRectMake(positionX+125, 0, 25, 25)
                            picCancelBtn.addTarget(self, action: "tapCancel:", forControlEvents:.TouchUpInside)
                            cell.scrView.addSubview(picCancelBtn)
                            
                            
                            self.countNum++
                            
                            
                            //                              cell.picCancelBtn.hidden = false
                        }
                    }
                    
                }

                return cell
                
            } else {
                if movieURLArray.count > 0 {
                    
                    var cell:movieTableViewCell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! movieTableViewCell
                    
                    
                    var arrayNum = movieURLArray.count
                    
                    //スクロールが走る表示全体サイズを指定。写真の150幅に、20の余白で170
                    let scrViewWidth:CGFloat = CGFloat(170 * arrayNum )
                    
                    cell.scrView.contentSize = CGSizeMake(scrViewWidth, 150)
                    
                    //スクロールビューから追加したビューを一旦削除
                    removeAllSubviews(cell.scrView)
                    
//                    var subviews = cell.scrView.subviews
//                    for subview in subviews{
//                        subview.removeFromSuperview()
//                    }
                    

                    countNum = 0
                    for strURL in movieURLArray{
                        print(strURL)
                        
                        var url = NSURL(string: strURL as! String)
                        
                        let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                        
                        if fetchResult.firstObject != nil{
                            
                            let asset: PHAsset = fetchResult.firstObject as! PHAsset
                            
                            
                            print("pixelWidth:\(asset.pixelWidth)");
                            print("pixelHeight:\(asset.pixelHeight)");
                            
                            let manager: PHImageManager = PHImageManager()
                            //ここの５，５００って何？
                            manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                                
                                //imageViewのaspectFitをつける必要がある？このままで良いかも
                                var imageView = UIImageView()
                                
                                //各動画イメージのX座標開始位置をpositionXとする。150幅に、20の余白で170
                                var positionX:CGFloat = CGFloat(170 * self.countNum)
                                
                                //動画像の位置サイズ指定
                                imageView.frame = CGRectMake(positionX, 0, 150, 150)
                                imageView.image = image
                                cell.scrView.addSubview(imageView)
                                
                                //動画をキャンセルするボタンイメージを各写真に設置する
                                var picCancelImage = UIImageView()
                                
                                picCancelImage.frame = CGRectMake(positionX+125,0,25,25)
                                picCancelImage.image = UIImage(named:"cancel-red")
                                cell.scrView.addSubview(picCancelImage)
                                
                                //キャンセルボタンの位置に透明ボタンを被せて配置する
                                var picCancelBtn = UIButton()
                                picCancelBtn.setTitle("", forState: .Normal)
                                picCancelBtn.frame = CGRectMake(positionX+125, 0, 25, 25)
                                picCancelBtn.addTarget(self, action: "tapCancelMovie:", forControlEvents:.TouchUpInside)
                                cell.scrView.addSubview(picCancelBtn)
                                
                                
                                self.countNum++
                                
                                
                                //cell.picCancelBtn.hidden = false
                                
                            } // manager
                            
                        }  //fetchの終わり
                    }  //forの終わり
                }  //if movieURLArray.count > 0の終わり
                
//                return cell ここでエラーが出る。なぜか？
                
            }  //　} else {の終わり
            
            
            
        }  //　adjustrow_no == 2{の終わり
    
    

//            }else{
//    
//                if movieURLArray.count > 0 {
//                    
//                    var cell:movieTableViewCell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! movieTableViewCell
//                    
//                    
//                    var arrayNum = movieURLArray.count
//                    
//                    //スクロールが走る表示全体サイズを指定。写真の150幅に、20の余白で170
//                    let scrViewWidth:CGFloat = CGFloat(170 * arrayNum )
//                    
//                    //スクロールビューから追加したビューを一旦削除
//                    var subviews = cell.scrView.subviews
//                    for subview in subviews{
//                        subview.removeFromSuperview()
//                    }
//                    
//                    
//                    
//                    cell.scrView.contentSize = CGSizeMake(scrViewWidth, 150)
//                    
//                    
//                    countNum = 0
//                    for strURL in movieURLArray{
//                        print(strURL)
//                        
//                        var url = NSURL(string: strURL as! String)
//                        
//                        let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
//                        
//                        if fetchResult.firstObject != nil{
//                            
//                            let asset: PHAsset = fetchResult.firstObject as! PHAsset
//                            
//                            
//                            print("pixelWidth:\(asset.pixelWidth)");
//                            print("pixelHeight:\(asset.pixelHeight)");
//                            
//                            let manager: PHImageManager = PHImageManager()
//                            //ここの５，５００って何？
//                            manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
//                                
//                                //imageViewのaspectFitをつける必要がある？このままで良いかも
//                                var imageView = UIImageView()
//                                
//                                //各写真イメージのX座標開始位置をpositionXとする。150幅に、20の余白で170
//                                var positionX:CGFloat = CGFloat(170 * self.countNum)
//                                
//                                //写真の位置サイズ指定
//                                imageView.frame = CGRectMake(positionX, 0, 150, 150)
//                                imageView.image = image
//                                cell.scrView.addSubview(imageView)
//                                
//                                //写真をキャンセルするボタンイメージを各写真に設置する
//                                var picCancelImage = UIImageView()
//                                
//                                picCancelImage.frame = CGRectMake(positionX+125,0,25,25)
//                                picCancelImage.image = UIImage(named:"cancel-red")
//                                cell.scrView.addSubview(picCancelImage)
//                                
//                                //キャンセルボタンの位置に透明ボタンを被せて配置する
//                                var picCancelBtn = UIButton()
//                                picCancelBtn.setTitle("", forState: .Normal)
//                                picCancelBtn.frame = CGRectMake(positionX+125, 0, 25, 25)
//                                picCancelBtn.addTarget(self, action: "tapCancel:", forControlEvents:.TouchUpInside)
//                                cell.scrView.addSubview(picCancelBtn)
//                                
//                                
//                                self.countNum++
//                                
//                                
//                                //                              cell.picCancelBtn.hidden = false
//                            }
//                        }
//                        
//                    }
    
                
//                var url = NSURL(string: strMovURL as! String!)
//                
//                var playerItem = AVPlayerItem(URL: url!)
//                
//                var videoPlayer : AVPlayer! = AVPlayer(playerItem: playerItem)
                
                //UIViewのレイヤーをAVPlayerLayerにする。普通のviewをカスタマイズしてる
                //                    let layer = cell.movieView.layer as! AVPlayerLayer
                //                    layer.videoGravity = AVLayerVideoGravityResizeAspect
                //                    layer.player = videoPlayer
                
                
                //TODO:この再生ボタンを実装すべし！
                //この一行で再生する、ここにボタンを置いて、押したら、この一行が効くようにすれば良い。
                //layer.player?.play()
                
//                return cell
//                }
//                
//            }
//        }
//        

        if adjustrow_no == 3{
            
            var cell:movieTableViewCell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! movieTableViewCell
            
            var myDefault = NSUserDefaults.standardUserDefaults()
            var movieURLArray = myDefault.objectForKey("movieURLArray") as! NSMutableArray

                
//                var myDefault = NSUserDefaults.standardUserDefaults()
//                var strMovURL = myDefault.stringForKey("selectedMovieList")
//                
//                var url = NSURL(string: strMovURL as! String!)
//                
//                var playerItem = AVPlayerItem(URL: url!)
//                
//                var videoPlayer : AVPlayer! = AVPlayer(playerItem: playerItem)
            
                //UIViewのレイヤーをAVPlayerLayerにする。普通のviewをカスタマイズしてる
//                let layer = cell.movieView.layer as! AVPlayerLayer
//                layer.videoGravity = AVLayerVideoGravityResizeAspect
//                layer.player = videoPlayer
                
                
                //TODO:この再生ボタンを実装すべし！
                //この一行で再生する、ここにボタンを置いて、押したら、この一行が効くようにすれば良い。
                //layer.player?.play()
            
            
            var arrayNum = movieURLArray.count
            
            //スクロールが走る表示全体サイズを指定。写真の150幅に、20の余白で170
            let scrViewWidth:CGFloat = CGFloat(170 * arrayNum )
            
            cell.scrView.contentSize = CGSizeMake(scrViewWidth, 150)
            
            //スクロールビューから追加したビューを一旦削除
            removeAllSubviews(cell.scrView)
            
            
            countNum = 0
            for strURL in movieURLArray{
                print(strURL)
                
                var url = NSURL(string: strURL as! String)
                
                let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                
                if fetchResult.firstObject != nil{
                    
                    let asset: PHAsset = fetchResult.firstObject as! PHAsset
                    
                    
                    print("pixelWidth:\(asset.pixelWidth)");
                    print("pixelHeight:\(asset.pixelHeight)");
                    
                    let manager: PHImageManager = PHImageManager()
                    //ここの５，５００って何？
                    manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                        
                        //imageViewのaspectFitをつける必要がある？このままで良いかも
                        var imageView = UIImageView()
                        
                        //各動画イメージのX座標開始位置をpositionXとする。150幅に、20の余白で170
                        var positionX:CGFloat = CGFloat(170 * self.countNum)
                        
                        //動画像の位置サイズ指定
                        imageView.frame = CGRectMake(positionX, 0, 150, 150)
                        imageView.image = image
                        cell.scrView.addSubview(imageView)
                        
                        //動画をキャンセルするボタンイメージを各写真に設置する
                        var picCancelImage = UIImageView()
                        
                        picCancelImage.frame = CGRectMake(positionX+125,0,25,25)
                        picCancelImage.image = UIImage(named:"cancel-red")
                        cell.scrView.addSubview(picCancelImage)
                        
                        //キャンセルボタンの位置に透明ボタンを被せて配置する
                        var picCancelBtn = UIButton()
                        picCancelBtn.setTitle("", forState: .Normal)
                        picCancelBtn.frame = CGRectMake(positionX+125, 0, 25, 25)
                        picCancelBtn.addTarget(self, action: "tapCancelMovie:", forControlEvents:.TouchUpInside)
                        cell.scrView.addSubview(picCancelBtn)
                        
                        
                        self.countNum++
                        
                        
                    }
                }  //fetchの終わり
            }  //forの終わり
//            return cell
            
        }  //if adjustrow_no == 3の終わり
        
        
        
        


    
    
                // MARK: 写真表示
                //写真が選択された時のURLを取得する -----------------------------
//                var strURL = myDefault.stringForKey("selectedPhotoURL")
//
//                if strURL != nil{
//
//                    var url = NSURL(string: strURL as! String!)
//                    let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
//                    
//                    if fetchResult.firstObject != nil{
//                    
//                        let asset: PHAsset = fetchResult.firstObject as! PHAsset
//                    
//                    
//                        print("pixelWidth:\(asset.pixelWidth)");
//                        print("pixelHeight:\(asset.pixelHeight)");
//                    
//                        let manager: PHImageManager = PHImageManager()
//                        manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFill,options: nil) { (image, info) -> Void in
//                        
//                            cell.picBase.image = image
//                 
//                            cell.picCancelBtn.hidden = false
//                        }
//                    
//                    }
//                    
//                    
//                }else{
//                    
//                        cell.picBase.image = nil
//                        cell.picCancelBtn.hidden = true
//                }
//                
//                cell.picCancelBtn.addTarget(self, action: "cancelPicture", forControlEvents: .TouchUpInside)
//

                
                // MARK: Movie表示
//                //Movieが選択された時のURLを取得する -----------------------------
//                var strMovURL = myDefault.stringForKey("selectedMovieURL")
//                
//                if strMovURL != nil{
//                    
//                     var url = NSURL(string: strMovURL as! String!)
//                    
//                    var playerItem = AVPlayerItem(URL: url!)
//                    
//                    var videoPlayer : AVPlayer! = AVPlayer(playerItem: playerItem)
//                    
//                    //UIViewのレイヤーをAVPlayerLayerにする。普通のviewをカスタマイズしてる
//                    let layer = cell.movieView.layer as! AVPlayerLayer
//                    layer.videoGravity = AVLayerVideoGravityResizeAspect
//                    layer.player = videoPlayer
//                    
//                    
//                    //TODO:この再生ボタンを実装すべし！
//                    //この一行で再生する、ここにボタンを置いて、押したら、この一行が効くようにすれば良い。
//                    //layer.player?.play()
//                    
//                    
//                    cell.movieView.hidden = false
//         
//                    
//                }else{
//                    
//                }
//                
//                
//                
//
//                
//                var picBaseImage = myDefault.stringForKey("pic")
//                
//                if ( picBaseImage != nil ){
//                    //TODO:ここはこれじゃダメ？
////                    cell.picBase.image = picBaseImage
//
//                
//                    return cell
//                
//            
//                }
//                
//                
//                return cell
//
//        
//            }
//    
        //なんでも良いので入れる　ここが６で反映されてしまっている？
        
         var cell:photoTableViewCell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoTableViewCell
        return cell
    }
    

    
    
//    func cancelPicture(){
//        var myDefault = NSUserDefaults.standardUserDefaults()
//        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
//        myDefault.removeObjectForKey("selectedPhotoURL")
//        
//        //TODO:ここ行数を調整して！どうする？
//        let row = NSIndexPath(forRow: 1, inSection: 0)
//        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
//
//        
//        
//    }
    
    func createTableViewCell3(tableView: UITableView,indexPath: NSIndexPath) -> movieTableViewCell{
    
        var cell:movieTableViewCell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! movieTableViewCell
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var strMovURL = myDefault.stringForKey("selectedMovieURL")
        
        var url = NSURL(string: strMovURL as! String!)
        
        var playerItem = AVPlayerItem(URL: url!)
        
        var videoPlayer : AVPlayer! = AVPlayer(playerItem: playerItem)
        
        return cell
    
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
        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        //myTableView.reloadData()
    }
    
    func setWhere(sender:UITextField){
        
        //これで合ってる？これは立ち上がっているキーボードを下す処理
        //self.resignFirstResponder()
        
        let AddWhere = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhereViewController") as UIViewController
        
        presentViewController(AddWhere, animated: true, completion: nil)
    }

    func setWho(sender:UITextField){
        
//        self.resignFirstResponder()

        let AddWho = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhoViewController") as UIViewController
        
        presentViewController(AddWho, animated: true, completion: nil)
        
    }
    
    func setUniversity(sender:UITextField){

        //ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        //データを書き込んで
        myDefault.setObject(sender.text, forKey: "uniStr")
        
        //即反映させる
        myDefault.synchronize()
        
        
        self.resignFirstResponder()

    }
    
    func setDiary(){
        //addDiaryがタップされたら
        let AddDiaryVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("AddDiaryViewController") as UIViewController
        
        // showで遷移するバージョン           navigationController?.pushViewController(AddDiaryVC, animated: true)
        
        // モーダルで遷移するバージョン
        presentViewController(AddDiaryVC, animated: true, completion: nil)
    }
    
    
    
    func changeSwitch(sender: UISwitch){
        var myDefault = NSUserDefaults.standardUserDefaults()

        //addSwitchが変化したら
        if sender.on == true { //== trueはなくても良い
                        myDefault.setObject(true, forKey: "switch")
            myDefault.synchronize()
        
            openFlag = 0
            
            
        }else{
            var myDefault = NSUserDefaults.standardUserDefaults()
            myDefault.setObject(nil, forKey: "switch")//userDefaultにnilは入れられる？
            myDefault.synchronize()
            
            //投稿情報のopenを1にする
            openFlag = 1
        }
        
        // 対象行だけ更新
        let row = NSIndexPath(forRow: 0, inSection: 0)
        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
//    
//    func setPicFileBtn(sender:UIImageView){
//        //pictureFileがタップされた時、カメラロールが現れ、選択された写真がaddImageViewに収められる
//            var photoPick = UIImagePickerController()
//        
//            photoPick.delegate = self
//        
//            photoPick.sourceType = .PhotoLibrary
//            self.presentViewController(photoPick, animated: true, completion: nil)
//    }
//        
//    
//    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//        
//        
//        // ユーザーデフォルトを用意する
//        var myDefault = NSUserDefaults.standardUserDefaults()
//
//        
//        let strTypeMovie:String = kUTTypeMovie as! String
//        
//        if info[UIImagePickerControllerMediaType] as! String == strTypeMovie{
//            //動画
//            var url:NSURL = info[UIImagePickerControllerMediaURL] as! NSURL
//            
//            var strURL:String = url.description//こうすると文字列型に変換できる
//            
//           
//            
//            // データを書き込んで
//            myDefault.setObject(strURL, forKey: "selectedMovieURL")
//
//            
//            
//            
//        }else{
//            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]!
//            
//            var strURL:String = assetURL.description
//
//        
//            // データを書き込んで
//            myDefault.setObject(strURL, forKey: "selectedPhotoURL")
//
//        }
//        

        
        // 即反映させる
//        myDefault.synchronize()
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    




    
//    func movieFileBtn(){
//        var movPick = UIImagePickerController()
//        movPick.delegate = self
//        movPick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        movPick.mediaTypes = [kUTTypeMovie as String]
//        movPick.allowsEditing = false
//        movPick.delegate = self
//        self.presentViewController(movPick, animated: true, completion: nil)
//    }
            
//MARK:次回の実装
//    func tapSound(){
//        let AddSound = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddSoundViewController") as UIViewController
//        
//        presentViewController(AddSound, animated: true, completion: nil)
//
//    }
    

    // delegate didSelectRow
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if 0 == indexPath.row {
            //            // switching open or close
            //            sections[indexPath.section].extended = !sections[indexPath.section].extended
            
            if expandflag {
                expandflag = !expandflag
                self.toContract(tableView, indexPath: indexPath)
                
            }else{
                expandflag = !expandflag
                self.toExpand(tableView, indexPath: indexPath)
            }
            
            
        }
        // deselec
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        
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
        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
    //MARK: cellの高さしてい
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 140
            
        }
        if indexPath.row == 1 {
            if expandflag {
                return 250
            }else{
                return 470
            }
        }
        
        if indexPath.row == 2 {
            if expandflag {
                return 470
            }else{
                return 180
            }
        }
        if indexPath.row == 3 {
            if expandflag {
                return 180
            }else{
                return 180
            }
        }
    
        
        return 180.0//ここの意味は？
    }
    

    @IBAction func cancelBtn(sender: UIButton) {
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        myDefault.removeObjectForKey("selectedDT")
        myDefault.removeObjectForKey("selectedPlace")
        myDefault.removeObjectForKey("selectedName")
//        myDefault.removeObjectForKey("uniStr")
        myDefault.removeObjectForKey("diary")
        myDefault.removeObjectForKey("selectedMovieURL")
        
        myDefault.setObject("true", forKey: "cancel")
        myDefault.removeObjectForKey("stepAdd")
        
        myDefault.synchronize()
        
        self.myApp.photoURLArray = false
        self.myApp.movieURLArray = false
        
        //ここはどうする？ reload()
//        addWhen.text=""
//        addWhere.text=""
//        addWho.text=""
//        addDiary.text=""

        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveBtn(sender: UIButton) {
        
        firstTime = false
        
        
        //必須項目が記入済みか、チェックする ユーザーデフォルトに無い場合は未記入
        //未記入があったら、記入してくださいのアラート
        
        //全て記入済みだったら、
        //データをサーバーに渡す処理
        //UserDefaultのdiaryキーのところを空にする
        
        var myDefault = NSUserDefaults.standardUserDefaults()

        var selectedData = myDefault.stringForKey("selectedDT")
//        if selectedData == nil && selectedData == ""{
//             var myDefault = NSUserDefaults.standardUserDefaults()
//             myDefault.setObject(true, forKey: "dateSaveAlert")
//        }
        
        var selectedPlace = myDefault.stringForKey("selectedPlace")
//        if selectedPlace == nil && selectedPlace == ""{
//            var myDefault = NSUserDefaults.standardUserDefaults()
//            myDefault.setObject(true, forKey: "placeSaveAlert")
//        }

        var selectedName = myDefault.stringForKey("selectedName")
//        if selectedName == nil && selectedName == ""{
//            var myDefault = NSUserDefaults.standardUserDefaults()
//            myDefault.setObject(true, forKey: "nameSaveAlert")
//        }
//        
        var uniStr = myDefault.stringForKey("uniStr")
//        if uniStr == nil && uniStr == ""{
//            var myDefault = NSUserDefaults.standardUserDefaults()
//            myDefault.setObject(true, forKey: "uniSaveAlert")
//        }
        
        var diary = myDefault.stringForKey("diary")
//        if diary == nil && diary == ""{
//            var myDefault = NSUserDefaults.standardUserDefaults()
//            myDefault.setObject(true, forKey: "diarySaveAlert")
//        }
        
        
//        var dateS = myDefault.stringForKey("dateSaveAlert")
//        var placeS = myDefault.stringForKey("placeSaveAlert")
//        var nameS = myDefault.stringForKey("nameSaveAlert")
//        var uniS = myDefault.stringForKey("uniSaveAlert")
//        var diaryS = myDefault.stringForKey("diarySaveAlert")
        
        self.addTableView.reloadData()
        
        let dateExsist = selectedData != nil && selectedData != "" ? true : false
        let placeExist = selectedPlace != nil && selectedPlace != "" ? true : false
        let nameExist = selectedName != nil && selectedName != "" ? true : false
        let univExist = uniStr != nil && uniStr != "" ? true : false
        let diaryExist = diary != nil && diary != "" ? true : false
        
        if (!dateExsist || !placeExist || !nameExist || !univExist || !diaryExist) {
//
//        if (dateS == "true" || placeS == "true" || nameS == "true" || uniS == "true" || diaryS == "true"){
//
            var alertController = UIAlertController(
                title: "必須項目を記入してください",
                message: "",
                preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))
            presentViewController(alertController, animated: true, completion: nil)

            
        }else{
            firstTime = true
            
            //写真と動画のセルを消すための処理
            self.myApp.photoURLArray = false
            self.myApp.movieURLArray = false
            
            //前ページに遷移する　モーダル画面じゃなくので、dismissじゃないバージョン　後学のため残す
            //navigationController?.popViewControllerAnimated(true)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            // まずPOSTで送信したい情報をセット
  
            var uName = myApp.userName
            var uID = myApp.userID
            var selectedDT = myDefault.stringForKey("selectedDT")
            var selectedPlace = myDefault.stringForKey("selectedPlace")
            var selectedName = myDefault.stringForKey("selectedName")
            var diary = myDefault.stringForKey("diary")
            var selectedUniversity = myDefault.stringForKey("uniStr")
            var selectedMovieURL = myDefault.objectForKey("movieURLArray")
            var selectedPhotoURL = myDefault.objectForKey("photoURLArray")
            
            var createTime = String(NSData()) //これで良い？ダメっぽいけど、、、うーん
            var openness = String(self.openFlag) //これで本当にオッケー？
            
            
            
            
//
//            $openFlag = $_POST['open_flag'];
//            $deleteFlag = $_POST['deleteFlag'];
            
            //この一連の処理はここでいる？ ダブルでエンコーディングかけると送れなくなる　下で既にやっている
            let userID = uID
            let userName = uName
            let time = selectedDT!
            let place = selectedPlace!
            let person = selectedName!
            let description = diary!
            let university = selectedUniversity!
            var movie:NSArray
            var movieStr = ""
            if selectedMovieURL == nil{
                movie = []
            } else {
                movie = selectedMovieURL as! NSArray
//                let strMovie = movie.joinWithSeparator(",")
                
//                let array = [1, 2, 3]
//                let nums = array.map { "\($0)" }.joinWithSeparator("-")
//                print(nums)
                
                movieStr = movie.map { "\($0)" }.joinWithSeparator(",")
                print("==========================")
                print("movieStr = \(movieStr)")
                
//
//                movie = selectedMovieURL!
            }
            
            var picture:NSArray
            if selectedPhotoURL == nil{
                picture = []
            } else {
//                picture = selectedMovieURL!
            }

//            let picture = selectedPhotoURL!.dataUsingEncoding(NSUTF8StringEncoding)
            let created = createTime
            let openFlag = openness

            
            
            // dictionaryで送信するJSONデータを生成.
            var myDict:NSMutableDictionary = NSMutableDictionary()
            
            
//            myDict.setObject(, forKey: <#T##NSCopying#>)
            myDict.setObject(userID, forKey: "userID")
            myDict.setObject(userName, forKey: "userName")
            myDict.setObject(time, forKey: "time")
            myDict.setObject(place, forKey: "place")
            myDict.setObject(person, forKey: "person")
            myDict.setObject(description, forKey: "description")
            myDict.setObject(university, forKey: "university")
            myDict.setObject(movieStr, forKey: "movie")
            myDict.setObject("picture", forKey: "picture")
            myDict.setObject(created, forKey: "created")
            myDict.setObject(openFlag, forKey: "openFlag")
            
            // 作成したdictionaryがJSONに変換可能かチェック.
            if NSJSONSerialization.isValidJSONObject(myDict){
                
                // DictionaryからJSON(NSData)へ変換. 
                
                do {
                    json = try NSJSONSerialization.dataWithJSONObject(myDict, options: NSJSONWritingOptions.PrettyPrinted) as NSData
                    // here "jsonData" is the dictionary encoded in JSON data
                    // 生成したJSONデータの確認.
                    print("=========== json ===========")
                    print(NSString(data: json, encoding: NSUTF8StringEncoding)!)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            
         
            //                do {
            //                    let decoded = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [String:String]
            //                    // here "decoded" is the dictionary decoded from JSON data
            //                } catch let error as NSError {
            //                    print(error)
            //                }

                
            // Http通信のリクエスト生成.

            var url = NSURL(string: "http://acahara.angry.jp/post.php")
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            var req = NSMutableURLRequest(URL: url!)
            req.HTTPMethod = "POST"
            // jsonのデータを一度文字列にして、キーと合わせる.
            var myData:NSString = "json=\(NSString(data: json, encoding: NSUTF8StringEncoding)!)"
            
            print("====================================")
            print("myData = \(myData)")
            
            // jsonデータのセット.
            req.HTTPBody = myData.dataUsingEncoding(NSUTF8StringEncoding)

            var task = session.dataTaskWithRequest(req, completionHandler: {
                (data, resp, err) in
                
                print(resp!.URL!)
                
                print("data = \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
//                print("data = \(data)")
                print("err = \(err)")
                
            })
            task.resume()
        }
        
        
        
        //保存されるデータをユーザーデフォルトから削除
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        myDefault.removeObjectForKey("selectedDT")
        myDefault.removeObjectForKey("selectedPlace")
        myDefault.removeObjectForKey("selectedName")
        //        myDefault.removeObjectForKey("uniStr")
        myDefault.removeObjectForKey("diary")
        myDefault.removeObjectForKey("movieURLArray")
        myDefault.removeObjectForKey("photoURLArray")
        
        //userDefaultにデータを書き込んで保存したことを書き込む
        //howToAddVCから来たのでない場合には、という条件を付ける
        
        var howToAdd = myDefault.stringForKey("howToAdd")
        if howToAdd == nil{
        
        myDefault.setObject("true", forKey: "saveSuccess")
        
        //即反映させる
        myDefault.synchronize()

        }
    }

//            // 古い書き方
//            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
//            var dic = NSJSONSerialization.JSONObjectWithData(data!, options:nil, error: nil) as NSDictionary

            // 新しい書き方
            
            
//            var abc = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
//            
//            var abc = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
        
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{

        
        if textField.tag == 1000{
            let row = NSIndexPath(forRow: 0, inSection: 0)
            
            if expandflag {
                expandflag = !expandflag
                self.toContract(addTableView, indexPath: row)
                
                
                
            }else{
                expandflag = !expandflag
                self.toExpand(addTableView, indexPath: row)
            }
            return false
        
        }
        
        // setWhere
        if textField.tag == 2000{
            
            
            self.setWhere(textField)
            return false
        }
        
        // addWho
        if textField.tag == 3000{
            self.setWho(textField)
            return false
        }else{
    
            return true
        }
    }
    
    func decideBtn(sender:UIButton){
        let row = NSIndexPath(forRow: 0, inSection: 0)
        expandflag = !expandflag
        self.toContract(addTableView, indexPath: row)
        

        
    }
    

    //addUniversityのテキストフィールドは、returnタップ時にユーザーデフォルトに収め、キーボーードも立ち上げたいので他のテキストフィールドとは処理を分けている
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 4000{
            
            //キーボード制御に利用
            textField.delegate = self
            
//            //スクロール位置を指定
//            addTableView.contentOffset = CGPointMake(0,300);
            
            //ユーザーデフォルトを用意する
            let myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            myDefault.setObject(textField.text, forKey:
                "uniStr")
            
            //即反映させる
            myDefault.synchronize()
            
            return true
        }
        
        return true
        
    }

    // セルの選択を禁止する
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil;
    }
    
    
    //写真のキャンセルボタンがタップされた時に、その写真を消す処理
    func tapCancel(sender:UIButton){
        
        print("cancel")
        
        var xPosition = sender.frame.origin.x
        
        var picPostionX = xPosition - 125
        
        var numOfPic = picPostionX/170
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var photoURLArray = myDefault.objectForKey("photoURLArray") as! NSArray
//        var copiedPhotoURLArray:[NSArray] = photoURLArray as! [NSArray]
//        var photoArray = NSMutableArray(array: copiedPhotoURLArray) as! NSMutableArray
//        
        var photoArray:NSMutableArray = photoURLArray.mutableCopy() as! NSMutableArray
        
        photoArray.removeObjectAtIndex(Int(numOfPic))
        
        print(photoArray)
        
        //選択している画像がゼロになったらセルを一段減らす必要がある
        if photoArray.count == 0 {
            rownumber--
            myApp.photoURLArray = false
        }
        
        
        myDefault.setObject(photoArray, forKey: "photoURLArray")
        myDefault.synchronize()
        
        
        //ここわからないから全体をリロードひとまずする
//        let row = NSIndexPath(forRow: 3, inSection: 0)
//        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        addTableView.reloadData()
 
        
    }
    
    //画像イメージのキャンセルボタンがタップされた時に、その写真を消す処理
    func tapCancelMovie(sender:UIButton){
        
        print("cancel")
        
        var xPosition = sender.frame.origin.x
        
        var picPostionX = xPosition - 125
        
        var numOfPic = picPostionX/170
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var movieURLArray = myDefault.objectForKey("movieURLArray") as! NSArray
        //        var copiedPhotoURLArray:[NSArray] = photoURLArray as! [NSArray]
        //        var photoArray = NSMutableArray(array: copiedPhotoURLArray) as! NSMutableArray
        //
        var movieArray:NSMutableArray = movieURLArray.mutableCopy() as! NSMutableArray
        
        movieArray.removeObjectAtIndex(Int(numOfPic))
        
        print(movieArray)
        
        //選択している画像がゼロになったらセルを一段減らす必要がある
        if movieArray.count == 0 {
            rownumber--
            myApp.movieURLArray = false
        }
        
        
        myDefault.setObject(movieArray, forKey: "movieURLArray")
        myDefault.synchronize()
        
        
        //ここわからないから全体をリロードひとまずする
        //        let row = NSIndexPath(forRow: 3, inSection: 0)
        //        addTableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
        addTableView.reloadData()
        
        
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//// CustomTextField Class
//class CustomTextField: UITextField {
//    
////    var cell:dateTimeTableViewCell = tableView.dequeueReusableCellWithIdentifier("dateTimeCell", forIndexPath: indexPath) as! dateTimeTableViewCell
////    
////     var cell:bottomTableViewCell = tableView.dequeueReusableCellWithIdentifier("bottomCell", forIndexPath: indexPath) as! bottomTableViewCell
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        // タップ時のカラー
//        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.backgroundColor = UIColor.whiteColor()
//    }
//}
