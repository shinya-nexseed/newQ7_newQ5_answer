//
//  DetailViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/30.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var dtSelectedIndex = -1
    var countNum = 0
    var movCountNum = 0

    var posts:NSMutableArray = []
    
    @IBOutlet weak var diaryLabel: UILabel!
    
    @IBOutlet weak var detailSelfee: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailWhen: UILabel!
    @IBOutlet weak var detailWhere: UILabel!
    @IBOutlet weak var detailWho: UILabel!
    @IBOutlet weak var detailUniversity: UILabel!
    @IBOutlet weak var detailCreated: UILabel!

    @IBOutlet weak var pictureScrView: UIScrollView!

    @IBOutlet weak var movieScrView: UIScrollView!

    //MARK:一戸追加
    //最下部の制約
    @IBOutlet weak var bottomLC: NSLayoutConstraint!
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    //MARK:一戸追加
    // true :デバッグモード
    // false :本番モード
    var debugFlag:Bool = true
    
    @IBOutlet weak var contentView: UIView!
    
    //調整用
    var imageScrollHeight:CGFloat = 120
    var movieScrollHeight:CGFloat = 120

    @IBOutlet weak var imageScrollLC: NSLayoutConstraint!
    
    @IBOutlet weak var movieScrollLC: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewHightLC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //diaryLabelの高さを動的可変にするためLinesをゼロにしてこちらにこれを書き込む
        diaryLabel.sizeToFit()
        
        detailSelfee.image = UIImage(named: "selfee.JPG")

        
        
       
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        //MARK:一戸追加
        var dic: NSDictionary = [String: String]() as! NSDictionary
        var selectedPictures = [] as! NSMutableArray
        if debugFlag {
           //デバッグモード
            let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
            let jsondata = NSData(contentsOfFile: path!)
            
            let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
            
            dic = jsonArray[dtSelectedIndex] as! NSDictionary
            
            detailSelfee.image=UIImage(named: "selfee.JPG")
            detailName.text = "uminonar"
            detailWhen.text = dic["when"] as! String
            detailWhere.text = dic["where"] as! String
            detailWho.text = dic["who"] as! String
            detailUniversity.text = dic["university"] as! String
            diaryLabel.text = dic["diary"] as! String
            
            
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 5
//            let attributes = [NSParagraphStyleAttributeName : style]
//            diaryLabel.attributedText = NSAttributedString(string: diaryLabel.text!,
//                                                           attributes: attributes)
//            diaryLabel.font = UIFont.systemFontOfSize(15)
            
            
            //        detailImageView.image = UIImage(named: dic["picture1"] as! String)
            // 写真データ全件取得
            var picArray = dic["picture"] as! NSMutableArray
            print("picArrayのカウント = \(picArray.count)")
            
            //空でない写真を配列selectedPicturesにセット
            for selectedPic in picArray{
                
                if selectedPic as! String != ""{
                    selectedPictures.addObject(selectedPic)
                }
                
            }
        }else{
            //本番モード
            //ここをAPIに変更 これであってる？
            
            var url = NSURL(string: "http://acahara.angry.jp/get.post_json.php")
            var request = NSURLRequest(URL:url!)
            var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil))
            let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata, options: [])) as! NSArray
            print("jsonArray.count = \(jsonArray.count)")
            
            dic =  NSDictionary(dictionary: jsonArray[dtSelectedIndex] as! NSDictionary)
            
            detailSelfee.image=UIImage(named: "selfee.JPG")
            detailName.text = dic["name"] as! String
            detailWhen.text = dic["time"] as! String
            detailWhere.text = dic["place"] as! String
            detailWho.text = dic["person"] as! String
            detailUniversity.text = dic["university"] as! String
            diaryLabel.text = dic["description"] as! String
            
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 5
//            let attributes = [NSParagraphStyleAttributeName : style]
//            diaryLabel.attributedText = NSAttributedString(string: diaryLabel.text!,
//                                                           attributes: attributes)
//            diaryLabel.font = UIFont.systemFontOfSize(15)
            
            
            //        detailImageView.image = UIImage(named: dic["picture1"] as! String)
            // 写真データ全件取得
            var picArray = dic["picture"] as! NSMutableArray
            print("picArrayのカウント = \(picArray.count)")
            
            
            
            //空でない写真を配列selectedPicturesにセット
            for selectedPic in picArray{
                
                if selectedPic as! String != ""{
                    selectedPictures.addObject(selectedPic)
                }
                
            }
        }
        
   
        
        
        
        
        //スクロールビューから追加したビューを一旦削除
        
        removeAllSubviews(pictureScrView)
        
        
        //選択されている写真の数
        var picNum = selectedPictures.count
        
        if picNum > 0{
            print("============ 写真が存在するとき ============")
            
            //MARK:一戸追加
            imageScrollHeight = 120
            imageScrollLC.constant = imageScrollHeight
            
            print(picNum)
            //スクロールが走る表示全体サイズを指定。写真の120幅に、10の余白で130
            let scrViewWidth:CGFloat = CGFloat(130 * picNum )
            
            pictureScrView.contentSize = CGSizeMake(scrViewWidth, 120)
            
            
            self.countNum = 0
            print("pic self.countNum 1 = \(self.countNum)")

            for strURL in selectedPictures{
                print("pic for count")
                print("画像のassetURL:\(strURL)")
                
                var url = NSURL(string: strURL as! String)
                
                let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url!], options: nil)
                
                if fetchResult.firstObject != nil{
                    
                    let asset: PHAsset = fetchResult.firstObject as! PHAsset
                    
                    
                    print("pixelWidth:\(asset.pixelWidth)");
                    print("pixelHeight:\(asset.pixelHeight)");
                    
                    let manager: PHImageManager = PHImageManager()
                    print("manager =================== before")
                    manager.requestImageForAsset(asset,targetSize: CGSizeMake(5, 500),contentMode: .AspectFit,options: nil) { (image, info) -> Void in
                        
                        //imageViewのaspectFitをつける必要がある？このままで良いかも
                        var imageView = UIImageView()
                        
                        //各写真イメージのX座標開始位置をpositionXとする。120幅に、10の余白で130
                        print("pic self.countNum 2 = \(self.countNum)")

                        var positionX:CGFloat = CGFloat(130 * self.countNum)
                        
                        //写真の位置サイズ指定
                        imageView.frame = CGRectMake(positionX, 0, 120, 120)
                        imageView.image = image
                        
                        //MARK:一戸追加
                        let gesture = UITapGestureRecognizer(target:self, action:"didClickImageView:")
                        
                        imageView.addGestureRecognizer(gesture)
                        
                        imageView.userInteractionEnabled = true
                        imageView.tag = self.countNum
                        //MARK:一戸追加終了

                        
                        self.pictureScrView.addSubview(imageView)
                        
                        
                        self.countNum++
                        print("pic self.countNum 3 = \(self.countNum)")

    
                    }
                    print("manager =================== after")
                }
                
            }
            
            
            
            //                return cell // problem1
            
            
        }else{
            print("============ 写真が存在しないとき ============")
            //MARK:一戸追加
            imageScrollHeight = 0
            imageScrollLC.constant = imageScrollHeight
            
            //選択写真が存在しない場合、画像表示箇所が縮まるように
            removeAllSubviews(pictureScrView)
            pictureScrView.frame.size.height = 0
            pictureScrView.frame.size.width = 0
            print(pictureScrView.frame.size.height)
            
            //            return cell
            
        }
        
        
        
        //選択された動画サムネイルを表示するための処理
        
        var movArray = dic["movie"] as! NSMutableArray
        print("movArrayのカウント = \(movArray.count)")

        var selectedMovies = [] as! NSMutableArray
        
        
        //空でない動画を配列selectedPicturesにセット
        for selectedMov in movArray{
            
            if selectedMov as! String != ""{
                selectedMovies.addObject(selectedMov)
            }
            
        }
        
        //スクロールビューから追加したビューを一旦削除
        removeAllSubviews(movieScrView)

        
        
        //選択されている動画の数
        var movNum = selectedMovies.count
        
        if movNum > 0{
            //MARK:一戸追加
            movieScrollHeight = 120
            movieScrollLC.constant = movieScrollHeight
            
            print("============ 動画が存在するとき ============")
            print(movNum)
            //スクロールが走る表示全体サイズを指定。写真の120幅に、10の余白で130
            let scrViewWidth:CGFloat = CGFloat(130 * picNum )
            
            movieScrView.contentSize = CGSizeMake(scrViewWidth, 120)
            
            
            self.movCountNum = 0
            print("self.movCountNum 1 = \(self.movCountNum)")
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
                        print("self.movCountNum 2 = \(self.movCountNum)")
                        var positionX:CGFloat = CGFloat(130 * self.movCountNum)
                        print("positionX 1\(positionX)")
//                        positionX = 0
//                        print("positionX 2\(positionX)")
                        
                        //写真の位置サイズ指定
                        imageView.frame = CGRectMake(positionX, 0, 120, 120)
                        imageView.image = image
                        imageView.backgroundColor = UIColor.blueColor()
                        print(imageView.frame.origin.x)
                        print(imageView.frame.origin.y)
                        
                        self.movieScrView.addSubview(imageView)

                        self.movCountNum++
                        print("self.movCountNum 3 = \(self.movCountNum)")
                        
                        
                        //                              cell.picCancelBtn.hidden = false
                    }
                }
                
            }
            
            //            return cell // problem2
            
            
        }else{
            print("============ 動画が存在しないとき ============")
            //MARK:一戸追加
            movieScrollHeight = 0
            movieScrollLC.constant = movieScrollHeight
            //選択写真が存在しない場合、画像表示箇所が縮まるように
            movieScrView.frame.size.height = 0
            movieScrView.frame.size.width = 0
            print(movieScrView.frame.size.height)
            
            //            return cell
        }   // if movNum > 0　の終わり

        
        
        //        //MARK:一戸追加
        //        //可変コンテンツの高さを計算
        diaryLabel.sizeToFit()
        print("ラベルの高さ1=\(diaryLabel.frame.size.height)")
        print("ラベルの高さ2=\(diaryLabel.bounds.height)")
        // 上部情報部分高さ
        var upperInfoHeight:CGFloat = 92
        
        let size:CGSize = diaryLabel.sizeThatFits(diaryLabel.frame.size)
        var labelHeight = size.height
        
        //nav高さ
        var navHeight:CGFloat = 64
        
        //tabbar 高さ
        var tabHeight:CGFloat = 44
        
        //コンテンツ余白
        var allMargin:CGFloat = 34
        
        var settingContentsSize = upperInfoHeight + labelHeight + imageScrollHeight + movieScrollHeight + allMargin
        
        
        
