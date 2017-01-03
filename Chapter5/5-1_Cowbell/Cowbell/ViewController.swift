//
//  ViewController.swift
//  Cowbell
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit
// AVFoundationフレームワークをインポートする
import AVFoundation

class ViewController: UIViewController {
    
    //音声を制御するための変数player
    var player: AVAudioPlayer!

    @IBAction func play(sender: AnyObject) {
        //サウンドファイルを読み込む
        let url = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("cowbell.mp3")
        
        do {
            try player = AVAudioPlayer(contentsOfURL: url)
            player.play()
        }
        catch {
            print("エラーです")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

