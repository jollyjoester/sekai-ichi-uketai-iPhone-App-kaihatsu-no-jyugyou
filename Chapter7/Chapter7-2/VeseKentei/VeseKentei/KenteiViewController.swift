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

    override func viewDidLoad() {
        super.viewDidLoad()
        //バックグラウンド画像をセット
        kaisetsuBGImageView.image = UIImage(named: "kaisetsuBG.png")
        //画面サイズを取得
        let screenSize:CGSize = UIScreen.main.bounds.size
        //解説バッググラウンド画像のX座標（画面の中央になるなうように設定）
        kaisetsuBGX = Double(screenSize.width/2) - 320/2
        //解説画像の位置を設定。Y座標に画面の縦サイズを設定して、画面の外に設置
        kaisetsuBGImageView.frame = CGRect(x:kaisetsuBGX, y: Double(screenSize.height), width: 320, height: 210)
        //画像上のタッチ操作を可能にする
        kaisetsuBGImageView.isUserInteractionEnabled = true
        //画像をviewに配置
        self.view.addSubview(kaisetsuBGImageView)
        //正解表示ラベルのフレームを設定
        seikaiLabel.frame = CGRect(x: 10, y: 5, width: 300, height: 30)
        //正解表示ラベルのアラインメントをセンターに設定
        seikaiLabel.textAlignment = .center
        //正解表示ラベルのフォントサイズを15ポイント設定
        seikaiLabel.font = UIFont.systemFont(ofSize: 15)
        //正解ラベルを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(seikaiLabel)
        //解説テキストビューのフレームを設定
        kaisetsuTextView.frame = CGRect(x: 10, y: 40, width: 300, height: 140)
        //解説テキストビューの背景色を透明に設定
        kaisetsuTextView.backgroundColor = UIColor.clear
        //解説テキストビューのフォントサイズを17ポイントに設定
        kaisetsuTextView.font = UIFont.systemFont(ofSize: 17)
        //解説テキストビューの編集を不可に設定
        kaisetsuTextView.isEditable = false
        //解説テキストビューを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(kaisetsuTextView)
        //バックボタンのフレームを設定
        backBtn.frame = CGRect(x: 10, y: 180, width: 300, height: 30)
        //バックボタンに通常時と押下時の画像を設定
        backBtn.setImage(UIImage(named: "kenteiBack.png"), for: .normal)
        backBtn.setImage(UIImage(named: "kenteiBackOn.png"),for: .highlighted)
        //バックボタンにアクション設定
        backBtn.addTarget(self, action: #selector(KenteiViewController.backBtnTapped), for: UIControlEvents.touchUpInside)
        //バックボタンを解説バックグラウンド画像に配置
        kaisetsuBGImageView.addSubview(backBtn)
        //変数viewControllerを作成
        let viewController = ViewController()
        //loadCSVメソッドを使用し、csvArrayに検定問題を格納
        csvArray = viewController.loadCSV("kentei")
        //csvArrayの0行目を取り出し、カンマを区切りとしてmondaiArrayに格納
        mondaiArray = csvArray[mondaiCount].components(separatedBy: ",")
        //変数mondaiCountに1を足して、ラベルに出題数を設定
        mondaiNumberLabel.text = "第\(mondaiCount+1)問"
        //TextViewに問題を設定
        mondaiTextView.text = mondaiArray[0]
        //選択肢ボタンのタイトルに選択肢を設定
        answerBtn1.setTitle(mondaiArray[2], for: .normal)
        answerBtn2.setTitle(mondaiArray[3], for: .normal)
        answerBtn3.setTitle(mondaiArray[4], for: .normal)
        answerBtn4.setTitle(mondaiArray[5], for: .normal)
    }
    //四択ボタンを押したときのメソッド
    @IBAction func btnAction(_ sender: UIButton){
        //正解番号（Int型にキャスト）ボタンのtagが同じなら正解
        if sender.tag == Int(mondaiArray[1]){
            //○を表示
            judgeImageView.image = UIImage(named: "maru.png")
            //正解カウントを増やす
            correctCount += 1
        }else{
            //間違っていたら×を表示
            judgeImageView.image = UIImage(named: "batsu.png")
        }
        //judgeImageViewを表示
        judgeImageView.isHidden = false
        //解説を呼び出すメソッド
        kaisetsu()
    }
    //次の問題を表示するメソッド
    func nextProblem(){
        //問題カウント変数をカウントアップ
        mondaiCount += 1
        //mondaiArrayに格納されている問題配列を削除
        mondaiArray.removeAll()
        //if-else文を追加。mondaiCountがtotalに達したら画面遷移
        if mondaiCount < total{
            //csvArrayから次の問題配列をmondaiArrayに格納
            mondaiArray = csvArray[mondaiCount].components(separatedBy: ",")
            //問題数ラベル、問題表示TextView、選択肢ボタンに文字をセット
            mondaiNumberLabel.text = "第\(mondaiCount+1)問"
            mondaiTextView.text = mondaiArray[0]
            answerBtn1.setTitle(mondaiArray[2], for: .normal)
            answerBtn2.setTitle(mondaiArray[3], for: .normal)
            answerBtn3.setTitle(mondaiArray[4], for: .normal)
            answerBtn4.setTitle(mondaiArray[5], for: .normal)
        }else{
            //Stroyboard SegueのIdentifierを引数に設定して画面遷移
            performSegue(withIdentifier: "score", sender: nil)
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
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.kaisetsuBGImageView.frame = CGRect(x: self.kaisetsuBGX, y: Double(answerBtnY), width: 320, height: 210)
        })
        //選択肢ボタンの使用停止
        answerBtn1.isEnabled = false
        answerBtn2.isEnabled = false
        answerBtn3.isEnabled = false
        answerBtn4.isEnabled = false
    }
    //バックボタンメソッド
    func backBtnTapped(){
        //画面の縦サイズを取得
        let screenHeight = Double(UIScreen.main.bounds.size.height)
        //解説バックグラウンド画像を枠外に移動させるアニメーション
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.kaisetsuBGImageView.frame = CGRect(x: self.kaisetsuBGX, y: screenHeight, width: 320, height: 210)
        })
        //選択肢ボタンの使用を再開
        answerBtn1.isEnabled = true
        answerBtn2.isEnabled = true
        answerBtn3.isEnabled = true
        answerBtn4.isEnabled = true
        //正誤表示画像を隠す
        judgeImageView.isHidden = true
        //nextProblemメソッドを呼び出す
        nextProblem()
    }
    //得点画面へ値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! ScoreViewController
        sVC.correct = correctCount
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
