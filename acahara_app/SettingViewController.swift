//
//  SecondViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices
//import AssetsLibrary
import Photos
import AVFoundation

class SettingViewController: UIViewController,UITextFieldDelegate, UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate {
    
    //下記の２つの設定はテキストフィールドがキーボードに隠れてしまわないように設定するためのもの
   
    var txtActiveField = UITextField()
    
    var existFlag = 1
    var emailFlag = 1

    
    var myApp = UIApplication.sharedApplication()
        .delegate as! AppDelegate
    
    var json:NSData!
    
    @IBOutlet weak var saveBtn: UIImageView!
    @IBOutlet weak var settingMenu: UIImageView!
    @IBOutlet weak var menuCoverBtn: UIButton!
    
    @IBOutlet weak var settingSelfee: UIImageView!
    @IBOutlet weak var settingSelgeeC: UIImageView!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var confirmEmailField: UITextField!
    @IBOutlet weak var contactEmailField: UITextField!

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var sentToEmail: UILabel!
    @IBOutlet weak var confirmEmail: UILabel!
    @IBOutlet weak var contactMail: UILabel!
    
    @IBOutlet weak var scrView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //テキストフィールドがキーボードに隠れないようにするための設定
       
        scrView.delegate = self;

        scrView.contentSize = CGSize(width: 250,height: 1000)
     
        
        // Delegateを設定する.
        nameField.delegate = self
        emailField.delegate = self
        confirmEmailField.delegate = self
        contactEmailField.delegate = self
    
        
        //selfee画像をセットする。デフォルトにあればそちらを、なければ、初期のselfee.JPGをセットする。
    
        var myDefault = NSUserDefaults.standardUserDefaults()
        var urlStr = myDefault.stringForKey("selfeeURL")
        
