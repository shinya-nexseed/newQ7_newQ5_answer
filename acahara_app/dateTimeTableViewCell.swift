//
//  dateTimeTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class dateTimeTableViewCell: UITableViewCell,UITextFieldDelegate {
    


    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var addWhen: UITextField!
    @IBOutlet weak var addSelfee: UIImageView!
    @IBOutlet weak var addImportance: UILabel!
    @IBOutlet weak var addSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSelfee.image = UIImage(named:"selfee.JPG")
        addName.text
            = "uminonar"//ここだと表示されないのん？なぜ？
        
        
        //色を使って指定する
        let palePink:UIColor = UIColor(red:1.0,green:0.66,blue:0.66,alpha:1.0)
        
        
        
        
        
        let asta = FAKFontAwesome.asteriskIconWithSize(10)
        asta.addAttribute(NSForegroundColorAttributeName, value: palePink)
        let astaImage = asta.imageWithSize(CGSizeMake(10,10))
        
    
        
        
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        
        return false
    }

    
   

}