//        contentViewHightLC.constant = settingContentsSize
//        contentViewHightLC.constant = 100
//        
//        var totalHeight = settingContentsSize + navHeight + tabHeight
//        
//        labelHeightLC.constant = labelHeight
//        
//        if totalHeight > myBoundsize.height{
//            bottomLC.constant = 10
//        }else{
//            print(myBoundsize.height - totalHeight)
//            
//            var allMargin:CGFloat = 34
//            bottomLC.constant = myBoundsize.height - totalHeight - allMargin
//        }

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //表示位置,100は初期値 オートレイアウトがかかるlabelから高さを測っている。
        
        print("diaryLabel.height = \(diaryLabel.frame.size.height)")
        
        // 上部情報部分高さ
        var upperInfoHeight:CGFloat = 95
        
       
        var labelHeight = diaryLabel.frame.size.height
        
        // nav高さ
        var navHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        
        //tabbar 高さ
        var tabHeight:CGFloat = tabBarController!.tabBar.frame.size.height
        
        // statusbar 高さ
        var statusHeight:CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        //余白
        var totalMargin:CGFloat = 8+16+18
        
        //最低限の下余白
        var miniMargin:CGFloat = 10
        
        var settingContentsSize = upperInfoHeight + labelHeight + imageScrollHeight + movieScrollHeight + statusHeight + navHeight + tabHeight + totalMargin + miniMargin
        
        
        if settingContentsSize > myBoundsize.height{
            bottomLC.constant = miniMargin
        }else{
            bottomLC.constant = myBoundsize.height - settingContentsSize
        }
        
        //MARK:一戸削除
