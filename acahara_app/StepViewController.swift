//
//  StepViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/13.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class StepViewController: UIViewController {

    @IBOutlet weak var menu: UIImageView!
    @IBOutlet weak var menuCoverBtn: UIButton!
   


    @IBOutlet var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var kiroku: UIImageView!
    @IBOutlet weak var soudan: UIImageView!
    @IBOutlet weak var sonae: UIImageView!
 
    @IBOutlet weak var sprout: UIImageView!
    
    @IBOutlet weak var kirokuPic: UIImageView!
    @IBOutlet weak var soudanPic: UIImageView!
    @IBOutlet weak var sonaePic: UIImageView!
   
    @IBOutlet weak var kirokuBaseView: UIView!
    @IBOutlet weak var soudanBaseView: UIView!
    @IBOutlet weak var sonaeBaseView: UIView!

    @IBOutlet weak var kirokuTextView: UITextView!
    @IBOutlet weak var soudanTextView: UITextView!
    @IBOutlet weak var sonaeTextView: UITextView!




    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let toggle = FAKFontAwesome.barsIconWithSize(25)
//        toggle.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor())
//        let toggleImage = toggle.imageWithSize(CGSizeMake(25, 25))
//        
//        toggleBtn.setImage(toggleImage, forState: .Normal)
//        
//        self.toggleBtn.addTarget(SSASideMenu(), action: Selector("presentLeftMenuViewController"), forControlEvents: UIControlEvents.TouchUpInside)
//
    
    self.menuCoverBtn.addTarget(SSASideMenu(), action: Selector("presentLeftMenuViewController"), forControlEvents: UIControlEvents.TouchUpInside)
        
    

