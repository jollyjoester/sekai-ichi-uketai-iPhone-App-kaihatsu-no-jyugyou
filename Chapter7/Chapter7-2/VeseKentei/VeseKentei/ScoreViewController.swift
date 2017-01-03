//
//  ScoreViewController.swift
//  VeseKentei
//
//  Created by SaChico on 2015/12/13.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    //KenteiViewControllerの正解数を受け取るメンバ変数
    var correct = 0
    //正解数を表示するラベル
    @IBOutlet var scoreLabel: UILabel!
    //合格or不合格画像を表示する画像
    @IBOutlet var judgeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //正解数を表示
        scoreLabel.text = "正解数は\(correct)問です。"
        //合格・不合格を判定
        if correct >= 7{
            judgeImageView.image = UIImage(named: "Goukaku.png")
        }else{
            judgeImageView.image = UIImage(named: "Fugoukaku.png")
        }
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
