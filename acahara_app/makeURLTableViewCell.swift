//
//  makeURLTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/30.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class makeURLTableViewCell: UITableViewCell {

    
    @IBOutlet weak var urlMakeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        urlMakeBtn.layer.masksToBounds = true;
        urlMakeBtn.layer.cornerRadius = 5.0;
        
//        urlImage.image = UIImage(named:"addLink")?.imageWithRenderingMode(.AlwaysTemplate)
//        
//        urlImage.tintColor = UIColor.blueColor()
//        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
