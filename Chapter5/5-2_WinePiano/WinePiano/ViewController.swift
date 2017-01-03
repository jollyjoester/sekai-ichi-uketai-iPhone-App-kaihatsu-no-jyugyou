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
    var player: AVAudioPlayer!  //音声を制御するための変数
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
        switch sender.tag {
        case 1:
            print("ワイングラスボタン\(sender.tag)")
            let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("1.mp3")
            do {
                //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
                try wineGlass = AVAudioPlayer(contentsOfURL: path)
                wineGlass.prepareToPlay()         //音声を即時再生させる
                wineGlass.play()                  //音を再生する
            }
            catch {
                print("エラーです")
            }
            
        case 2:
            print("ワイングラスボタン\(sender.tag)")
            let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("2.mp3")
            do {
                //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
                try wineGlass = AVAudioPlayer(contentsOfURL: path)
                wineGlass.prepareToPlay()         //音声を即時再生させる
                wineGlass.play()                  //音を再生する
            }
            catch {
                print("エラーです")
            }
            
        case 3:
            print("ワイングラスボタン\(sender.tag)")
            let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("3.mp3")
            do {
                //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
                try wineGlass = AVAudioPlayer(contentsOfURL: path)
                wineGlass.prepareToPlay()         //音声を即時再生させる
                wineGlass.play()                  //音を再生する
            }
            catch {
                print("エラーです")
            }
            
        case 4:
            print("ワイングラスボタン\(sender.tag)")
            let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("4.mp3")
            do {
                //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
                try wineGlass = AVAudioPlayer(contentsOfURL: path)
                wineGlass.prepareToPlay()         //音声を即時再生させる
                wineGlass.play()                  //音を再生する
            }
            catch {
                print("エラーです")
            }
            
        case 5:
            print("ワイングラスボタン\(sender.tag)")
            let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("5.mp3")
            do {
                //サウンドファイルの参照先をAVAudioPlayerの変数に割り当てる
                try wineGlass = AVAudioPlayer(contentsOfURL: path)
                wineGlass.prepareToPlay()         //音声を即時再生させる
                wineGlass.play()                  //音を再生する
            }
            catch {
                print("エラーです")
            }

        default:
            print("どのボタンでもありません")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

