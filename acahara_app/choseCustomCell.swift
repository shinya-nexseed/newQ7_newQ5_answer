//
//  homeTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class choseCustomCell: UITableViewCell {
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size

    
    
    
    
    
    
    @IBOutlet weak var circle: UIImageView!
    
    @IBOutlet weak var postPortrait: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postCreated: UILabel!
    @IBOutlet weak var postWhen: UILabel!
    @IBOutlet weak var postWhere: UILabel!
    @IBOutlet weak var postWho: UILabel!
    @IBOutlet weak var postUniversity: UILabel!
    @IBOutlet weak var postDiary: UITextView!

    @IBOutlet weak var scrView: UIScrollView!

    @IBOutlet weak var postMoreBtn: UIButton!

    @IBOutlet weak var postTextViewBtn: UIButton!

    @IBOutlet weak var coverBtn: UIButton!

    

    //UIScrollViewを作成します
//    let scrView = UIScrollView()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       //postsCustomCell.xibのスクロールビュー横幅にこのスクロールビューの幅を揃える
   

        //表示位置,100は初期値
        scrView.frame = CGRectMake(89, 213,myBoundsize.width-75 , 120)
        
        //scroll画面の初期位置
        scrView.contentOffset = CGPointMake(0, 0);
    
        
        circle.image = UIImage(named:"circle")
        
        
        postPortrait.image = UIImage(named:"selfee.JPG")
//
//        let volume = FAKFontAwesome.volumeUpIconWithSize(18)
//        let volumeImage = volume.imageWithSize(CGSizeMake(18, 18))
//        postVolume.image = volumeImage

        

                               
    }


  


        

    
        
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
