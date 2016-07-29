//
//  MailContentViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class MailContentViewController: UIViewController, UITextViewDelegate{
    
    var personT = ["professor":"教授","assailant":"加害者","committee":"委員会","psycotherapist":"心理療法士","lawyer":"弁護士","friend":"友達"]


//    @IBOutlet var advisorsView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var checkBtn: UIImageView!
    @IBOutlet weak var personType: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mailTextView: UITextView!
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paleGreen:UIColor = UIColor(red: 0.914, green: 0.980, blue: 0.950, alpha: 1.0)
        
//        headerView.backgroundColor = paleGreen
        
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        var pType = myDefault.stringForKey("selectedAdvisor")
        
        if( pType != nil){
            print(pType)
            personType.text = personT[pType!]!+"向け"
        
            mailTextView.delegate = self
            
            //最初からカーソルが反転してキーボードが表示される処理
            mailTextView.becomeFirstResponder()
            
            //履歴全件削除の設定 1回使ったらコメントアウト
            //        var myDefault = NSUserDefaults.standardUserDefaults()
            //
            //        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
            //                myDefault.removePersistentDomainForName(appDomain)
            
            //決定ボタンのついたラベルをキーボードの上に設置
            var accessoryView = UIView(frame: CGRectMake(0, 178, 320, 40))
            
            accessoryView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
            
            
            var closeCoverButton = UIButton(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
            
            var closeImage = UIImageView(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
            
            
            closeImage.image = UIImage(named:"arrowDown")?.imageWithRenderingMode(.AlwaysTemplate)
            
            let sakura2:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
            closeImage.tintColor = sakura2
            
            
            
            closeCoverButton.addTarget(self, action: "onClickCloseButton:", forControlEvents: .TouchUpInside)

            
            accessoryView.addSubview(closeImage)
            accessoryView.addSubview(closeCoverButton)
            
            mailTextView.inputAccessoryView = accessoryView
            
            
          
        
            
            
            
            
            
//            let times = FAKFontAwesome.timesIconWithSize(25)
//            
//            let timesImage = times.imageWithSize(CGSizeMake(25, 25))
//            
//            cancelBtn.setImage(timesImage, forState: .Normal)
            
            
//            let inbox = FAKFontAwesome.inboxIconWithSize(25)
//            
//            let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
//            
//            inbox.addAttribute(NSForegroundColorAttributeName, value: sakura)
//            
//            
//            let boxImage = inbox.imageWithSize(CGSizeMake(25, 25))
//            
//            saveBtn.setImage(boxImage, forState: .Normal)

            checkBtn.image = UIImage(named:"check")?.imageWithRenderingMode(.AlwaysTemplate)
            
            let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
            checkBtn.tintColor = sakura

            
            
            
            
            
        }
    }
    
    func onClickCloseButton(sender: UIButton) {
        
        mailTextView.resignFirstResponder()
        
        mailTextView.frame = CGRectMake(0, 20, mailTextView.bounds.width, myBoundsize.height-85)
        

        
       // mailTextView.frame = CGRectMake(0, 20, 320, 700)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var mailContent = myDefault.stringForKey("selectedText")
        
        if( mailContent != nil){
            //print(diary)
            
            mailTextView.text = mailContent
        }
        
        var editedText = myDefault.stringForKey("editedText")
        
        if( editedText != nil){
            
            mailTextView.text = editedText
        }

        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeShown:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
        
        //UITextViewの先頭にカーソルを合わせる 効かなかった？
        mailTextView.selectedRange = NSMakeRange(0,0)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillShowNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }
    
    func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
                restoreScrollViewSize()
                
                let convertedKeyboardFrame = scrollView.convertRect(keyboardFrame, fromView: nil)
                var offsetY: CGFloat = CGRectGetMaxY(mailTextView.frame) - CGRectGetMinY(convertedKeyboardFrame)
                
                mailTextView.frame = CGRectMake(8,8, mailTextView.bounds.width, myBoundsize.height - convertedKeyboardFrame.height-65)
                
                if offsetY < 0 { return }
                //Mark:計算結果を使わずにここで決め打ちしてしまう方が安定
                offsetY = 10.0
                

                updateScrollViewSize(offsetY, duration: animationDuration)
                
                print(scrollView.frame)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        restoreScrollViewSize()
        print(scrollView.frame)
    }
    
    // MARK: - UITextFieldDelegate//ここがリターンじゃなくボタンの設定も？//ここが効かない,テキストフィールドなので　doneボタンを付ける
    //    func textFieldShouldReturn(textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //    }
    
    
    func updateScrollViewSize(moveSize: CGFloat, duration: NSTimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, moveSize, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.contentOffset = CGPointMake(0, moveSize)
        
        UIView.commitAnimations()
    }
    
    func restoreScrollViewSize() {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    
    @IBAction func saveBtn(sender: UIButton) {
        
        var mailText = mailTextView.text
        
        //if ((diaryText != nil) && (diaryText != "")){
        //ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
        //データを書き込んで
        myDefault.setObject(mailText, forKey: "editedText")
        
        //即反映させる
        myDefault.synchronize()
        
        mailTextView.resignFirstResponder()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        //}
        
    }
    
    
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        mailTextView.resignFirstResponder()
        
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