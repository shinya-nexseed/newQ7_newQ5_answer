//
//  AddDiaryViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/29.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices
//import AssetsLibrary
import Photos
import AVFoundation

var imagecount = 0
var photoFlag = false
var movieFlag = false



class AddDiaryViewController: UIViewController, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate {
    
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var header: UIView!

 
    @IBOutlet weak var diaryTextView: UITextView!

    @IBOutlet weak var cancelBtn: UIButton!

    @IBOutlet weak var saveBtn: UIImageView!
    
    var selectedPhoto:[String] = []
    var selectedMovie:[String] = []

    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        diaryTextView.delegate = self
        
        
        
        //もしあらかじめテキストが記述されていなければ、カーソルが反転してキーボードが表示される処理
        //もしテキストがあれば編集箇所を選んでカーソルを当てられる方が親切だから
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var diaryText = myDefault.stringForKey("diary")
        if diaryText != nil && diaryText != "" {
        
             diaryTextView.resignFirstResponder()
      
        }else{
            
             diaryTextView.becomeFirstResponder()
        }

        
//履歴全件削除の設定 1回使ったらコメントアウト
//        var myDefault = NSUserDefaults.standardUserDefaults()
//        
//        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
//                myDefault.removePersistentDomainForName(appDomain)
        
        //決定ボタンや写真、動画を選択するイメージのついたラベルをキーボードの上に設置
        var accessoryView = UIView(frame: CGRectMake(0, 178, 320, 40))
        
        accessoryView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
        
