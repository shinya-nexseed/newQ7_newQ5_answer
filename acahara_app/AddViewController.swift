//
//  AddViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/27.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var addTableSaveBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var picBase: UIImageView!
    @IBOutlet weak var tapPicFile: UIView!
    @IBOutlet weak var tapMovFile: UIView!
    @IBOutlet weak var tapSound: UIView!
    
    // saveボタンをNavigationControllerに設置するためのUIBarButtonItem準備
    var addBtn: UIBarButtonItem!
    
    //UIViewControllerの画面サイズを取得
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    
    @IBOutlet weak var addBar: UIView!
    @IBOutlet weak var addSelfee: UIImageView!
    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var addWhen: UITextField!
    @IBOutlet weak var addDatePIcker: UIDatePicker!
    @IBOutlet weak var addMoveView: UIView!
    @IBOutlet weak var addWhere: UITextField!
    @IBOutlet weak var addWho: UITextField!
    @IBOutlet weak var addUniversity: UITextField!
    @IBOutlet weak var addImportance: UILabel!
    @IBOutlet weak var addDiary: UITextView!
    @IBOutlet weak var addMicPlus: UIImageView!
    @IBOutlet weak var addMicPhone: UIImageView!
    @IBOutlet weak var addPicPlus: UIImageView!
    @IBOutlet weak var addPicFile: UIImageView!
    @IBOutlet weak var addMoviePlus: UIImageView!
    @IBOutlet weak var addMovieFile: UIImageView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        //saveボタンをナビゲーションバーの右上に設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "tapSave")
        self.navigationItem.rightBarButtonItem = addBtn


        //フォントオーサムを利用してアイコンを複数表示、色が変わらない！！！なぜ？
        let plus = FAKFontAwesome.plusIconWithSize(15)
        let plusImage = plus.imageWithSize(CGSizeMake(15, 15))
        addMicPlus.image = plusImage
        
        let mike = FAKFontAwesome.microphoneIconWithSize(25)
        let mikeImg = mike.imageWithSize(CGSizeMake(25, 25))
        addMicPhone.image = mikeImg
        
        let plus2 = FAKFontAwesome.plusIconWithSize(25)
        let plus2Img = plus2.imageWithSize(CGSizeMake(25, 25))
        addPicPlus.image = plus2Img
        
        let addImage = FAKFontAwesome.fileImageOIconWithSize(50)
        let addI = addImage.imageWithSize(CGSizeMake(50, 50))
        addPicFile.image = addI
        
        let plus3 = FAKFontAwesome.plusIconWithSize(25)
        let plus3Img = plus3.imageWithSize(CGSizeMake(25, 25))
        addMoviePlus.image = plus2Img
        
        let addMo = FAKFontAwesome.fileMovieOIconWithSize(50)
        let addM = addMo.imageWithSize(CGSizeMake(50, 50))
        addMovieFile.image = addM
        
        // addDiaryのTextViewに枠をつける。
        addDiary.layer.borderWidth = 0.5
        
        // 枠の色を設定する。
        addDiary.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // 枠の角を丸くする。
        addDiary.layer.cornerRadius = 8
        
        
//以下、いらないが、プログラムでtapGestureRecognizerを設定する記述を後学のため残す。
//tapGestureRecognizerをaddDiaryテキストフィールドに設定
//        let myTap = UITapGestureRecognizer(target: self, action: "tapGesture:")
//        addDiary.addGestureRecognizer(myTap)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        addName.text = "uminonar"
        addSelfee.image = UIImage(named: "selfee.JPG")
        
        //ユーザーデフォルトから保存されたデータを取り出す
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        //大学、データを呼び出して文字列が入っていたら、表示する
        var uniStr = myDefault.stringForKey("uniStr")
        
        if ( uniStr != nil){
            addUniversity.text = uniStr
        }
        
        //場所、データを呼び出して文字列が入っていたら表示する
        var selectedPlace = myDefault.stringForKey("selectedPlace")
        
        if( selectedPlace != nil){
            print(selectedPlace)
            addWhere.text = selectedPlace
        }
        
        
        //名前、データを呼び出して文字列が入っていたら表示する
        var selectedName = myDefault.stringForKey("selectedName")
        
        if( selectedName != nil){
            print(selectedName)
            addWho.text = selectedName
        }
        
        //Diaryデータを呼び出して文字列が入っていたら表示する
        var diaryText =
            myDefault.stringForKey("diary")
        if((diaryText != nil) && (diaryText != "")){
            print(diaryText)
            addDiary.text = diaryText
            addDiary.textColor = UIColor.blackColor()
        }else{
            addDiary.text = "大丈夫！しっかり記録していきましょう。。具体的にどんなことがありましたか？"
            addDiary.textColor = UIColor.lightGrayColor()
        }


            
