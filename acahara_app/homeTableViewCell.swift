//
//  homeTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class homeTableViewCell: UITableViewCell {
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    //UIScrollViewを作成します 写真スクロール
    @IBOutlet weak var pictureScrView: UIScrollView!
    
    //UIScrollViewを作成します 動画スクロール
    @IBOutlet weak var movieScrView: UIScrollView!
    
    
    @IBOutlet weak var postPortrait: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postCreated: UILabel!
    @IBOutlet weak var postWhen: UILabel!
    @IBOutlet weak var postWhere: UILabel!
    @IBOutlet weak var postWho: UILabel!
    @IBOutlet weak var postUniversity: UILabel!

    @IBOutlet weak var labelCoverBtn: UIButton!
    @IBOutlet weak var postMoreBtn: UIButton!
    @IBOutlet weak var postEllipsis: UIImageView!
    @IBOutlet weak var postEllipsisBtn: UIButton!

    @IBOutlet weak var diaryLabel: UILabel!
    
    @IBOutlet weak var imageHeightLC: NSLayoutConstraint!
    

    @IBOutlet weak var movieHeightLC: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        
        
        postPortrait.image = UIImage(named:"selfee.JPG")
//
//        let volume = FAKFontAwesome.volumeUpIconWithSize(18)
//        let volumeImage = volume.imageWithSize(CGSizeMake(18, 18))
//        postVolume.image = volumeImage
        
        let ellipsis = FAKFontAwesome.ellipsisHIconWithSize(20)
        ellipsis.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor())
        let ellipsisImage = ellipsis.imageWithSize(CGSizeMake(20,20))
        postEllipsis.image = ellipsisImage
        
        
        
        //ここから下はスクロール画面を作っている
        
        //表示位置,100は初期値
        pictureScrView.frame = CGRectMake(59, 163, myBoundsize.width-75, 120)
   
        movieScrView.frame = CGRectMake(59, 298, myBoundsize.width-75, 120)
        
        
        //全体サイズ(幅）,各imageViewのサイズと位置はtableView側で設定
        
        self.contentView.addSubview(pictureScrView)
        self.contentView.addSubview(movieScrView)
        
        //scroll画面の初期位置
        pictureScrView.contentOffset = CGPointMake(0, 0);
        
        movieScrView.contentOffset = CGPointMake(0, 0);

        
       
    }


  


        

    
        
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
