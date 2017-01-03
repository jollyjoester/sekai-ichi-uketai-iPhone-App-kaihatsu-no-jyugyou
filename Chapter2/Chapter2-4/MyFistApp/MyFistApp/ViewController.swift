//
//  ViewController.swift
//  MyFistApp
//
//  Created by SaChico on 2015/12/05.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tappedButton(sender: AnyObject) {
        label.text = "めでたい!!"
    }
}