        if urlStr != nil{
            
            var url = NSURL(string: urlStr!)

            let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
            
            if fetchResult.firstObject != nil{
                
                let asset: PHAsset = fetchResult.firstObject as! PHAsset
                
                // print("pixelWidth:\(asset.pixelWidth)");
                // print("pixelHeight:\(asset.pixelHeight)");

                let manager: PHImageManager = PHImageManager()
                manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                    
                //imageViewのaspectFitをつける必要がある？このままで良いかも
                self.settingSelfee.image = image

                }
            }
            
        }else{
            
            settingSelfee.image = UIImage(named:"selfee.JPG")
            myDefault.setObject("selfee.JPT", forKey: "selfeeURL")
            
        }
        
        let selCamera = FAKFontAwesome.cameraIconWithSize(16)
        selCamera.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightTextColor())
        let selCameraImg = selCamera.imageWithSize(CGSizeMake(16, 16))
        settingSelgeeC.image = selCameraImg
        
        let save = FAKFontAwesome.hddOIconWithSize(25)
        
        let saveImage = save.imageWithSize(CGSizeMake(25, 25))
        
        saveBtn.image = UIImage(named:"dataBase")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        saveBtn.tintColor = UIColor.whiteColor()

        
        //sideBar向け
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        
        settingMenu.image = UIImage(named:"menu")?.imageWithRenderingMode(.AlwaysTemplate)
        
        settingMenu.tintColor = UIColor.whiteColor()
        
        self.menuCoverBtn.addTarget(SSASideMenu(), action: Selector("presentLeftMenuViewController"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //既に設定されている内容があれば各フォームに記入
        
        var setName = myDefault.stringForKey("setName")
        if ( setName != nil){
            nameField.text = setName
        }
        
        var email = myDefault.stringForKey("setEmail")
        if ( email != nil){
            emailField.text = email
        }
        
        var confEmail = myDefault.stringForKey("confirmEmail")
        if ( confEmail != nil){
            confirmEmailField.text = confEmail
        }
        
        var contactEmail = myDefault.stringForKey("contactEmail")
        if ( contactEmail != nil){
            contactEmailField.text = contactEmail
        }
        
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
        txtActiveField = textField
        
        //       scrView.setContentOffset(CGPointMake(0, 250), animated: true)
        return true
    }
    
    //エンターが押された時に呼ばれる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        txtActiveField = textField
        textField.resignFirstResponder()
        
        if textField.tag == 2000 || textField.tag == 3000 || textField.tag == 4000 {
            
            var testEmail =  isValidEmail(textField.text!)
            if testEmail == false{
                
                emailFlag = 1
                animateBackgroundColor(txtActiveField)
                
            }else{
                emailFlag = 0
                txtActiveField.backgroundColor = UIColor.whiteColor()
            }

        }
        
        return true
    }
    

    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit {
            scrView.contentOffset.y = txtLimit - kbdLimit + 80 //ヘッダー６５の幅分、ずれるのかな？
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scrView.contentOffset.y = 0
    }



    @IBAction func selfeeCBtn(sender: UIButton) {
        
        //画像選択をして、それをselfeeimageと取り替える
        
        let picker = QBImagePickerController()
        picker.delegate = self
        
        
        //ここを写真だけ選択可能にしたい。falseにしても変わらない。どうすれば？
        picker.allowsMultipleSelection = true;
        
        
        //選択可能枚数最大1枚
        picker.maximumNumberOfSelection = 1;
        
        picker.assetCollectionSubtypes = [
            PHAssetCollectionSubtype.SmartAlbumUserLibrary.rawValue,
            PHAssetCollectionSubtype.AlbumMyPhotoStream.rawValue
        ];
        
        
        //MARK: 写真のみ選択 (ImageをVideoで動画選択)
        picker.mediaType = QBImagePickerMediaType.Image
        
        presentViewController(picker, animated: true, completion: nil)

    }
    
    
    func qb_imagePickerController(imagePickerController: QBImagePickerController, didFinishPickingAssets assets: [AnyObject]) {

        var selectedPicture = assets
        
        //URL取得の場合
        print("select = \(selectedPicture.description)")
        
        let divideURL = selectedPicture.description.componentsSeparatedByString("=")
        let arrayURL = divideURL[1].componentsSeparatedByString("/")
        var mediaType = arrayURL[0]
        
        //配列にして入れる関数 asset_each.descriptionをpoした場合に、ある情報を３つの配列に分ける。
        let urlArray = selectedPicture.description.componentsSeparatedByString("/")
        
        let urlArray2 = urlArray[0].componentsSeparatedByString(" ")
        
        //            photoURLArray.append("assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG")
        
        let assetURL = "assets-library://asset/asset.JPG?id="+urlArray2[2]+"&ext=JPG"
        print(assetURL)
        
        //ここのプロセスあってる？
        var url = NSURL(string: assetURL as! String)
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
        
        if fetchResult.firstObject != nil{

            let asset: PHAsset = fetchResult.firstObject as! PHAsset
            
            // print("pixelWidth:\(asset.pixelWidth)");
            // print("pixelHeight:\(asset.pixelHeight)");
            
            
            let manager: PHImageManager = PHImageManager()
            manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                
                //imageViewのaspectFitをつける必要がある？このままで良いかも
                 self.settingSelfee.image = image
            }
        }


            //UserDefaultに配列を保存
            var myDefault = NSUserDefaults.standardUserDefaults()
            myDefault.setObject(assetURL, forKey: "selfeeURL")
  
            myDefault.synchronize()
 
        
        dismissViewControllerAnimated(true, completion: nil)

        
    }
    


    @IBAction func tapSave(sender: UIButton) {
        
        existFlag = 0
        emailFlag = 0
   
        //まず保存したい情報をそれぞれ取得する
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        var selfeeURL = myDefault.stringForKey("selfeeURL")
        var setName = nameField.text
        var setEmail = emailField.text
        var confirmEmail = confirmEmailField.text
        var contactEmail = contactEmailField.text
   

        //未記入がないか、メールアドレスがあっているか確認
        let nameExsist = setName != nil && setName != "" ? true : false
        let mailExist = setEmail != nil && setEmail != "" ? true : false
        let confirmExist = confirmEmail != nil && confirmEmail != "" ? true : false
        let contactExist = contactEmail != nil && contactEmail != "" ? true : false
        
        //メどこかに未記入がある場合
        if (!nameExsist || !mailExist || !confirmExist || !contactExist ) {
            
            //filled = false このやり方はリロードをかける必要があって、tableVCには向くけどVCだとstoryBDやxibを使うときできない
            //アニメーションで未記入のテキストフィールドに背景色をかける　下部にfuncを記述　考えすぎ、普通に背景色を変えるfuncで良い
            
            existFlag = 1
            
            if !nameExsist {
                animateBackgroundColor(nameField)
            }
            
            if !mailExist {
                animateBackgroundColor(emailField)
            }
            
            if !confirmExist {
                animateBackgroundColor(confirmEmailField)
            }
            
            if !contactExist {
                animateBackgroundColor(contactEmailField)
            }
            
        }
     
        if( mailExist && confirmExist && setEmail != confirmEmail){
            
            emailFlag = 1
            
            animateBackgroundColor(emailField)
            animateBackgroundColor(confirmEmailField)
            
        }
        
        if (existFlag == 1 && emailFlag == 0){
            
            alertController("必須項目を記入してください", Message: "")
        }
        
        if (existFlag == 0 && emailFlag == 1){
            
            alertController("メールアドレスをご確認ください", Message: "")
        }

        if ( existFlag == 1 && emailFlag == 1 ){
            
            alertController("必須項目を記入しメールアドレスをご確認ください", Message: "")
        }
        
        
        //記入漏れがなく、メールアドレスもあっている場合
        if ( existFlag == 0 && emailFlag == 0 ){
            
            //まずデータをデフォルトにセット
            myDefault.setObject("setName", forKey: "setName")
            myDefault.setObject("setEmail", forKey: "setEmail")
            myDefault.setObject("confirmEmail", forKey: "confirmEmail")
            myDefault.setObject("contactEmail", forKey: "contactEmail")
        
            //サーバーに送りたいデータをエンコーディング
            let userName = setName!.dataUsingEncoding(NSUTF8StringEncoding)
            let sentToEmail = setEmail!.dataUsingEncoding(NSUTF8StringEncoding)
            let confirmMail = confirmEmail!.dataUsingEncoding(NSUTF8StringEncoding)
            let contactMail = contactEmail!.dataUsingEncoding(NSUTF8StringEncoding)
            let selfURL = selfeeURL!.dataUsingEncoding(NSUTF8StringEncoding)
            
            // dictionaryで送信するJSONデータを生成.
            var myDict:NSMutableDictionary = NSMutableDictionary()
            
            myDict.setObject("userName", forKey: "userName")
            myDict.setObject("sentToEmail", forKey: "sentToEmail")
            myDict.setObject("contactMail", forKey: "contactMail")
            myDict.setObject("selfURL", forKey: "selfURL")

    
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
  
            
        // Http通信のリクエスト生成.
            
        var url = NSURL(string: "http://acahara-kill-app.sakuca.ne.jp/user.php")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        var req = NSMutableURLRequest(URL: url!)
        req.HTTPMethod = "POST"
            
        // jsonのデータを一度文字列にして、キーと合わせる.
        var myData:NSString = "json=\(NSString(data: json, encoding: NSUTF8StringEncoding)!)"
        
        // jsonデータのセット.
        req.HTTPBody = myData.dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(req, completionHandler: {
            (data, resp, err) in
            print(resp!.URL!)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        })
        task.resume()
            
        }
    }//tapSavedの終わり
    
    
    
    func alertController(Title:String, Message:String){
        
        var alertController = UIAlertController(
            title: Title,
            message: Message,
            preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))
        presentViewController(alertController, animated: true, completion: nil)

        
    }
    
    
    
    
    
    
 
    func animateBackgroundColor(textField: UITextField) {
        
   //テキストフィールドが未記入だったり、メールアドレスが確認メールアドレスと合致しないときに背景色をアニメーションで変更する　下は失敗　でも点滅する面白いアニメーションができる！もっとシンプルに背景色を変えれば良い
        
//        let backgroundColorAnimation: CABasicAnimation = CABasicAnimation(keyPath: "backgroundColor")
//        backgroundColorAnimation.fromValue = UIColor.clearColor().CGColor
//        let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)
//        backgroundColorAnimation.toValue = honeyDew.CGColor
//        backgroundColorAnimation.duration = 0.1
//        backgroundColorAnimation.autoreverses = true
//        backgroundColorAnimation.repeatCount = FLT_MAX
//        textField.layer.addAnimation(backgroundColorAnimation, forKey: "BackgroundColor")
        
        
        let honeyDew :UIColor = UIColor(red:0.863,green:0.976,blue:0.643,alpha:1.0)

        textField.backgroundColor = honeyDew

    } 

    func isValidEmail(string: String) -> Bool {
        print("validate calendar: \(string)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(string)
        return result
    }
    
    




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

