//
//  datePickerTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class datePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var addDatePicker: UIDatePicker!
   
    @IBOutlet weak var cancelBtn: UIImageView!

    @IBOutlet weak var decideBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cancelBtn.image = UIImage(named:"")
      
    }
    
   
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
