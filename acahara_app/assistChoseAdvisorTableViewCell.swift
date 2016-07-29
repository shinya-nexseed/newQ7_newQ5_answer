//
//  assistChoseAdviserTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/08.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class assistChoseAdvisorTableViewCell: UITableViewCell {
    
    
 

    @IBOutlet weak var sentTo: UILabel!

    @IBOutlet weak var titleBar: UIView!
    
    @IBOutlet weak var professor: UIButton!
    @IBOutlet weak var assailant: UIButton!
    @IBOutlet weak var committee: UIButton!
    @IBOutlet weak var psycotherapist: UIButton!
    @IBOutlet weak var lawyer: UIButton!
    @IBOutlet weak var friend: UIButton!

    @IBOutlet weak var assistMailContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let comments = FAKFontAwesome.commentsOIconWithSize(20)
//        let commentsImage = comments.imageWithSize(CGSizeMake(20, 20))
//        assistComments.image = commentsImage
//        
        // assistMailContentのTextViewに枠をつける。
        assistMailContent.layer.borderWidth = 0.5
        
//        // 枠の色を設定する。
        assistMailContent.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // 枠の角を丸くする。
        assistMailContent.layer.cornerRadius = 8
        
//        let palePink:UIColor = UIColor(red: 0.990, green: 0.93, blue: 0.88, alpha:0.8)
//        
//        titleBar.backgroundColor = palePink
//        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
