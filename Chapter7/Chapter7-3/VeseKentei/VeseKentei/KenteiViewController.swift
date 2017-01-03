//
//  KenteiViewController.swift
//  VeseKentei
//
//  Created by SaChico on 2015/12/13.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class KenteiViewController: UIViewController {
    @IBOutlet weak var mondaiNumberLabel: UILabel!
    @IBOutlet weak var mondaiTextView: UITextView!
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    //kentei.csvファイルを格納する配列csvArray
    var csvArray:[String] = []
    //csvArrayから取り出した問題を格納する配列mondaiArray
    var mondaiArray:[String] = []
    var mondaiCount = 0     //問題をカウントする変数
    var correctCount = 0    //正解をカウントする変数
    let total = 10          //出題数を管理する変数
    //解説バッグラウンド画像
    var kaisetsuBGImageView = UIImageView()
    //解説バックグラウンド画像のX座標
    var kaisetsuBGX = 0.0
    //正解表示ラベル
    var seikaiLabel = UILabel()
    //解説テキストビュー
    var kaisetsuTextView = UITextView()
    //バックボタン
    var backBtn = UIButton()
    //SEManagerクラスのインスタンスを作成
    var soundManager = SEManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        //バックグラウンド画像をセット
        kaisetsuBGImageView.image = UIImage(named: "kaisetsuBG.png")
        //画面サイズを取得
        let screenSize:CGSize = UIScreen.mainScreen().bounds.size
        //解説バッググラウンド画像のX座標（画面の中央になるなうように設定）
        kaisetsuBGX = Double(screenSize.width/2) - 320/2
        //解説画像の位置を設定。Y座標に画面の縦サイズを設定して、画面の外に設置
        kaisetsuBGImageView.frame = CGRect(x:kaisetsuBGX, y: Double(screenSize.height), width: 320, height: 210)
        //画像上のタッチ操作を可能にする
        kaisetsuBGImageView.userInteractionEnabled = true
        //画像をviewに配置
        self.view.addSubview(kaisetsuBGImageView)
        //正解表示ラベルのフレームを設定
        seikaiLabel.frame = CGRect(x: 10, y: 5, width: 300, height: 30)
        //正解表示ラベルのアラインメントをセンターに設定
        seikaiLabel.textAlignment = .Center
        //正解表示ラベルのフォントサイズを15ポイント設定
        seikaiLabel.font = UIFont.systemFontOfSize(15)
        //正解ラベルを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(seikaiLabel)
        //解説テキストビューのフレームを設定
        kaisetsuTextView.frame = CGRect(x: 10, y: 40, width: 300, height: 140)
        //解説テキストビューの背景色を透明に設定
        kaisetsuTextView.backgroundColor = UIColor.clearColor()
        //解説テキストビューのフォントサイズを17ポイントに設定
        kaisetsuTextView.font = UIFont.systemFontOfSize(17)
        //解説テキストビューの編集を不可に設定
        kaisetsuTextView.editable = false
        //解説テキストビューを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(kaisetsuTextView)
        //バックボタンのフレームを設定
        backBtn.frame = CGRect(x: 10, y: 180, width: 300, height: 30)
        //バックボタンに通常時と押下時の画像を設定
        backBtn.setImage(UIImage(named: "kenteiBack.png"), forState: .Normal)
        backBtn.setImage(UIImage(named: "kenteiBackOn.png"),forState: .Highlighted)
        //バックボタンにアクション設定
        backBtn.addTarget(self, action: "backBtnTapped", forControlEvents: UIControlEvents.TouchUpInside)
        //バックボタンを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(backBtn)
        //変数viewControllerを作成
        let viewController = ViewController()
        //loadCSVメソッドを使用し、csvArrayに検定問題を格納
        csvArray = viewController.loadCSV("kentei")
        //シャッフルメソッドを使用し、検定問題を並び替えてcsvArrayに格納
        csvArray = mondaiShuffle()
        //csvArrayの0行目を取り出し、カンマを区切りとしてmondaiArrayに格納
        mondaiArray = csvArray[mondaiCount].componentsSeparatedByString(",")
        //変数mondaiCountに1を足して、ラベルに出題数を設定
        mondaiNumberLabel.text = "第\(mondaiCount+1)問"
        //TextViewに問題を設定
        mondaiTextView.text = mondaiArray[0]
        //選択肢ボタンのタイトルに選択肢を設定
        answerBtn1.setTitle(mondaiArray[2], forState: .Normal)
        answerBtn2.setTitle(mondaiArray[3], forState: .Normal)
        answerBtn3.setTitle(mondaiArray[4], forState: .Normal)
        answerBtn4.setTitle(mondaiArray[5], forState: .Normal)
    }
    //四択ボタンを押したときのメソッド
    @IBAction func btnAction(sender: UIButton){
        //正解番号（Int型にキャスト）ボタンのtagが同じなら正解
        if sender.tag == Int(mondaiArray[1]){
            //○を表示
            judgeImageView.image = UIImage(named: "maru.png")
            //SEManagerクラスのsePlayメソッドで正解音を鳴らす
            soundManager.sePlay("right.mp3")
            //正解カウントを増やす
            correctCount++
        }else{
            //間違っていたら×を表示
            judgeImageView.image = UIImage(named: "batsu.png")
            //SEManagerクラスのsePlayメソッドで不正解音を鳴らす
            soundManager.sePlay("mistake.mp3")
        }
        //judgeImageViewを表示
        judgeImageView.hidden = false
        //解説を呼び出すメソッド
        kaisetsu()
    }
    //次の問題を表示するメソッド
    func nextProblem(){
        //問題カウント変数をカウントアップ
        mondaiCount++
        //mondaiArrayに格納されている問題配列を削除
        mondaiArray.removeAll()
        //if-else文を追加。mondaiCountがtotalに達したら画面遷移
        if mondaiCount < total{
            //csvArrayから次の問題配列をmondaiArrayに格納
            mondaiArray = csvArray[mondaiCount].componentsSeparatedByString(",")
            //問題数ラベル、問題表示TextView、選択肢ボタンに文字をセット
            mondaiNumberLabel.text = "第\(mondaiCount+1)問"
            mondaiTextView.text = mondaiArray[0]
            answerBtn1.setTitle(mondaiArray[2], forState: .Normal)
            answerBtn2.setTitle(mondaiArray[3], forState: .Normal)
            answerBtn3.setTitle(mondaiArray[4], forState: .Normal)
            answerBtn4.setTitle(mondaiArray[5], forState: .Normal)
        }else{
            //Stroyboard SegueのIdentifierを引数に設定して画面遷移
            performSegueWithIdentifier("score", sender: nil)
        }
    }
    //解説表示メソッド
    func kaisetsu(){
        //正解表示ラベルのテキストをmondaiArrayから取得
        seikaiLabel.text = mondaiArray[6]
        //解説テキストビューのテキストをmondaiArrayから取得
        kaisetsuTextView.text = mondaiArray[7]
        //answerBtn1のy座標を取得
        let answerBtnY = answerBtn1.frame.origin.y
        //解説バックグラウンド画像を表示させるアニメーション
        UIView.animateWithDuration(0.5, animations: {() -> Void in self.kaisetsuBGImageView.frame = CGRect(x: self.kaisetsuBGX, y: Double(answerBtnY), width: 320, height: 210)
        })
        //選択肢ボタンの使用停止
        answerBtn1.enabled = false
        answerBtn2.enabled = false
        answerBtn3.enabled = false
        answerBtn4.enabled = false
    }
    //バックボタンメソッド
    func backBtnTapped(){
        //画面の縦サイズを取得
        let screenHeight = Double(UIScreen.mainScreen().bounds.size.height)
        //解説バックグラウンド画像を枠外に移動させるアニメーション
        UIView.animateWithDuration(0.5, animations: {() -> Void in self.kaisetsuBGImageView.frame = CGRect(x: self.kaisetsuBGX, y: screenHeight, width: 320, height: 210)
        })
        //選択肢ボタンの使用を再開
        answerBtn1.enabled = true
        answerBtn2.enabled = true
        answerBtn3.enabled = true
        answerBtn4.enabled = true
        //正誤表示画像を隠す
        judgeImageView.hidden = true
        //nextProblemメソッドを呼び出す
        nextProblem()
    }
    //得点画面へ値を渡す
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sVC = segue.destinationViewController as! ScoreViewController
        sVC.correct = correctCount
    }
    //配列シャッフルメソッド
    func mondaiShuffle()->[String]{
        var array = [String]()  //String型の配列を宣言
        //csvArrayをNSMutableArrayに変換してsortedArrayに格納
        let sortedArray = NSMutableArray(array: csvArray)
        //sortedArrayの配列数を取得
        var arrayCount = sortedArray.count
        //while文で配列の要素数だけ繰り返し処理をする
        while(arrayCount > 0){
            //ランダムなインデックス番号を取得するため配列数の範囲で乱数を作る
            let randomIndex = arc4random() % UInt32(arrayCount)
            //sortedArrayのarrayCount番号とランダム番号を入れ替える
            sortedArray.exchangeObjectAtIndex((arrayCount-1),withObjectAtIndex: Int(randomIndex))
            //arrayCountを1減らす
            arrayCount = arrayCount-1
            //sortedArrayのarrayCount番号の要素をarrayに追加
            array.append(sortedArray[arrayCount] as! String)
        }
        //arrayを戻り値にする
        return array
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
