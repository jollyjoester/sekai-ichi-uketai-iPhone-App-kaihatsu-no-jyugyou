//
//  SEManager.swift
//  WinePiano
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import Foundation
import AVFoundation //AVFoundationフレームワークをインポートする
//NSObjectを親クラスとしたSEManagerクラスの宣言
class SEManager: NSObject, AVAudioPlayerDelegate {
    //var player:AVAudioPlayer! <-削除
    //AVAudioPlayerを格納する空の配列を宣言
    var soundArray = [AVAudioPlayer]()
    //音を再生するsePlayメソッド
    func sePlay(_ soundName: String) {
        let path = Bundle.main.bundleURL.appendingPathComponent(soundName)
        var player: AVAudioPlayer!
        do {
            try player = AVAudioPlayer(contentsOf: path)
            //配列soundArrayにplayerを追加
            soundArray.append(player)
            player.delegate = self
            player.prepareToPlay()
            player.play()
        }
        catch {
            print("エラーです")
        }
    }
    
    //サウンドの再生後に実行されるメソッド
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //再生が終わった変数のインデックスを調べる
        let i: Int = soundArray.index(of: player)!
        //上記で調べたインデックスの要素を削除する。
        soundArray.remove(at: i)
    }
}
