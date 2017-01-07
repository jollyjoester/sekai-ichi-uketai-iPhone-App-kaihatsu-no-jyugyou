//
//  Stamp.swift
//  StampCamera
//
//  Created by SaChico on 2015/12/17.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class Stamp: UIImageView {
    //ユーザーが画面にタッチした時に呼ばれるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //このクラスの親ビューを最前面に設定
        self.superview?.bringSubview(toFront: self)
    }
    //画面上で指が動いた時に呼ばれるメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //画面上のタッチ情報を取得
        let touch = touches.first!
        //画面上でドラッグしたx座標の移動距離
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        //画面上でドラッグしたy座標の移動距離
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        //このクラスの中心位置をドラッグした座標に設定
        self.center = CGPoint(x: self.center.x + dx,y: self.center.y + dy)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
