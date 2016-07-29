//
//  assistChosePostsTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/08.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class assistChosePostsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleBar: UIView!
    
    @IBOutlet weak var allSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let eye = FAKFontAwesome.eyeIconWithSize(15)
//        let eyeImage = eye.imageWithSize(CGSizeMake(15, 15))
//        assistEye.image = eyeImage
        
//        let palePink:UIColor = UIColor(red: 0.990, green: 0.93, blue: 0.88, alpha:0.8)
//        titleBar.backgroundColor = palePink
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
