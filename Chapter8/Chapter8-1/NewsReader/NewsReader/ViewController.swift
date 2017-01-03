//
//  ViewController.swift
//  NewsReader
//
//  Created by SaChico on 2015/12/15.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit
//Alamofireライブラリをインポート
import Alamofire

class ViewController: UIViewController {
    //ニュース一覧データを格納する配列
    var newsDataArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        //ニュース情報の取得先
        let requestUrl = "http://appcre.net/rss.php"
        //Webサーバに対してHTTP通信のリクエストを出してデータを取得
        Alamofire.request(.GET, requestUrl).responseJSON { response in
            switch response.result {
            case .Success(let json):
                //JSONデータをNSDictionaryに
                let jsonDic = json as! NSDictionary
                // 辞書化した jsonDic からキー値 "responseData" を取り出す
                let responseData = jsonDic["responseData"] as! NSDictionary
                //responseData からキー値 "results" を取り出す
                self.newsDataArray = responseData["results"] as! NSArray
                print("\(self.newsDataArray)")
            case .Failure(let error):
                print("通信エラー:\(error)")
            }
        }
        //ニュース記事データをテーブルビューに表示
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