        var closeCoverButton = UIButton(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
        
        var closeImage = UIImageView(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
        
        var photoImage = UIImageView(frame: CGRectMake(20, 8, 25, 25))
        
        var photoCoverBtn = UIButton(frame: CGRectMake(20,8,25,25))
        
        
        
        var filmImage = UIImageView(frame: CGRectMake(75,8,25,25))
        
        var filmCoverBtn = UIButton(frame: CGRectMake(75,8,25,25))
       

        
        
        
        
        photoImage.image = UIImage(named:"photoImage")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura2:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        
        photoImage.tintColor = sakura2
        
        
        filmImage.image = UIImage(named:"film")?.imageWithRenderingMode(.AlwaysTemplate)
        
       
        filmImage.tintColor = sakura2
        
        
        
        closeImage.image = UIImage(named:"arrowDown")?.imageWithRenderingMode(.AlwaysTemplate)
  
        closeImage.tintColor = sakura2
        

        
        closeCoverButton.addTarget(self, action: "onClickCloseButton:", forControlEvents: .TouchUpInside)
        photoCoverBtn.addTarget(self, action: "onClickPhotoButton:", forControlEvents: .TouchUpInside)
        filmCoverBtn.addTarget(self, action: "onClickFilmButton:", forControlEvents: .TouchUpInside)
        

        
        accessoryView.addSubview(closeImage)
        accessoryView.addSubview(closeCoverButton)
        accessoryView.addSubview(photoImage)
        accessoryView.addSubview(photoCoverBtn)
        accessoryView.addSubview(filmImage)
        accessoryView.addSubview(filmCoverBtn)
        

        diaryTextView.inputAccessoryView = accessoryView
        

        
        
        //保存ボタンのイメージを設置して色変更
        saveBtn.image = UIImage(named:"check")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        saveBtn.tintColor = sakura

        
        
        
    }
    
    
    //キーボードの上にあるバーの下矢印アイコンをタップしたらキーボードを下げ、全文表示する処理
    func onClickCloseButton(sender: UIButton) {
        
        diaryTextView.resignFirstResponder()

        
    }
    
    //photoCoverBtnがタップされた時、写真を選択できる一覧を表示
    func onClickPhotoButton(sender: UIButton){

        let picker = QBImagePickerController()
        picker.delegate = self
        
        
        //ここを写真だけ選択可能にしたい。falseにしても変わらない。どうすれば？
        picker.allowsMultipleSelection = true;
        
        
        //選択可能枚数最大５枚
        //picker.minimumNumberOfSelection = 1;
        picker.maximumNumberOfSelection = 30;
        
        picker.assetCollectionSubtypes = [
            PHAssetCollectionSubtype.SmartAlbumUserLibrary.rawValue,
            PHAssetCollectionSubtype.AlbumMyPhotoStream.rawValue
        ];
        
        
        //MARK: 写真のみ選択 ImageをVideoで動画選択
        picker.mediaType = QBImagePickerMediaType.Image
        
        presentViewController(picker, animated: true, completion: nil)

    
    }
    
    //movieCoverBtnがタップされた時、動画を選択できる一覧を表示
    func onClickFilmButton(sender: UIButton){

        
        let picker = QBImagePickerController()
        picker.delegate = self
        
        //複数枚選択を可能にする
        picker.allowsMultipleSelection = true;
        
        
        //picker.minimumNumberOfSelection = 1;
        //最大選択枚数５
        picker.maximumNumberOfSelection = 10;
        
        picker.assetCollectionSubtypes = [
            PHAssetCollectionSubtype.SmartAlbumUserLibrary.rawValue,
            PHAssetCollectionSubtype.AlbumMyPhotoStream.rawValue
        ];
        

        //MARK: 動画のみ選択
        picker.mediaType = QBImagePickerMediaType.Video
        
        presentViewController(picker, animated: true, completion: nil)
        
        //ここをflagで場合分け　必ず片方を逆に
        var photoFlag = false
        var movieFlag = true

    }
   
    
    func qb_imagePickerController(imagePickerController: QBImagePickerController, didFinishPickingAssets assets: [AnyObject]) {
        
        
        
        imagecount = 0
        var photoURLArray:NSMutableArray = []
        var movieURLArray:NSMutableArray = []

        
        //保存前に再検索にきた時のために一度ここで空にしておきたい。
        //ここは配列を空にするだけでは足りなくて、scrViewにaddされている画像を消す必要があった、後で処理している
//        photoURLArray.removeAllObjects()
        
//        if photoFlag {
        
        for asset in assets {
            var asset_each = asset as! PHAsset
            imagecount++
            
            //URL取得の場合
            print(asset_each.description)
            
            let divideURL = asset_each.description.componentsSeparatedByString("=")
            let arrayURL = divideURL[1].componentsSeparatedByString("/")
            var mediaType = arrayURL[0]
            
            
            //もしも選択されたものが写真タイプだったら
            if mediaType == "1" {
                
                //          配列にして入れる関数 asset_each.descriptionをpoした場合に、ある情報を３つの配列に分ける。
                let urlArray = asset_each.description.componentsSeparatedByString("/")
                
                let urlArray2 = urlArray[0].componentsSeparatedByString(" ")
                
                //            photoURLArray.append("assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG")
                
                let assetURL = "assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG"
                print(assetURL)
                
                
                // photoURLArray.addObject(assetURL) as! NSMutableArray
                
                photoURLArray.addObject(assetURL)
                
            }
            
            
            //もしも選択されたものが動画タイプだったら
            if mediaType == "2" {
                
                //          配列にして入れる関数 asset_each.descriptionをpoした場合に、ある情報を３つの配列に分ける。
                let movieArray = asset_each.description.componentsSeparatedByString("/")
                
                let movieArray2 = movieArray[0].componentsSeparatedByString(" ")
                
                //            photoURLArray.append("assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG")
                
                //TODO:ここがJPGをMOVに変えただけではダメ
                let movieURL = "assets-library://asset/asset.MOV?id="+movieArray2[2]+"&ext=MOV"
                print(movieURL)
                
                
                movieURLArray.addObject(movieURL)
                
            }
    
        
            //UserDefaultに配列を保存
            var myDefault = NSUserDefaults.standardUserDefaults()
            myDefault.setObject(photoURLArray, forKey: "photoURLArray")
            myDefault.setObject(movieURLArray, forKey: "movieURLArray")
            myDefault.synchronize()
            
        }
        

        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
 
 
    
    
    override func viewWillAppear(animated: Bool) {
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var diary = myDefault.stringForKey("diary")
        
        if( diary != nil){
            diaryTextView.text = diary
            
            
            //フォントサイズの指定
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            let attributes = [NSParagraphStyleAttributeName : style]
            diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text,
                                                              attributes: attributes)
            diaryTextView.font = UIFont.systemFontOfSize(17)
            
            
        }else{
            //何も記載されてない場合
            
        
            diaryTextView.text = "test\ntest2"
            
            //フォントサイズの指定
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            let attributes = [NSParagraphStyleAttributeName : style]
            diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text,
                                                              attributes: attributes)
            diaryTextView.font = UIFont.systemFontOfSize(17)
            diaryTextView.text = ""
            
            //MARK:先頭にカーソルを合わせる
//            diaryTextView.selectedRange = NSMakeRange(0, 0)
            

        }
        
        //写真か動画が選択されたら横スクロールを動的に配置する、もし既に写真か動画が選択されている場合、２段目のスクロールを動的に配置する。高さ幅は小さめで。
        
        
        
        
//        
//        以下、参考に置く
//        
//        var myDefault = NSUserDefaults.standardUserDefaults()
//        var photoURLArray = myDefault.objectForKey("photoURLArray") as! NSMutableArray
//        var movieURLArray = myDefault.objectForKey("movieURLArray") as! NSMutableArray
//        
//        
//        // if strURL != nil{
//        
//        if photoURLArray.count > 0 {
//            
//            var cell:photoTableViewCell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoTableViewCell
//            
//            
//            var arrayNum = photoURLArray.count
//            
//            //スクロールが走る表示全体サイズを指定。写真の150幅に、20の余白で170
//            let scrViewWidth:CGFloat = CGFloat(170 * arrayNum )
//            
//            
//            
//            
//            //スクロールビューから追加したビューを一旦削除
//            removeAllSubviews(cell.scrView)
//            
//            var subviews = cell.scrView.subviews
//            for subview in subviews{
//                subview.removeFromSuperview()
//            }
//            
//            
//            
//            cell.scrView.contentSize = CGSizeMake(scrViewWidth, 150)
//            
//            
//            countNum = 0
//            for strURL in photoURLArray{
//                print(strURL)
//                
//                var url = NSURL(string: strURL as! String)
//                
//                let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
//                
//                if fetchResult.firstObject != nil{
//                    
//                    let asset: PHAsset = fetchResult.firstObject as! PHAsset
//                    
//                    
//                    //                      print("pixelWidth:\(asset.pixelWidth)");
//                    //                      print("pixelHeight:\(asset.pixelHeight)");
//                    //
//                    let manager: PHImageManager = PHImageManager()
//                    manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
//                        
//                        //imageViewのaspectFitをつける必要がある？このままで良いかも
//                        var imageView = UIImageView()
//                        
//                        //各写真イメージのX座標開始位置をpositionXとする。150幅に、20の余白で170
//                        var positionX:CGFloat = CGFloat(170 * self.countNum)
//                        
//                        //写真の位置サイズ指定
//                        imageView.frame = CGRectMake(positionX, 0, 150, 150)
//                        imageView.image = image
//                        cell.scrView.addSubview(imageView)
//                        
//                        //写真をキャンセルするボタンイメージを各写真に設置する
//                        var picCancelImage = UIImageView()
//                        
//                        picCancelImage.frame = CGRectMake(positionX+125,0,25,25)
//                        picCancelImage.image = UIImage(named:"cancel-red")
//                        cell.scrView.addSubview(picCancelImage)
//                        
//                        //キャンセルボタンの位置に透明ボタンを被せて配置する
//                        var picCancelBtn = UIButton()
//                        picCancelBtn.setTitle("", forState: .Normal)
//                        picCancelBtn.frame = CGRectMake(positionX+125, 0, 25, 25)
//                        picCancelBtn.addTarget(self, action: "tapCancel:", forControlEvents:.TouchUpInside)
//                        cell.scrView.addSubview(picCancelBtn)
//                        
//                        
//                        self.countNum++
//                        
//                        
//                        //                              cell.picCancelBtn.hidden = false
//                    }
//                }
//                
//            }
//            
//            return cell
//
//        ここまで参考
//        
//        
//        
//        
//        
        
        
        
        //キーボードがテキストに被らないようにする下処理、キーボードの動きを感知？
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillChangeFrame:",
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
 
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)

        
//        //キーボードがテキストに被らないようにする処理
//        NSNotificationCenter.defaultCenter().removeObserver(self,
//                                                            name: UIKeyboardWillShowNotification,
//                                                            object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self,
//                                                            name: UIKeyboardWillHideNotification,
//                                                            object: nil)
//        
//        
    }

    func keyboardWillChangeFrame(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyBoardValue : NSValue = userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue
            var keyBoardFrame : CGRect = keyBoardValue.CGRectValue()
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
            
            
            
            self.bottomLayoutConstraint.constant = keyBoardFrame.height + 8
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }

        
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {

        
        if let userInfo = notification.userInfo {
            
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
 
            self.bottomLayoutConstraint.constant = 8
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }

        
    }


    @IBAction func saveBtn(sender: UIButton) {
        
        var diaryText = diaryTextView.text
    
        //if ((diaryText != nil) && (diaryText != "")){
            //ユーザーデフォルトを用意する
            var myDefault = NSUserDefaults.standardUserDefaults()
            //データを書き込んで
            myDefault.setObject(diaryText, forKey: "diary")
            
            //即反映させる
            myDefault.synchronize()
        
        diaryTextView.resignFirstResponder()
            
        self.dismissViewControllerAnimated(true, completion: nil)
        //}
        
    }
    
    
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        diaryTextView.resignFirstResponder()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //キャンセルがされた時の処理
    func qb_imagePickerControllerDidCancel(imagePickerController: QBImagePickerController!) {
        //モーダル画面を落とす
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
