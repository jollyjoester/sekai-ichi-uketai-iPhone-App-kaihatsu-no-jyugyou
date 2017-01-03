//
//  ViewController.swift
//  StampCamera
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerControllerで取得した画像を表示
    @IBOutlet var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //アクションシート表示メソッド
    @IBAction func cameraTapped() {
        //UIImagePickerControllerを使うための定数
        let pickerController = UIImagePickerController()
        //UIImagePickerControllerのデリゲートメソッドを使用する設定
        pickerController.delegate = self
        //UIAcionSheetを使うための定数を作成
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //3つのアクションボタンの定数を作成
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action) -> Void in })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (action) -> Void in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)})
        let LibraryAction = UIAlertAction(title: "Library", style: .default, handler: {
            (action) -> Void in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil) })
        //アクションシートにアクションボタンを追加
        sheet.addAction(cancelAction)
        sheet.addAction(cameraAction)
        sheet.addAction(LibraryAction)
        //アクションシートを表示
        self.present(sheet, animated: true, completion: nil)
    }
    //UIImagePickerController画像取得メソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //引数imageに格納された画像をmainImageViewにセット
        mainImageView.image = image
        //カメラ画面もしくはフォトライブラリ画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
