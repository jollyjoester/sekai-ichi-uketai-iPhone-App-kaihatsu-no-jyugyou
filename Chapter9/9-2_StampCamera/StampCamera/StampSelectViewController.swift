//
//  StampSelectViewController.swift
//  StampCamera
//
//
//  Copyright © 2015年 KuwamuraHaruyoshi. All rights reserved.
//

import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //画像を格納する配列
    var imageArray:[UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //配列imageArrayに1〜6.pngの画像データを格納
        for i in 1...6 {
            imageArray.append(UIImage(named: "\(i).png")!)
        }
    }
    //コレクションビューのアイテム数を設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //戻り値にimageArrayの要素数を設定
        return imageArray.count
    }
    //コレクションビューのセルを設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //UICollectionViewCellを使うための定数を作成
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //セルの中の画像を表示するImageViewのタグを指定
        let imageView = cell.viewWithTag(1) as! UIImageView
        //セルの中のImageViewに配列の中の画像データを表示
        imageView.image = imageArray[indexPath.row]
        //設定したセルを戻り値にする
        return cell
    }
    //スタンプ画面を閉じるメソッド
    @IBAction func closeTapped() {
        //モーダルで表示した画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    //コレクションビューのセルが選択された時のメソッド
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Stampインスタンスを作成
        let stamp = Stamp()
        //stampにインデックスパスからスタンプ画像を設定
        stamp.image = imageArray[indexPath.row]
        //AppDelegateのインスタンスを取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //配列stampArrayにstampを追加
        appDelegate.stampArray.append(stamp)
        //新規スタンプ追加フラグをtrueに設定
        appDelegate.isNewStampAdded = true
        //スタンプ選択画面を閉じる
        self.dismiss(animated: true, completion: nil)
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
