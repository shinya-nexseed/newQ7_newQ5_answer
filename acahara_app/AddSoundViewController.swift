//
//  AddSoundViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/02.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import AVFoundation

class AddSoundViewController: UIViewController {
    
    let fileManager = NSFileManager()//写真、動画、音楽などのファイル読み書き処理
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"//swiftでよく見かける音声ファイルの拡張子が.caf

    // 時間表示用のラベル
    @IBOutlet weak var timeLabel: UILabel!
    
    // NSTimeInterval：時間を計算するメソッド
    var startTime = NSTimeInterval()
    
    // NSTimer：タイマーを管理するクラス
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioRecorder()
    }
    

    
    // RECボタンが押された時の設定
    @IBAction func StartAction(sender: UIButton) {
        
        //レコード開始
        audioRecorder?.record()
        
        
        //もし、〔スタートボタン：StartAction〕が押されたら〔関数：StartTime〕を呼び出す
        if (!timer.valid) {
            
            // NSTimer：タイマーを管理するクラス
            timer = NSTimer.scheduledTimerWithTimeInterval(
                0.01,                                   // 時間の間隔〔0.01〕
                target: self,                           // タイマーの実際の処理の場所
                selector: Selector("StartTime"),        // メソッド タイマーの実際の処理
                userInfo: nil,
                repeats: true)                          // 繰り返し
            
            // NSDate：日付と時間を管理するクラス
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    // RECストップボタンが押された時の設定
    
    @IBAction func tapRecStop(sender: UIButton) {
      
        // 無効化〔invalidate：無効化〕
        timer.invalidate()
        
        audioRecorder?.stop()
    }
    
    @IBAction func tapPlayStop(sender: UIButton) {
        audioPlayer?.stop()
        
    }
    
    
    @IBAction func tapPlay(sender: AnyObject) {
        play()
    }
    
    
    // Timeスタート
    func StartTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // 現在の時間を調べるためにスタートします
        var Time: NSTimeInterval = currentTime - startTime
        
        //(時）を計算
        let hours = UInt8(Time / 360.0)
        Time -= (NSTimeInterval(hours) * 360)
        
        
        //〔分〕を計算
        // UInt8：8 ビット符号なし整数への変換
        // NSTimeInterval：引数に時間の長さを示す値
        let minutes = UInt8(Time / 60.0)
        Time -= (NSTimeInterval(minutes) * 60)
        
        //〔秒〕を計算
        let seconds = UInt8(Time)
        Time -= NSTimeInterval(seconds)
        
        //〔ミリ秒〕を計算
        //        let fraction = UInt8(Time * 100)
        
        //(時）〔分〕〔秒〕を文字列にします
        let timeMinutes = hours > 9 ? String(hours):"0" + String(hours)
        let timeSeconds = minutes > 9 ? String(minutes):"0" + String(minutes)
        let timeFraction = seconds > 9 ? String(seconds):"0" + String(seconds)
        
        // 時間表示用のラベルに〔分〕〔秒〕〔ミリ秒〕を表示
        timeLabel.text = "\(timeMinutes):\(timeSeconds):\(timeFraction)"
    }
    
    
    //録音するために必要な設定を行う
    //viewDidLoad時に行う
    func setupAudioRecorder() {
        //再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        
        do {
            try audioRecorder = AVAudioRecorder(URL:
                self.documentFilePath(), settings: recordSetting)
        }catch{
            print("初期設定でerror出たよ（ー＿ー；）")
        }
        
    }

    func documentFilePath()-> NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        let dirURL = urls[0]
        
        return dirURL.URLByAppendingPathComponent(fileName)
    }

    //再生
    func play() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: self.documentFilePath())
        } catch{
            print("再生時にerror出たよ")
        }
        audioPlayer?.play()
    }

    
    @IBAction func tapCancel(sender: UIButton) {
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
