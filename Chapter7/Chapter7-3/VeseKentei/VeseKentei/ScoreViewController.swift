//
//  ScoreViewController.swift
//  VeseKentei
//
//  Created by SaChico on 2015/12/13.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit
//Socialフレームワークをインポート
import Social

class ScoreViewController: UIViewController {
    //KenteiViewControllerの正解数を受け取るメンバ変数
    var correct = 0
    //正解数を表示するラベル
    @IBOutlet var scoreLabel: UILabel!
    //合格or不合格画像を表示する画像
    @IBOutlet var judgeImageView: UIImageView!
    
    @IBOutlet var goukakuTimesLabel: UILabel! //合格数を表示する変数
    @IBOutlet var rankLabel: UILabel!  //ランクを表示する変数
    var goukakuTimes = 0   //合格回数を格納する変数
    var rankString = "ビギナー"   //称号変数。初期値はビギナー

    override func viewDidLoad() {
        super.viewDidLoad()
        //合格回数を保存するNSUserDefaults
        let goukakuUd = NSUserDefaults.standardUserDefaults()
        //合格回数をgoukakuというキー値で変数goukakuTimesに格納
        goukakuTimes = goukakuUd.integerForKey("goukaku")
        //正解数を表示
        scoreLabel.text = "正解数は\(correct)問です。"
        //合格・不合格を判定
        if correct >= 7{
            judgeImageView.image = UIImage(named: "Goukaku.png")
            goukakuTimes++            //合格回数をカウントアップ
            //goukakuキー値を使って合格回数(goukakuTimes)を保存
            goukakuUd.setInteger(goukakuTimes, forKey: "goukaku")
        }else{
            judgeImageView.image = UIImage(named: "Fugoukaku.png")
        }
        //合格回数を表示
        goukakuTimesLabel.text = "合格回数は\(goukakuTimes)回です。"
        //合格回数によってランクを決定
        if goukakuTimes >= 50{
            rankString = "達人"
        }else if goukakuTimes >= 40{
            rankString = "師匠"
        }else if goukakuTimes >= 30{
            rankString = "師範代"
        }else if goukakuTimes >= 20{
            rankString = "上級者"
        }else if goukakuTimes >= 10{
            rankString = "ファン"
        }else if goukakuTimes >= 0{
            rankString = "ビギナー"
        }
        //ランクラベルに称号を設定
        rankLabel.text = "ランクは\(rankString)！"
    }
    //Facebook投稿メソッド
    @IBAction func postFacebook(sender: AnyObject) {
        //Facebook投稿用インスタンスを作成
        let fbVC:SLComposeViewController = SLComposeViewController  (forServiceType: SLServiceTypeFacebook)!
        //投稿テキストを設定
        fbVC.setInitialText("三浦のおやさい検定：私は\(rankString)。合格回数は\(goukakuTimes)回です。")
        //投稿画像を設定
        fbVC.addImage(UIImage(named: "icon.png"))
        //投稿用URLを設定
        fbVC.addURL(NSURL(string: "http://onthehammock.com/app/5783"))
        //投稿コントローラーを起動
        self.presentViewController(fbVC, animated: true,   completion: nil)
    }
    //Twitter投稿メソッド
    @IBAction func postTwitter(sender: AnyObject) {
        //Twitter投稿用インスタンスを作成
        let twVC:SLComposeViewController = SLComposeViewController  (forServiceType: SLServiceTypeTwitter)!
        //投稿テキストを設定
        twVC.setInitialText("三浦のおやさい検定：私は\(rankString)。合格回数は\(goukakuTimes)回です。")
        //投稿画像を設定
        twVC.addImage(UIImage(named: "icon.png"))
        //投稿用URLを設定
        twVC.addURL(NSURL(string: "http://onthehammock.com/app/5783"))
        //投稿コントローラーを起動
        self.presentViewController(twVC, animated: true,   completion: nil)
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
