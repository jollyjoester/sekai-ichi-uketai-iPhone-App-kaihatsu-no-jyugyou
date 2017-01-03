//
//  ViewController.swift
//  ShingoHaNaniiro
//
//  Created by SaChico on 2015/12/01.
//  Copyright © 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blueBtnPushed(sender: AnyObject) {
        resultLabel.text = "しんごうはあおいろ!"
        resultLabel.textColor = UIColor.blueColor()
    }
    @IBAction func yellowBtnPushed(sender: AnyObject) {
        resultLabel.text = "しんごうはきいろ!"
        resultLabel.textColor = UIColor.yellowColor()
    }
    @IBAction func redBtnPushed(sender: AnyObject) {
        resultLabel.text = "しんごうはあかいろ!"
        resultLabel.textColor = UIColor.redColor()
    }
}

