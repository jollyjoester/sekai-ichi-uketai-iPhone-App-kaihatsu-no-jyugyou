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
    func sePlay(_ soundName: String){
        let path = Bundle.main.bundleURL.appendingPathComponent(soundName)
        do {
            try player = AVAudioPlayer(contentsOf: path)
            player.prepareToPlay()
            player.play()
        }
        catch {
            print("エラーです")
        }
    }
}
