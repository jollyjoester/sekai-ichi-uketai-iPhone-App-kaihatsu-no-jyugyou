//
//  ViewController.swift
//  StampCamera
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerControllerで取得した画像を表示
    @IBOutlet var mainImageView: UIImageView!
    //スタンプ画像を配置するUIView
    @IBOutlet var canvasView: UIView!
    //AppDelegateを使うための変数
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //アクションシート表示メソッド
    @IBAction func cameraTapped() {
        //UIImagePickerControllerを使うための定数
        let pickerController = UIImagePickerController()
        
        //UIImagePickerControllerのデリゲートメソッドを使用する設定
        pickerController.delegate = self

        //UIAcionSheetを使うための定数を作成
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        //3つのアクションボタンの定数を作成
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (action) -> Void in
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (action) -> Void in
            pickerController.sourceType = .Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
        })
        let LibraryAction = UIAlertAction(title: "Library", style: .Default, handler: {
            (action) -> Void in
            pickerController.sourceType = .PhotoLibrary
            self.presentViewController(pickerController, animated: true, completion: nil)
        })
        
        //アクションシートにアクションボタンを追加
        sheet.addAction(cancelAction)
        sheet.addAction(cameraAction)
        sheet.addAction(LibraryAction)
        
        //アクションシートを表示
        self.presentViewController(sheet, animated: true, completion: nil)
    }
    
    //UIImagePickerController画像取得メソッド
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //引数imageに格納された画像をmainImageViewにセット
        mainImageView.image = image
        //カメラ画面もしくはフォトライブラリ画面を閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //スタンプ選択画面遷移メソッド
    @IBAction func stampTapped() {
        //SegueのIdentifierを設定
        self.performSegueWithIdentifier("ToStampList", sender: self)
    }
    //画面表示の直前に呼ばれるメソッド
    override func viewWillAppear(animated: Bool) {
        //viewWillappearを上書きするときに必要な処理
        super.viewWillAppear(animated)
        //新規スタンプ画像フラグがtrueの場合、実行する処理
        if appDelegate.isNewStampAdded == true {
            //stampArrayの最後に入っている要素を取得
            let stamp = appDelegate.stampArray.last!
            //スタンプのフレームを設定
            stamp.frame = CGRectMake(0, 0, 100, 100)
            //スタンプの設置座標を写真画像の中心に設定
            stamp.center = mainImageView.center
            //スタンプのタッチ操作を許可
            stamp.userInteractionEnabled = true
            //スタンプを自分で配置したViewに設置
            canvasView.addSubview(stamp)
            //新規スタンプ画像フラグをfalseに設定
            appDelegate.isNewStampAdded = false
        }
    }
    //スタンプ画像の削除
    @IBAction func deleteTapped() {
        //canvasViewのサブビューの数が1より大きかったら実行
        if canvasView.subviews.count > 1 {
            //canvasViewの子ビューの最後のものを取り出す
            let lastStamp = canvasView.subviews.last! as! Stamp
            //canvasViewからlastStampを削除する
            lastStamp.removeFromSuperview()
            //lastStampが格納されているstampArrayのインデックス番号を取得
            if let index = appDelegate.stampArray.indexOf(lastStamp) {
                //stampArrayからlastStampを削除
                appDelegate.stampArray.removeAtIndex(index)
            }
        }
    }
    //画像をレンダリングして保存
    @IBAction func saveTapped() {
        //画像コンテキストをサイズ、透過の有無、スケールを指定して作成
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, canvasView.opaque, 0.0)
        //canvasViewのレイヤーをレンダリング
        canvasView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        //レンダリングした画像を取得
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //画像コンテキストを破棄
        UIGraphicsEndImageContext()
        //取得した画像をフォトライブラリへ保存
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    //写真の保存後に呼ばれるメソッド
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        let alert = UIAlertController(title: "保存", message: "保存完了です。", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: {(action)-> Void in})
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}