//        pictureScrView.frame = CGRectMake(54,diaryLabel.frame.size.height + 20 , myBoundsize.width-75, 120)
//        //        scrView.backgroundColor = UIColor.grayColor()
//        movieScrView.frame = CGRectMake(54,diaryLabel.frame.size.height + 140,myBoundsize.width-75,120)
//        
//        //scroll画面の初期位置
//        pictureScrView.contentOffset = CGPointMake(0, 0);
//        
//        movieScrView.contentOffset = CGPointMake(0, 0);
//        
//        print("----------pictureScrViewの位置------------")
//        print(pictureScrView.frame.origin.x)
//        print(pictureScrView.frame.origin.y)
//        print("----------movieScrViewの位置------------")
//        print(movieScrView.frame.origin.x)
//        print(movieScrView.frame.origin.y)
//        
//        scrollView.contentSize.height = 1000
        
        
//        //MARK:一戸追加
//        //可変コンテンツの高さを計算
//        var totalHight = diaryLabel.frame.size.height + imageScrollHeight + movieScrollHeight
//        print(totalHight)
//        
//        
//        // 全体の高さからnavi + tab + ヘッダ部分を引いた分と比較し、bottomの制約を決定する
//        var contentsHight = myBoundsize.height - 64 - 44 - 92
//        
//        print(contentsHight)
//        
//        if totalHight > contentsHight{
////            bottomLC.constant = 10
//        }else{
//        
////            bottomLC.constant = contentsHight - totalHight - 44
//        }
        
    }
    
    
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
