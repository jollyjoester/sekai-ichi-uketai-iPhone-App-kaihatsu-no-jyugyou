//
//  ViewController.swift
//  Calculator
//
//  Created by SaChico on 2015/12/07.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var resultLabel = UILabel()
    let xButtonCount = 4	//1行に配置するボタンの数
    let yButtonCount = 4	//1列に配置するボタンの数
    
    var number1:NSDecimalNumber = 0.0 // 入力数値を格納する変数1
    var number2:NSDecimalNumber = 0.0 // 入力数値を格納する変数2
    var result:NSDecimalNumber = 0.0 // 計算結果を格納する変数
    var operatorId:String = "" // 演算子を格納する変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //画面の背景色を設定
        self.view.backgroundColor = UIColor.black
        //画面の横幅のサイズを格納するメンバ変数
        let screenWidth:Double = Double(UIScreen.main.bounds.size.width)
        //画面の縦幅
        let screenHeight:Double = Double(UIScreen.main.bounds.size.height)
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
        //resultLabel.backgroundColor = UIColor.grayColor()
        resultLabel.backgroundColor = self.colorWithRGBHex(0xF5F5DC, alpha: 1.0)
        //計算結果ラベルのフォントと文字サイズを設定
        resultLabel.font = UIFont(name: "Arial", size: 50)
        //計算結果ラベルのアラインメントを右揃えに設定
        resultLabel.textAlignment = NSTextAlignment.right
        //計算結果ラベルの表示行数を4行に設定
        resultLabel.numberOfLines = 4
        //計算結果ラベルの初期値を"0"に設定
        resultLabel.text = "0"
        // 計算結果ラベルのフォントと文字サイズを設定
        resultLabel.font = UIFont(name:"LetsgoDigital-Regular",size:50)
        //計算結果ラベルをViewControllerクラスのviewに設置
        self.view.addSubview(resultLabel)
        
        // ボタンのラベルタイトルを配列で用意
        let buttonLabels = [
            "7","8","9","×",
            "4","5","6","-",
            "1","2","3","+",
            "0","C","÷","="
        ]
        
        for y in 0 ..< yButtonCount {
            for x in 0 ..< xButtonCount {
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
//                // ボタン背景色設定
//                button.backgroundColor = UIColor.greenColor()
                //ボタン背景をグラデーション色設定
                let gradient = CAGradientLayer()
                gradient.frame = button.bounds
                let arrayColors = [ colorWithRGBHex(0xFFFFFF, alpha: 1.0).cgColor as AnyObject, colorWithRGBHex(0xCCCCCC, alpha: 1.0).cgColor as AnyObject]
                gradient.colors = arrayColors
                button.layer.insertSublayer(gradient, at: 0)
                //ボタンを角丸にする
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 5.0
                // ボタンのテキストカラーを設定
                button.setTitleColor(UIColor.black,for: UIControlState())
                button.setTitleColor(UIColor.gray,for:UIControlState.highlighted)
                //ボタンのラベルタイトルを取り出すインデックス番号
                let buttonNumber = y * xButtonCount + x
                //ボタンのラベルタイトルを設定
                button.setTitle(buttonLabels[buttonNumber], for: UIControlState())
                // ボタンタップ時のアクション設定
                button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)),  for: UIControlEvents.touchUpInside)
                // ボタン配置
                self.view.addSubview(button)
            }
        }
        //print文で画面サイズをデバッグエリアで確認する
        print("縦画面サイズ\(screenHeight)　横画面サイズ\(screenWidth)")
    }
    
    // ボタンがタップされた時のメソッド
    func buttonTapped(_ sender:UIButton){
        let tappedButtonTitle:String = sender.currentTitle!
        print("\(tappedButtonTitle)ボタンが押されました!")
        // ボタンのタイトルで条件分岐
        switch tappedButtonTitle {
        case "0","1","2","3","4","5","6","7","8","9": //数字ボタン
            numberButtonTapped(tappedButtonTitle)
        case "×","-","+","÷":    //演算子ボタン
            operatorButtonTapped(tappedButtonTitle)
        case "=":      //等号ボタン
            equalButtonTapped(tappedButtonTitle)
        default:      //クリアボタン
            clearButtonTapped(tappedButtonTitle)
        }
    }
    func numberButtonTapped(_ tappedButtonTitle:String){
        print("数字ボタンタップ：\(tappedButtonTitle)")
        // タップされた数字タイトルを計算できるようにNSDecimalNumber型に変換
        let tappedButtonNum:NSDecimalNumber = NSDecimalNumber(string: tappedButtonTitle)
        // 入力されていた値を10倍にして1桁大きくして、その変換した数値を加算
        number1 = number1.multiplying (by: NSDecimalNumber(string: "10")).adding(tappedButtonNum)
        // 計算結果ラベルに表示
        resultLabel.text = number1.stringValue
    }
    func operatorButtonTapped(_ tappedButtonTitle:String){
        print("演算子ボタンタップ:\(tappedButtonTitle)")
        operatorId = tappedButtonTitle
        number2 = number1
        number1 = NSDecimalNumber(string: "0")
    }
    func equalButtonTapped(_ tappedButtonTitle:String){
        print("等号ボタンタップ:\(tappedButtonTitle)")
        switch operatorId {
        case "+":
            result = number2.adding(number1)
        case "-":
            result = number2.subtracting(number1)
        case "×":
            result = number2.multiplying(by: number1)
        case "÷":
            if(number1.isEqual(to: 0)){
                number1 = 0
                resultLabel.text = "無限大"
                return
            } else {
                result = number2.dividing(by: number1)
            }
        default:
            print("その他")
        }
        number1 = result
        resultLabel.text = String("\(result)")
    }
    func clearButtonTapped(_ tappedButtonTitle:String){
        print("クリアボタンタップ:\(tappedButtonTitle)")
        number1 = NSDecimalNumber(string: "0")
        number2 = NSDecimalNumber(string: "0")
        result = NSDecimalNumber(string: "0")
        operatorId = ""
        resultLabel.text = "0"
    }
    // HEX値で設定メソッド
    func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        return UIColor(red: CGFloat(r / 255.0),green: CGFloat(g / 255.0),blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

