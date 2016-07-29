//
//  assistInfoDetailTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/08.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class assistInfoDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var infoSentence1: UITextView!

    @IBOutlet weak var infoSentence2: UITextView!
  
    @IBOutlet weak var infoSentence3: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoSentence1.text = "「...もう駄目だ。」と思ったらこのサービスを利用してください。アカハラ被害を記録した後で、誰かに相談する時、被害者が何度も繰り返し説明を強いられ追体験しないで済むように作られました。"
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        let attributes = [NSParagraphStyleAttributeName : style]
        infoSentence1.attributedText = NSAttributedString(string: infoSentence1.text,attributes: attributes)
        infoSentence1.font = UIFont.systemFontOfSize(13.5)
        
        
        
        let style2 = NSMutableParagraphStyle()
        style2.lineSpacing = 2
        let attributes2 = [NSParagraphStyleAttributeName : style2]
        infoSentence2.attributedText = NSAttributedString(string: infoSentence1.text,attributes: attributes2)
        infoSentence2.font = UIFont.systemFontOfSize(13.5)
        infoSentence2.text = "やり方は簡単です！まず、相談相手のタイプを選んでください。相談内容の雛形が現れるので、それを編集してください。次に、相談者に見せたい投稿記録を一覧から選び、一番下の「記録一欄サイトを作成する」をタップしてください。"
        
        
        let style3 = NSMutableParagraphStyle()
        style3.lineSpacing = 2
        let attributes3 = [NSParagraphStyleAttributeName : style3]
        infoSentence3.attributedText = NSAttributedString(string: infoSentence1.text,attributes: attributes3)
        infoSentence3.font = UIFont.systemFontOfSize(13.5)
        infoSentence3.text = "そうすると相談相手に見せたい「記録一覧」を含んだ「特別なサイト」が作られます。一般公開はされていません。あとはメール送信ボタンをタップすれば、記録一覧サイトのURLを含んだ相談内容が、あなたのメールアカウントから相手方に送信されます。"
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
