//
//  ViewController.swift
//  ShingoHaNaniiro
//
//  Created by SaChico on 2015/12/01.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var signalImageView: UIImageView!

    var blueImage:UIImage!
    var redImage:UIImage!
    var yellowImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //UIImageのimageNamed:メソッドを使って画像を設定
        blueImage = UIImage(named: "signal_blue.png")
        redImage = UIImage(named: "signal_red.png")
        yellowImage = UIImage(named: "signal_yellow.png")

        //UIImageViewのimageプロパティを使ってredImageを設定
        signalImageView.image = redImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func blueBtnPushed(sender: AnyObject) {
//        resultLabel.text = "しんごうはあおいろ!"
        resultLabel.textColor = UIColor.blueColor()
        
        //青信号についての判定処理
        if signalImageView.image == blueImage {
            resultLabel.text = "せいかい！"
        } else {
            resultLabel.text = "まちがい！"
        }
        randomSignal()
    }
    
    @IBAction func yellowBtnPushed(sender: AnyObject) {
        resultLabel.textColor = UIColor.yellowColor()
        
        //黄信号についての判定処理をコーディング
        if signalImageView.image == yellowImage {
        resultLabel.text = "せいかい！"
        } else {
        resultLabel.text = "まちがい！"
        }
        //randomSignalメソッドを実行
        randomSignal()
    }
    @IBAction func redBtnPushed(sender: AnyObject) {
        resultLabel.textColor = UIColor.redColor()
        
        //赤信号についての判定処理をコーディング
        if signalImageView.image == redImage {
            resultLabel.text = "せいかい！"
        } else {
            resultLabel.text = "まちがい！"
        }
        //randomSignalメソッドを実行
        randomSignal()
    }
    
    func randomSignal(){
        //ランダムな数値を作る
        let randomNumber = arc4random() % 3
        
        // 0なら青信号、1なら赤信号、それ以外なら黄信号をセットする
        if randomNumber == 0{
            signalImageView.image = blueImage
        }else if randomNumber == 1{
            signalImageView.image = redImage
        }else{
            signalImageView.image = yellowImage
        }
    }
}

