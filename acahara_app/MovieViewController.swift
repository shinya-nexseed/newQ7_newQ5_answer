//
//  MovieViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/07/13.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos
import AVFoundation

class MovieViewController: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate {
    
    var movSelectedIndex = -1
    var numOfSelectedMovie = -1
    
    @IBOutlet weak var movieView: AVPlayerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //   UIViewのレイヤーをAVPlayerLayerにする。普通のviewをカスタマイズしてる
        
        let layer = movieView.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        
//        layer.player = videoPlayer//なぜここでエラー？
//        データをセットすべき箇所で、今、それがないから？
        
        

        
    }
    
    
    
    @IBAction func tapPlay(sender: UIButton) {
        //TODO:この再生ボタンを実装すべし！
        //この一行で再生する、ここにボタンを置いて、押したら、この一行が効くようにすれば良い。
        let layer = movieView.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        
//TODO:        layer.player = videoPlayer//なぜここでエラー？
//        データをセットすべき箇所で、今、それがないから？
        layer.player?.play()
        
        
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

// レイヤーをAVPlayerLayerにする為のラッパークラス.vieのクラスにこれを指定することでAVViewに形成する　クラス指定を忘れないで！
class AVPlayerView : UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
    
}
