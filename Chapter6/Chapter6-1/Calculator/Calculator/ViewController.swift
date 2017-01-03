//
//  ViewController.swift
//  Calculator
//
//  Created by SaChico on 2015/12/07.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var resultLabel = UILabel()
    let xButtonCount = 4	//1行に配置するボタンの数
    let yButtonCount = 4	//1列に配置するボタンの数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //画面の横幅のサイズを格納するメンバ変数
        let screenWidth:Double = Double(UIScreen.mainScreen().bounds.size.width)
        //画面の縦幅
        let screenHeight:Double = Double(UIScreen.mainScreen().bounds.size.height)
        //ボタン間の余白(縦) & (横)
        let buttonMargin = 10.0
        // 計算結果表示エリアの縦幅
        var resultArea = 0.0
        // 画面全体の縦幅に応じて計算結果表示エリアの縦幅を決定
        switch screenHeight {
        case 480:
            resultArea = 200.0
        case 568:
            resultArea = 250.0
        case 667:
            resultArea = 300.0
        case 736:
            resultArea = 350.0
        default:
            resultArea = 0.0
        }
        //計算結果ラベルのフレームを設定。
        resultLabel.frame = CGRect(x: 10, y: 30, width: screenWidth - 20, height: resultArea - 30)

        //計算結果ラベルの背景色を灰色にする
        resultLabel.backgroundColor = UIColor.grayColor()
        //計算結果ラベルのフォントと文字サイズを設定
        resultLabel.font = UIFont(name: "Arial", size: 50)
        //計算結果ラベルのアラインメントを右揃えに設定
        resultLabel.textAlignment = NSTextAlignment.Right
        //計算結果ラベルの表示行数を4行に設定
        resultLabel.numberOfLines = 4
        //計算結果ラベルの初期値を"0"に設定
        resultLabel.text = "0"
        //計算結果ラベルをViewControllerクラスのviewに設置
        self.view.addSubview(resultLabel)
        
        // ボタンのラベルタイトルを配列で用意
        let buttonLabels = [
            "7","8","9","×",
            "4","5","6","-",
            "1","2","3","+",
            "0","C","÷","="
        ]
        
        for var y = 0; y < yButtonCount; y++ {
            for var x = 0; x < xButtonCount; x++ {
                //計算機のボタンを作成
                let button = UIButton()
                // ボタンの横幅サイズ作成
                let buttonWidth =  (screenWidth - (buttonMargin * (Double(xButtonCount)+1))) / Double(xButtonCount)
                //ボタンの縦幅サイズ作成
                let buttonHeight = (screenHeight - resultArea - ((buttonMargin*Double(yButtonCount)+1))) / Double(yButtonCount)
                //ボタンのX座標
                let buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) *  Double(x) + buttonMargin
                //ボタンのY座標
                let buttonPositionY = ( screenHeight - resultArea - buttonMargin ) / Double(yButtonCount) * Double(y) + buttonMargin + resultArea
                // ボタンの縦幅サイズ作成
                button.frame = CGRect(x:buttonPositionX,y: buttonPositionY, width:buttonWidth,height:buttonHeight)
                // ボタン背景色設定
                button.backgroundColor = UIColor.greenColor()
                //ボタンのラベルタイトルを取り出すインデックス番号
                let buttonNumber = y * xButtonCount + x
                //ボタンのラベルタイトルを設定
                button.setTitle(buttonLabels[buttonNumber], forState: UIControlState.Normal)

                // ボタン配置
                self.view.addSubview(button)
            }
        }
        
        //print文で画面サイズをデバッグエリアで確認する
        print("縦画面サイズ\(screenHeight)　横画面サイズ\(screenWidth)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