//        menuTap.addTarget(SSASideMenu(), action: Selector("presentLeftMenuViewController:"))
        
        
        menu.image = UIImage(named:"menu")?.imageWithRenderingMode(.AlwaysTemplate)
        
        menu.tintColor = UIColor.whiteColor()
        
        65
        scrollView.contentSize.height = 3300
        
        kiroku.image = UIImage(named:"create")
        
        soudan.image = UIImage(named:"contact")
        
        sonae.image = UIImage(named:"step")
        
        kirokuPic.image = UIImage(named:"woman")
        
        soudanPic.image = UIImage(named:"advisor")
        
        sonaePic.image = UIImage(named:"future")
        
        sprout.image = UIImage(named: "plantHand")
 
        let paleBlue:UIColor = UIColor(red:0.914,green:0.941,blue:0.980,alpha:1.0)
        kirokuBaseView.backgroundColor = paleBlue
        
        let paleGreen:UIColor = UIColor(red: 0.914, green: 0.980, blue: 0.950, alpha: 1.0)
        soudanBaseView.backgroundColor = paleGreen
        
        let palePink:UIColor = UIColor(red: 0.990, green: 0.93, blue: 0.88, alpha:0.8)
        sonaeBaseView.backgroundColor = palePink
        


        
        
        kirokuTextView.text = "神経がピリピリして記録をとるのが難しいですか？人間関係を壊したくないし、そのうち止むかもしれないから、記録せずに忘れたいですか？\n\n私はかつてそうでした。だから最初からハラスメントの記録など全く取っていませんでした。「口で相談したら済む」「いつか止む」と信じていました。でも一向に止まず、病気になってしまった時、一部しか証拠保全していなかった事を、心の底から悔いました。\n\nこのアプリを使うとハラスメントの記録をずっと楽につけられます。後々、使う必要がなければ、使わなければ良いのです。とにかく気になったらすぐ、気楽に記録し始めましょう！"
        
        soudanTextView.text = "恥ずかしかったり、自分に原因があると思われたくなくて、１人で辛さを溜め込んでいませんか？記録をつけて、客観的にみて酷いなと思ったら、誰かに相談しましょう。とは言っても、自分の被害状況を繰り返し説明するのは苦痛です。このアプリを通じて相談すれば、そうした繰り返しによる追体験を避けられます。相談の事実や相手方の対応なども記録として残すことができます。\n\n私の経験では、被害が拡大して裁判を検討し始めた時、防止委員会は相談内容の開示を「個人情報保護」を理由に拒みました。裁判のために相談内容の要約書面を書いて下さるカウンセラーは多くなく、アカハラ被害の弁護を引き受けて下さる弁護士の先生は極めて少ないのが現状です。改善されるまで、少しでも辛さを柔らげられたらと、このアプリでは「相談サポート」サービスを作りました。"
        
        sonaeTextView.text = "ハラスメントの記録をとり各方面に相談しても、事態が改善されない可能性もあります。大学には、ハラスメントを続ける教授に対してすぐに対応改善を求め、学生を第一に守る体制を取って欲しいですが、現状はそうならない場合があります。止まない悪質なハラスメントにあってしまったら、最悪のケースを想定しながら、未来に備えましょう。\n\nハラスメントに指導放棄が含まれる場合、直ぐに、出来れば他大学の教授に論文指導を頼めないか打診してみましょう。学会などに所属するのも良いかもしれません。進学などで推薦状が必要になった場合、推薦して下さる方、推薦適格のある状況を確保しましょう。論文指導を受けたり、共同プロジェクトへ参加するなどの方法があります。ジャーナルに論文を発表したり、コンペに参加するなど、第三者から評価され得る事績を残すこともお勧めです。"
        
        //行間設定
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSParagraphStyleAttributeName : style]
        kirokuTextView.attributedText = NSAttributedString(string: kirokuTextView.text,attributes:attributes)
        soudanTextView.attributedText = NSAttributedString(string: soudanTextView.text,attributes:attributes)
        sonaeTextView.attributedText = NSAttributedString(string: sonaeTextView.text,attributes:attributes)

        //フォントサイズの指定
        kirokuTextView.font = UIFont.systemFontOfSize(15)
        soudanTextView.font = UIFont.systemFontOfSize(15)
        sonaeTextView.font = UIFont.systemFontOfSize(15)
        //テキスト背景色指定
        kirokuTextView.backgroundColor = paleBlue
        soudanTextView.backgroundColor = paleGreen
        sonaeTextView.backgroundColor = palePink
        
        //テキストカラー変更
        kirokuTextView.textColor = UIColor.darkGrayColor()
        soudanTextView.textColor = UIColor.darkGrayColor()
        sonaeTextView.textColor = UIColor.darkGrayColor()
        
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        var myDefault = NSUserDefaults.standardUserDefaults()
        var stepAdd = myDefault.stringForKey("stepAdd")
        
        if stepAdd != nil{
            //"stepAdd"を空にして
            var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
            
            myDefault.removeObjectForKey("stepAdd")
            
            //タブで記録のページAddTableVCへ切り替え
            //そちらで記録成功が普通に表示される
//            上記のタブ切り替えの方法だと、デリゲートメソッドがコールバックされない?
        
            self.tabBarController!.selectedIndex = 1;
        }
    }
    



    @IBAction func kirokuCoverBtn(sender: UIButton) {
        var height:CGFloat = 608.0
        scrollView.setContentOffset(CGPointMake(0, height), animated: true)

    }
    
    
    @IBAction func soudanCoverBtn(sender: UIButton) {
        
        var height:CGFloat = 1396.0
        scrollView.setContentOffset(CGPointMake(0, height), animated: true)
        
    }
    @IBAction func sonaeCoverBtn(sender: UIButton) {
        
        var height:CGFloat = 2343.0
        scrollView.setContentOffset(CGPointMake(0, height), animated: true)
        
    }

    @IBAction func acaBtn(sender: UIButton) {
        
        var height:CGFloat = 0.0
        scrollView.setContentOffset(CGPointMake(0, height), animated: true)
        
    }
    
    @IBAction func kirokuSBtn(sender: UIButton) {
        let AddTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddTableViewController") as UIViewController
        
        presentViewController(AddTableView, animated: true, completion: nil)

        
    }
    @IBAction func kirokuBtn(sender: UIButton) {
        let AddTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddTableViewController") as UIViewController
        
        presentViewController(AddTableView, animated: true, completion: nil)

        
    }

    @IBAction func soudanSBtn(sender: UIButton) {
        self.tabBarController!.selectedIndex = 2;
    }
    
    @IBAction func soudanBtn(sender: UIButton) {
        self.tabBarController!.selectedIndex = 2;
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