//？？？？？？？？DatePickerの設定を指定する(これ、ここでいる？）？？？？？？？？？？？？
        addDatePIcker.datePickerMode=UIDatePickerMode.DateAndTime
        addDatePIcker.maximumDate=NSDate()
    }

    
    @IBAction func addSwitch(sender: UISwitch) {
        if sender.on == true { //== trueはなくても良い
            addImportance.text = "相談に利用予定"
            //投稿情報のopenを１にする
        }else{
            addImportance.text = "念のため記録"
            //投稿情報のopenを０にする→ホーム画面でBgcwを薄いグレーに変えて
    }
    }
    

    //テキストフィールドがタップされた時の処理を、テキストフィールドをタグ付けして場合わけ記述
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print(textField.tag)
        
        if textField.tag == 1000{
            
// ？？？？？？？？？？？？？？？ここが全く機能しない。なぜか？？？？？？？？？？？？？？？？
            UIView.animateWithDuration(0.4, animations: { () -> Void in self.addMoveView.frame = CGRectMake(0,380, self.myBoundSize.width, 442)
                }, completion: { finished in print("addMoveViewを動かした")
                    
            })
            return false
        }
        
        if textField.tag == 2000{
            let AddWhere = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhereViewController") as UIViewController
            
            presentViewController(AddWhere, animated: true, completion: nil)
            return false
        }
        
        if textField.tag == 3000{
            let AddWho = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddWhoViewController") as UIViewController
            
            presentViewController(AddWho, animated: true, completion: nil)
            
            return false
        }else{
      
             return true
        }

    }
    
    //addUniversityのテキストフィールドは、returnタップ時にユーザーデフォルトに収め、キーボーードも立ち上げたいので他のテキストフィールドとは処理を分けている
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.tag == 4000{
            //ユーザーデフォルトを用意する
            var myDefault = NSUserDefaults.standardUserDefaults()
            
            //データを書き込んで
            myDefault.setObject(textField.text, forKey: "uniStr")
            
            //即反映させる
            myDefault.synchronize()
            
            return true
        }
        
        return true
    
    }
    
//ここも先のプログラムで設定しtapGestureRecognizerと連動していて不要だが、後学のため残す。
//    internal func tapGesture(sender: UITapGestureRecognizer){
//        
//        let AddDiaryVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("AddDiaryViewController") as UIViewController
//        
//        // showで遷移するバージョン           navigationController?.pushViewController(AddDiaryVC, animated: true)
//        
//        
//  
//        //モーダルで遷移するバージョン
//        presentViewController(AddDiaryVC, animated: true, completion: nil)
//    }
    

  

    
    
    //AddDiaryの画面をタップしたら記入画面がモーダルで立ち上がる
    @IBAction func tapDiary(sender: UITapGestureRecognizer) {
        
//        UIView.animateWithDuration(0.4, animations: { () -> Void in self.addDiary.frame = CGRectMake(12,20, self.myBoundSize.width-24, self.myBoundSize.height)
//            }, completion: { finished in print("addMoveViewを動かした")
//                
//        })

        
        
        let AddDiaryVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("AddDiaryViewController") as UIViewController
        
        // showで遷移するバージョン           navigationController?.pushViewController(AddDiaryVC, animated: true)
        
//        モーダルで遷移するバージョン
        presentViewController(AddDiaryVC, animated: true, completion: nil)
    }
    
    
    //addWhenテキストフィールドをタップしたらDatePickerが表示され、選択期日がテキストフィールドの真下にある赤字ラベル（timeLabel)に連動表示される
    @IBAction func pickerDateChange(sender: UIDatePicker) {
        
        let df = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:MM"
        var dateStr = df.stringFromDate(sender.date)
        
        timeLabel.text = dateStr
        
//？？？？ここも効かない！DatePickerが期日を決定する時の記述を確認して？？？？？？
        
        UIView.animateWithDuration(0, animations: { () -> Void in self.addMoveView.frame = CGRectMake(0,380, self.myBoundSize.width, 442)
            }, completion: { finished in print("addMoveViewを動かした")
        })
    }

    //datePickerの赤字の日時がタップされたらaddWhenテキストフィールドに赤字の日時を代入しDatePickerがmoveViewが上がってくるアニメーションで見えなくなる
