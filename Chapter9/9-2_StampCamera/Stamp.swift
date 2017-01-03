//
//  Stamp.swift
//  StampCamera
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit

class Stamp: UIImageView {
    //ユーザーが画面にタッチした時に呼ばれるメソッド
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //このクラスの親ビューを最前面に設定
        self.superview?.bringSubviewToFront(self)
    }
    //画面上で指が動いた時に呼ばれるメソッド
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //画面上のタッチ情報を取得
        let touch = touches.first!
        //画面上でドラッグしたx座標の移動距離
        let dx = touch.locationInView(self.superview).x - touch.previousLocationInView(self.superview).x
        //画面上でドラッグしたy座標の移動距離
        let dy = touch.locationInView(self.superview).y - touch.previousLocationInView(self.superview).y
        //このクラスの中心位置をドラッグした座標に設定
        self.center = CGPointMake(self.center.x + dx, self.center.y + dy)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
