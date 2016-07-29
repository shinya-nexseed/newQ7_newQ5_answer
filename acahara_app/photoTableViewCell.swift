//
//  photoTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/29.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class photoTableViewCell: UITableViewCell {
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size

    //UIScrollViewを作成します
    let scrView = UIScrollView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        //表示位置,100は初期値       
        scrView.frame = CGRectMake(15, 20, myBoundsize.width-30, 150)
//        scrView.backgroundColor = UIColor.grayColor()
        
        
        
        //全体サイズ(幅）,各imageViewのサイズと位置はtableView側で設定

        self.contentView.addSubview(scrView)

        
        //scroll画面の初期位置
        scrView.contentOffset = CGPointMake(0, 0);
        
        
        //背景色を変更
        let sakuraPale:UIColor = UIColor(red:1.0,green:0.953,blue:0.910,alpha:1.0)
        
        self.backgroundColor = sakuraPale
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
