//
//  SEManager.swift
//  WinePiano
//
//  Created by SaChico on 2015/12/03.
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import Foundation
import AVFoundation     //AVFoundationフレームワークのインポート

class SEManager: NSObject {
    //音を制御するための変数
    var player:AVAudioPlayer!
    //音を再生するsePlayメソッド
    func sePlay(soundName: String){
        let path = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(soundName)
        do {
            try player = AVAudioPlayer(contentsOfURL: path)
            player.prepareToPlay()
            player.play()
        }
        catch {
            print("エラーです")
        }
    }
}