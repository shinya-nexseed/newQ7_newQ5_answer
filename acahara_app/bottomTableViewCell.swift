//
//  bottomTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class bottomTableViewCell: UITableViewCell {


    @IBOutlet weak var addWhere: UITextField!
    @IBOutlet weak var addWho: UITextField!
    @IBOutlet weak var addDiary: UITextView!
    @IBOutlet weak var addUniversity: UITextField!

//    @IBOutlet weak var addPhoto: UIImageView!
//
//    @IBOutlet weak var addMovie: UIImageView!
//   
//    @IBOutlet weak var photoImageBase: UIView!
//
//    @IBOutlet weak var movieImageBase: UIView!
// 
//    @IBOutlet weak var picBase: UIImageView!
//    
//    @IBOutlet weak var plus: UIImageView!
//    
//    @IBOutlet weak var plus2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // addDiaryのTextViewに枠をつける。
        addDiary.layer.borderWidth = 0.5
        
        // 枠の色を設定する。
        //addDiary.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let silver:UIColor = UIColor(red:0.8,green:0.8,blue:0.8,alpha:1.0)

        addDiary.layer.borderColor = silver.CGColor
        
        // 枠の角を丸くする。
        addDiary.layer.cornerRadius = 8
        
        
//        addPhoto.image = UIImage(named:"photoImage")?.imageWithRenderingMode(.AlwaysTemplate)
//        addPhoto.tintColor = UIColor.lightGrayColor()
//        
//        addMovie.image = UIImage(named:"movieImage")?.imageWithRenderingMode(.AlwaysTemplate)
//        
//        addMovie.tintColor = UIColor.lightGrayColor()
//        
//        plus.image = UIImage(named:"plus")?.imageWithRenderingMode(.AlwaysTemplate)
//        plus.tintColor = UIColor.lightGrayColor()
//        
//        plus2.image = UIImage(named:"plus")?.imageWithRenderingMode(.AlwaysTemplate)
//        plus2.tintColor = UIColor.lightGrayColor()

        
//        
//        let layer1: CAShapeLayer = CAShapeLayer()
//        layer1.frame = photoImageBase.bounds
//        layer1.strokeColor = UIColor.lightGrayColor().CGColor
//        layer1.fillColor = nil
//        layer1.lineWidth = 2.0
//        layer1.lineDashPattern = [2, 3] // 線(=3)とスペース(=3)の長さを設定します。
//        layer1.path = UIBezierPath(rect: layer1.frame).CGPath
//        photoImageBase.layer.addSublayer(layer1)
//        
//        
//        let layer2: CAShapeLayer = CAShapeLayer()
//        layer2.frame = movieImageBase.bounds
//        layer2.strokeColor = UIColor.lightGrayColor().CGColor
//        layer2.fillColor = nil
//        layer2.lineWidth = 2.0
//        layer2.lineDashPattern = [2, 3] // 線(=3)とスペース(=3)の長さを設定します。
//        layer2.path = UIBezierPath(rect: layer2.frame).CGPath
//        movieImageBase.layer.addSublayer(layer2)
        
        
//        
//        let times = FAKFontAwesome.timesIconWithSize(20)
//        //下記でアイコンの色も変えられます
//        times.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
//        
//        let timesImage = times.imageWithSize(CGSizeMake(20, 20))
//        
//        picCancelBtn.setImage(timesImage, forState: .Normal)
        
        
        
    }




  

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
