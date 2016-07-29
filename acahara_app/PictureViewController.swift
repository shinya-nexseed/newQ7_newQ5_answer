//
//  PictureViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/03.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    // 詳細ページの中で何番目の画像が選ばれたか保存するプロパティ
    var picSelectedIndex = -1
    var numOfSelectedPicture = -1
    
    // MARK:一戸追加
    // 記事一覧で何番目の記事が選ばれているか保存するプロパティ
    var postSelectedIndex = -1

    
    private var watchImageMode = true
    private var beforePoint = CGPointMake(0.0, 0.0)
    private var currentScale:CGFloat = 1.0


    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(picSelectedIndex)
        
        self.pictureImageView.contentMode = .ScaleAspectFit
        
        self.beforePoint = CGPointMake(0.0, 0.0)
        self.pictureImageView.transform = CGAffineTransformIdentity
        self.pictureImageView.userInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handleGesture:")
        self.pictureImageView.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleGesture:")
        self.pictureImageView.addGestureRecognizer(tapGesture)
    
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        
//        let dic = jsonArray[picSelectedIndex]
        let dic = jsonArray[postSelectedIndex] as! NSDictionary
        
//        var selectedPicture = "picture" + String(numOfSelectedPicture) 
//
//        pictureImageView.image = UIImage(named: dic["selectedPicture"] as! String)
        
        //選択したpostのassetsURLの配列を取得
        let picArray = dic["picture"] as! NSArray
        
        //assetsURLの取り出し
        var strUrl = picArray[picSelectedIndex] as! String
        var url = NSURL(string: strUrl)
        
        //imageへ変換　ここで500 500を指定
        let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
        
        if fetchResult.firstObject != nil{
            
            let asset: PHAsset = fetchResult.firstObject as! PHAsset
            
            
            print("pixelWidth:\(asset.pixelWidth)");
            print("pixelHeight:\(asset.pixelHeight)");
            
            let manager: PHImageManager = PHImageManager()
            manager.requestImageForAsset(asset,targetSize: CGSizeMake(500, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                
                self.pictureImageView.image = image
                
            }
        }
        
        
        //MARK:一戸変更終了

    }
    
    func handleGesture(gesture: UIGestureRecognizer){
        if let tapGesture = gesture as? UITapGestureRecognizer{
            tap(tapGesture)
        }else{ let pinchGesture = gesture as? UIPinchGestureRecognizer
            pinch(pinchGesture!)
        }
    }

    private func tap(gesture:UITapGestureRecognizer){
        if self.watchImageMode{
//            self.watchImageMode = false
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.backgroundColor = UIColor.blackColor()
                self.beforePoint = CGPointMake(0.0, 0.0)
                self.pictureImageView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    private func pinch(gesture:UIPinchGestureRecognizer){
        
        if self.watchImageMode{
            
            var scale = gesture.scale
            if self.currentScale > 1.0{
                scale = self.currentScale + (scale - 1.0)
            }
            switch gesture.state{
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(scale, scale)
                let transitionTransform = CGAffineTransformMakeTranslation(self.beforePoint.x, self.beforePoint.y)
                self.pictureImageView.transform = CGAffineTransformConcat(scaleTransform, transitionTransform)
            case .Ended , .Cancelled:
                if scale <= 1.0{
                    self.currentScale = 1.0
                    self.pictureImageView.transform = CGAffineTransformIdentity
                }else{
                    self.currentScale = scale
                }
            default:
                NSLog("not action")
            }
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
