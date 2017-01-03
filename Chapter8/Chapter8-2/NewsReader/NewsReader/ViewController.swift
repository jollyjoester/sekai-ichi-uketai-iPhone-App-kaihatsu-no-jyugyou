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

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    //ニュース一覧データを格納する配列
    var newsDataArray = NSArray()
    //テーブルビュー
    @IBOutlet var table :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table ViewのDataSource参照先指定
        table.dataSource = self
        // Table Viewのタップ時のdelegate先を指定
        table.delegate = self
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
                //ニュース記事を取得したらテーブルビューに表示
                self.table.reloadData()
            case .Failure(let error):
                print("通信エラー:\(error)")
            }
        }
        //ニュース記事データをテーブルビューに表示
    }
    //テーブルビューのセルの数をnewsDataArrayに格納しているデータの数で設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return newsDataArray.count
    }
    //セルに表示する内容を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath  indexPath: NSIndexPath) -> UITableViewCell {
        // StoryBoardで取得したCellを取得
        let cell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        // ニュース記事データを取得（配列の"indexPath.row"番目の要素を取得）
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        // タイトルとタイトルの行数、公開日時をCellにセット
        cell.textLabel!.text = newsDic["title"] as? String
        cell.textLabel!.numberOfLines = 3
        cell.detailTextLabel!.text = newsDic["publishedDate"] as? String
        return cell
    }
    //テーブルビューのセルがタップされた処理
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            //セルのインデックスパス番号を出力
            print("タップされたセルのインデックスパス:\(indexPath.row)")
            // ニュース記事データを取得（配列の要素で"indexPath.row"番目の要素を取得）
            let newsDic = newsDataArray[indexPath.row] as! NSDictionary
            // ニュース記事のURLを取得
            let newsUrl = newsDic["unescapedUrl"] as! String
            // StringをNSURLに変換
            let url = NSURL(string:newsUrl)!
            //UIApplicationインスタンスを作成
            let app = UIApplication.sharedApplication()
            //openURLメソッドでURLを引数にWEBブラウザSafariを起動
            app.openURL(url)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

