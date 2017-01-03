//
//  ViewController.swift
//  WinePiano
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit
import AVFoundation //AVFoundationフレームワークをインポートする

class ViewController: UIViewController {
    var player: AVAudioPlayer!  //BGMを制御するための変数
    var soundManager = SEManager()  //SEManagerでインスタンス化した変数
    //ワイングラスの音を制御するための変数
    var wineGlass: AVAudioPlayer!
    //BGM再生メソッド
    func play(soundName: String) {
        //String型の引数からサウンドファイルを読み込む
        let url = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(soundName)
        do {
            //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
            try player = AVAudioPlayer(contentsOfURL: url)
            player.numberOfLoops = -1      //BGMを無限にループさせる
            player.prepareToPlay()         //音声を即時再生させる
            player.play()                  //音を再生する
        }
        catch {
            print("エラーです")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //playメソッドの呼び出し。引数はファイル名
        play("BGM.mp3")
    }
    
    //ワイングラスボタンメソッド
    @IBAction func wineTapped(sender: UIButton) {
        //サウンドファイル名を格納するsound変数。初期値に空の文字を入れておく
        var sound:String = ""
        //変形を設定するCGAffinTransformの変数
        var transform: CGAffineTransform = CGAffineTransformIdentity
        //アニメーションの所要時間を持つ変数
        let duration: Double = 0.5
        switch sender.tag {
        case 1:
            print("ワイングラスボタン\(sender.tag)")
            sound = "1.mp3"
            //上に移動
            transform = CGAffineTransformMakeTranslation(0, -20)
        case 2:
            print("ワイングラスボタン\(sender.tag)")
            sound = "2.mp3"
            //拡大
            transform = CGAffineTransformMakeScale(1.05, 1.05)
        case 3:
            print("ワイングラスボタン\(sender.tag)")
            sound = "3.mp3"
            //回転
            transform = CGAffineTransformMakeRotation(CGFloat(0.25*M_PI))
        case 4:
            print("ワイングラスボタン\(sender.tag)")
            sound = "4.mp3"
            //縮小
            transform = CGAffineTransformMakeScale(0.95, 0.95)
        case 5:
            print("ワイングラスボタン\(sender.tag)")
            sound = "5.mp3"
            //反転
            transform = CGAffineTransformMakeScale(-1, 1)
        default:
            print("どのボタンでもありません")
        }
        //引数にsound変数を設定して、SEManagerクラスのsePlayメソッドを呼び出す
        soundManager.sePlay(sound)
        //アニメーション
        UIView.animateWithDuration(duration, animations: { () -> Void in
            sender.transform = transform
            })
            { (Bool) -> Void in
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    sender.transform = CGAffineTransformIdentity
                    })
                    { (Bool) -> Void in
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}