//?????????????????????????????ここが全く効かない？？？？？？？？？？？？？？？？
    @IBAction func tapDecideTime(sender: UITapGestureRecognizer) {
        
        addWhen.text = timeLabel.text
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in self.addMoveView.frame = CGRectMake(0,126, self.myBoundSize.width, 442)
            }, completion: { finished in print("addMoveViewを動かした")
        })
    }
    
    
    //pictureFileがタップされた時、カメラロールが現れ、選択された写真がaddImageViewに収められる
    @IBAction func tapPicFile(sender: UITapGestureRecognizer) {
        var photoPick = UIImagePickerController()
        photoPick.delegate = self
        photoPick.sourceType = .PhotoLibrary
        self.presentViewController(photoPick, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picBase.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
//？？？？？？？？？？movieFileがタップされた時、カメラロールが現れ、選択された動画をaddImageView？に入れたいが、設定できない？？？？？？？？？？？？？？？？？？？？？？？
    @IBAction func tapMovFile(sender: UITapGestureRecognizer) {
        var movPick = UIImagePickerController()
        movPick.delegate = self
        movPick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        movPick.mediaTypes = [kUTTypeMovie as String]
        movPick.allowsEditing = false
        movPick.delegate = self
        self.presentViewController(movPick, animated: true, completion: nil)
    }
    
    
//？？？？？？？？？ここに選択された動画のイメージ画をaddImageViewに収める処理が必要！エラーが出る
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
//        picBase.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
//これはいらなそう。
//    func imagePickerControllerDidCancel(picker: UIImagePickerController){
//    
//    }


    @IBAction func tapSound(sender: UITapGestureRecognizer) {
        
        let AddSound = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddSoundViewController") as UIViewController
        
        presentViewController(AddSound, animated: true, completion: nil)
        
    }
    
    //Saveボタンが押された時の処理
    @IBAction func saveBtn(sender: UIButton) {

        //必須項目が記入済みか、チェックする
        //未記入があったら、記入してくださいのアラート
        
        //全て記入済みだったら、
        //データをサーバーに渡す処理
        //UserDefaultのdiaryキーのところを空にする
        
        //テキストフィールドに記入するためにユーザーデフォルトに入れていた直前１件の履歴削除
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
        myDefault.removeObjectForKey("diary")
        myDefault.synchronize()
        
        myDefault.removeObjectForKey("selectedPlace")
        myDefault.synchronize()
        
        myDefault.removeObjectForKey("selectedName")
        myDefault.synchronize()
        
        addWhen.text=""
        addWhere.text=""
        addWho.text=""
        addDiary.text=""
        
        //前ページに遷移する　モーダル画面じゃなくので、dismissじゃないバージョン　後学のため残す
        //navigationController?.popViewControllerAnimated(true)

        //userDefaultにデータを書き込んで
        myDefault.setObject("true", forKey: "saveSuccess")
        
        //即反映させる
        myDefault.synchronize()
        
        self.dismissViewControllerAnimated(true, completion: nil)


        
    }
    
    //どうして効かない？多分、つけたい画面がすでにない？んー、。いずれにせよ、次の表示される画面に通常は出す。userDefaultかflagで判定して
//    override func viewWillDisappear(animated: Bool) {
////       
////        let alert: UIAlertController = UIAlertController(title: "記録成功！", message: "負けないで！", preferredStyle: .Alert)
//        self.presentViewController(alert, animated: true) { () -> Void in
//            let delay = 4.0 * Double(NSEC_PER_SEC)
//            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//            dispatch_after(time, dispatch_get_main_queue(), {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            })
//        }

//    }
    

    @IBAction func cancelBtn(sender: UIButton) {
        var myDefault = NSUserDefaults.standardUserDefaults()
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
        myDefault.removeObjectForKey("diary")
        myDefault.synchronize()
        
        myDefault.removeObjectForKey("selectedPlace")
        myDefault.synchronize()
        
        myDefault.removeObjectForKey("selectedName")
        myDefault.synchronize()
        
        addWhen.text=""
        addWhere.text=""
        addWho.text=""
        addDiary.text=""
        
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
