//
//  WebViewController.swift
//  NewsReader
//
//  Created by SaChico on 2015/12/16.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit
//UIWebViewDelegateのプロトコルを指定
class WebViewController: UIViewController,UIWebViewDelegate {
    //インディケータを使うための変数を作成
    var indicator = UIActivityIndicatorView()
    //UIWebViewを使うための変数を作成
    @IBOutlet var webview :UIWebView!
    //URLを格納するString変数を作成
    var newsUrl = "https://google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIWebViewDelegateの参照先を設定
        webview.delegate = self
        //インディケータを画面中央に設定
        indicator.center = self.view.center
        //インディケータのスタイルをグレーに設定
        indicator.activityIndicatorViewStyle =   UIActivityIndicatorViewStyle.Gray
        //インディケータをwebviewに設置
        webview.addSubview(indicator)
        //String変数newsUrlをNSURLに変換
        let url = NSURL(string :newsUrl)!
        //NSURLRequestにURL情報を渡す
        let urlRequest = NSURLRequest(URL: url)
        //URL情報を引数にUIWebViewクラスのロードメソッド実行
        webview.loadRequest(urlRequest)
    }
    
    //Webページの読み込み開始を通知
    func webViewDidStartLoad(webView: UIWebView) {
        //インディケータの表示アニメを開始
        indicator.startAnimating()
    }
    
    //Webページの読み込み終了を通知
    func webViewDidFinishLoad(webView: UIWebView) {
        //インディケータを停止
        indicator.stopAnimating()
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
